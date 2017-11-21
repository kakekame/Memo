//
//  MasterViewController.m
//  HelloCoreDataManager
//
//  Created by Kent Liu on 2016/10/5.
//  Copyright © 2016年 Kent Liu. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "CoreDataManager.h"
#import "Friend+CoreDataClass.h"

@interface MasterViewController ()
{
    CoreDataManager *dataManager;
}


//@property NSMutableArray *objects;
@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    dataManager = [[CoreDataManager alloc] initWithModel:@"FriendModel" dbFileName:@"friends.sqlite" dbFilePathURL:nil sortKey:@"name" entityName:@"Friend"];
    
    // Demo for keyword search
    NSArray *results = [dataManager searchFor:@"kent" atField:@"name"];
    
    for(Friend *tmp in results) {
        NSLog(@"Found %@:%@",tmp.name,tmp.telephone);
    }
    
}


- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)insertNewObject:(id)sender {

    // Launch Editor to input data
    // Create a new item
    [self editInfoWithDefault:nil
               withCompletion:
     ^(bool success, Friend *result) {
        
         if(success == false) {
             return;
         }
         // Save
         [dataManager saveContextWithCompletion:^(BOOL success) {
             [self.tableView reloadData];
         }];
         
    }];
    
    

}


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
//        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//        NSDate *object = self.objects[indexPath.row];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
//        [controller setDetailItem:object];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

- (BOOL) shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    return false;
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [dataManager count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

//    NSDate *object = self.objects[indexPath.row];
//    cell.textLabel.text = [object description];
    
    Friend *friend = (Friend*) [dataManager getByIndex:indexPath.row];
    
    cell.textLabel.text = friend.name;
    cell.detailTextLabel.text = friend.telephone;
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Friend *friend = (Friend*)[dataManager getByIndex:indexPath.row];
    
    [self editInfoWithDefault:friend withCompletion:^(bool success, Friend *result) {
       
        if(success == false) {
            return;
        }
        // Save
        [dataManager saveContextWithCompletion:^(BOOL success) {
            [self.tableView reloadData];
        }];
    }];
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {

        Friend *friend = (Friend*)[dataManager getByIndex:indexPath.row];
        [dataManager deleteItem:friend];
        // Save
        [dataManager saveContextWithCompletion:^(BOOL success) {
            [self.tableView reloadData];
        }];
        
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

typedef void (^EditInfoCompletion)(bool success,Friend *result);

- (void) editInfoWithDefault:(Friend*) defaultInfo withCompletion:(EditInfoCompletion)completion {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Edit Contact" message:nil preferredStyle:UIAlertControllerStyleAlert];
    // Add Name Field
    [alert addTextFieldWithConfigurationHandler:
     ^(UITextField * _Nonnull textField) {
        
         textField.placeholder = @"Name";
//         textField.text = [defaultInfo valueForKey:@"name"];
         textField.text = defaultInfo.name;
    }];
    // Add Telephone Field
    [alert addTextFieldWithConfigurationHandler:
     ^(UITextField * _Nonnull textField) {
         
         textField.placeholder = @"Telephone";
//         textField.text = [defaultInfo valueForKey:@"telephone"];
         textField.text = defaultInfo.telephone;
     }];
    
    // Add OK Button
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        Friend *finalInfo = defaultInfo;
        if(finalInfo == nil) {  // Create new item if necessary.
            finalInfo = (Friend*)[dataManager createItem];
//            [finalInfo setValue:[NSDate date] forKey:@"creationDate"];
            finalInfo.creationDate = [NSDate date];
        }
//        [finalInfo setValue:alert.textFields[0].text forKey:@"name"];
//        [finalInfo setValue:alert.textFields[1].text forKey:@"telephone"];

        finalInfo.name = alert.textFields[0].text;
        finalInfo.telephone = alert.textFields[1].text;
        
        completion(true,finalInfo);
    }];
    [alert addAction:ok];

    // Add Cancel Button
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        completion(false,nil);
        
    }];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:true completion:nil];
    
}




@end
