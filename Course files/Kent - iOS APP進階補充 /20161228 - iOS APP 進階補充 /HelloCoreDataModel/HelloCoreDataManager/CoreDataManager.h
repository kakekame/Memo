//
//  CoreDataManager.h
//  HelloCoreDataManager
//
//  Created by Kent Liu on 2016/10/5.
//  Copyright © 2016年 Kent Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

typedef void (^SaveCompletion)(BOOL success);

@interface CoreDataManager : NSObject

- (instancetype) initWithModel:(NSString*)modelName
                    dbFileName:(NSString*)dbName
                 dbFilePathURL:(NSURL*)dbFilePathURL
                       sortKey:(NSString*)sortKey
                    entityName:(NSString*)entityName;

- (void) saveContextWithCompletion:(SaveCompletion)completion;

- (NSInteger) count;
- (NSManagedObject*) createItem;
- (void) deleteItem: (NSManagedObject*) item;
- (NSManagedObject*) getByIndex:(NSInteger) index;
- (NSArray*) searchFor:(NSString*)keyword atField:(NSString*) field;

@end






