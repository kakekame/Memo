//
//  CoreDataManager.m
//  HelloCoreDataManager
//
//  Created by Kent Liu on 2016/10/5.
//  Copyright © 2016年 Kent Liu. All rights reserved.
//

#import "CoreDataManager.h"
#import <UIKit/UIKit.h>

@interface CoreDataManager () <NSFetchedResultsControllerDelegate>
{
    // Put variables here.
    
    NSString* modelFileName;
    NSString* dbFileName;
    NSURL *dbFileFullPathURL;
    NSString *dbSortKey;
    NSString *dbEntityName;
    
    SaveCompletion saveCompletion;
}

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

// For Data Fetch
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;


@end

@implementation CoreDataManager

- (instancetype) initWithModel:(NSString*)modelName
                    dbFileName:(NSString*)dbName
                 dbFilePathURL:(NSURL*)dbFilePathURL
                       sortKey:(NSString*)sortKey
                    entityName:(NSString*)entityName {
    
    self = [super init];
    // Keep variables
    modelFileName = modelName;
    dbFileName = dbName;
    dbFileFullPathURL = dbFilePathURL;
    dbSortKey = sortKey;
    dbEntityName = entityName;
    
    if(dbFileFullPathURL == nil) {
        // Use documents as default
        dbFileFullPathURL = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].firstObject;
    }
    
    return self;
}

#pragma mark - Core Dara Stack
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:modelFileName withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
//    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    NSURL *storeURL = [dbFileFullPathURL URLByAppendingPathComponent:dbFileName];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void) saveContextWithCompletion:(SaveCompletion)completion {
    
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        
        saveCompletion = completion;
        
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        // ...
    } else {
        completion(false);
    }
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:dbEntityName inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:dbSortKey ascending:true];
    
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:dbEntityName];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _fetchedResultsController;
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    if(saveCompletion != nil) {
        saveCompletion(true);
        saveCompletion = nil;
    }
}


#pragma mark - Public Methods
- (NSInteger) count {
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][0];
    return [sectionInfo numberOfObjects];
}
- (NSManagedObject*) createItem {
    
    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:dbEntityName inManagedObjectContext:self.managedObjectContext];
    
    return newManagedObject;
    
}
- (void) deleteItem: (NSManagedObject*) item {
    [self.managedObjectContext deleteObject:item];
}
- (NSManagedObject*) getByIndex:(NSInteger) index {
    
    NSIndexPath *targetIndexPath = [NSIndexPath indexPathForRow:index inSection:0];
    
    return [self.fetchedResultsController objectAtIndexPath:targetIndexPath];
    
}

- (NSArray*) searchFor:(NSString*) keyword atField:(NSString*) field {
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:dbEntityName];
    NSString *format = [NSString stringWithFormat:@"%@ contains[cd] %%@",field];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:format,keyword];
    request.predicate = predicate;
    
    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:nil];
    if(results.count > 0) {
        return results;
    } else {
        return nil;
    }
}




@end
