//
//  ChatLogManager.m
//  HelloMySendMessage
//
//  Created by Kent Liu on 2016/6/24.
//  Copyright © 2016年 Kent Liu. All rights reserved.
//

#import "ChatLogManager.h"
#import <FMDatabase.h>
#import "Communicator.h"

#define MID_FIELD   @"mid"

@interface ChatLogManager ()
{
    NSString *dbFileNamePath;
    FMDatabase *db;
    NSMutableArray *midsArray;
}

@end

@implementation ChatLogManager

#pragma mark - Photo Cache Support

+ (void) savePhotoWithFileName:(NSString*)originalFileName data:(NSData*)data {

    NSURL *fullFilePathURL = [ChatLogManager getFullURLWithFileName:originalFileName];
    // Save File
    [data writeToURL:fullFilePathURL atomically:true];
    
}
+ (UIImage*) loadPhotoWithFileName: (NSString*)originalFileName {
    
    NSURL *fullFilePathURL = [ChatLogManager getFullURLWithFileName:originalFileName];
    // Save File
    NSData *data = [NSData dataWithContentsOfURL:fullFilePathURL];
    return [UIImage imageWithData:data];
}
+ (NSURL*) getFullURLWithFileName:(NSString*)originalFileName {
    // Find Cache Directory
    NSArray *cachesURLs = [[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask];
    NSURL *targetCacheURL = cachesURLs.firstObject;
    // Decide File Name
    NSString *fileName = [NSString stringWithFormat:@"%lu.jpg",(unsigned long)originalFileName.hash];
    NSURL *fullFilePathURL = [targetCacheURL URLByAppendingPathComponent:fileName];
    return fullFilePathURL;
}

#pragma mark - Chat Log Support

- (instancetype) init {
    self = [super init];
    
    midsArray = [NSMutableArray new];
    
    // Prepare dbFileNamePath
    NSArray *results = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true);
    NSString *documentsPath = results.firstObject;
    dbFileNamePath = [documentsPath stringByAppendingPathComponent:@"chatlog.sqlite"];
    
    // Prepare or Create db
    db = [FMDatabase databaseWithPath:dbFileNamePath];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:dbFileNamePath] == false) {
        // Create db
        if([db open]) {
            
            NSString *sqlCmd = @"CREATE TABLE IF NOT EXISTS chatlog_table(mid integer primary key autoincrement,id integer,UserName text,Message text,Type integer);";
            BOOL success = [db executeUpdate:sqlCmd];
            NSLog(@"Create DB Table: %@",(success?@"OK":@"NG"));
            [db close];
            
        }
    } else {
        // Prepare and load the id index first
        
        if([db open]) {
            
            FMResultSet *result = [db executeQuery:@"SELECT * from chatlog_table;"];
            
            while([result next]) {
                
                NSInteger mid = [result intForColumn:MID_FIELD];
                
                [midsArray addObject:@(mid)];
            }
            
            [db close];
        }
    }
    
    
    return self;
}

- (void) addChatLog:(NSDictionary*)messageDictionary {
    
    if([db open]) {
        
        NSString *sqlCmd = [NSString stringWithFormat:@"INSERT INTO chatlog_table(%@,%@,%@,%@) VALUES(?,?,?,?)",ID_KEY,USER_NAME_KEY,MESSAGE_KEY,TYPE_KEY];
        
        BOOL success = [db executeUpdate:sqlCmd
                        ,messageDictionary[ID_KEY]
                        ,messageDictionary[USER_NAME_KEY]
                        ,messageDictionary[MESSAGE_KEY]
                        ,messageDictionary[TYPE_KEY]];
        
        [db close];
        
        if(success) {
            
            NSInteger lastMID = [self getLastItemMID];
            [midsArray addObject:@(lastMID)];
            
        } else {
            NSLog(@"addChatLog fail.");
        }

        
    }
}

- (NSInteger) getLastItemMID {
    
    NSInteger resultMID;
    if([db open]) {
        
        FMResultSet *result = [db executeQuery:@"SELECT * FROM chatlog_table ORDER BY mid DESC LIMIT 1;"];
        
        while([result next]) {
            
            resultMID = [result intForColumn:MID_FIELD];
            
        }
        
        [db close];
    }
    return resultMID;
}

- (NSInteger) getTotalCount {
    
    return midsArray.count;
    // "SELECT COUNT(*) FROM chatlog_table;"
}
- (NSDictionary*) getMessageByIndex:(NSInteger)index {
    
    NSInteger targetMID = [midsArray[index] integerValue];
    NSDictionary *message;

    if([db open]) {
        NSString *sqlCmd = [NSString stringWithFormat:@"SELECT * FROM chatlog_table WHERE %@ = %ld;",MID_FIELD,targetMID];
        FMResultSet *result = [db executeQuery:sqlCmd];
        while([result next]) {
            message = @{ID_KEY:@([result intForColumn:ID_KEY]),
                        USER_NAME_KEY:[result stringForColumn:USER_NAME_KEY],
                        MESSAGE_KEY:[result stringForColumn:MESSAGE_KEY],
                        TYPE_KEY:@([result intForColumn:TYPE_KEY])};
        }
        [db close];
    }
    return message;
}


@end






