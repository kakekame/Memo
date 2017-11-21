//
//  MasterViewController.m
//  HelloRSSReader
//
//  Created by Kent Liu on 2016/3/9.
//  Copyright © 2016年 Kent Liu. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "Reachability.h"
#import "RSSParserDelegate.h"

@interface MasterViewController ()
{
    Reachability *yahooReach;
}

@property NSMutableArray *objects;
@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    self.navigationItem.leftBarButtonItem = self.editButtonItem;
//
//    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
//    self.navigationItem.rightBarButtonItem = addButton;

    // Add Refresh Button
    
    UIBarButtonItem *refreshBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(downloadNewsList)];
    self.navigationItem.rightBarButtonItem = refreshBtn;
    
    
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    // Prepare yahooReach
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkStatusChanged:) name:kReachabilityChangedNotification object:nil];
    
    yahooReach = [Reachability reachabilityWithHostName:@"tw.news.yahoo.com"];
    [yahooReach startNotifier];
    
}

- (void) networkStatusChanged:(NSNotification*)notify {
    
    NetworkStatus status = yahooReach.currentReachabilityStatus;
    
    if(status == NotReachable) {
        NSLog(@"Not Reachable!");
    } else {
        NSLog(@"Reachable with %ld",(long)status);
        [self downloadNewsList];
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
    if (!self.objects) {
        self.objects = [[NSMutableArray alloc] init];
    }
    [self.objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        NewsItem *object = self.objects[indexPath.row];
        
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        
        [controller setDetailItem:object];
        
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NewsItem *object = self.objects[indexPath.row];
    cell.textLabel.text = object.title;
    cell.detailTextLabel.text = object.pubDate;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

- (void) downloadNewsList {
    
    // Check network status
    if(yahooReach.currentReachabilityStatus == NotReachable) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"Can't access to server. Please check your network status." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:ok];
        [self presentViewController:alert animated:true completion:nil];
        
        return;
    }
    
    // Perform a real download.
    NSURL *url = [NSURL URLWithString:@"http://udn.com/rssfeed/news/1"];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    NSURLSessionDataTask *task = [session dataTaskWithURL:url
                                        completionHandler:
    ^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    
        // Check if there is any error.
        if(error) {
            NSLog(@"Error: %@",error.description);
            return;
        }
        
        // Convert data to NSString
        NSString *xmlString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"RSS XML: %@",xmlString);
        
        // Parse the data
        NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
        RSSParserDelegate *parserDelegate = [RSSParserDelegate new];
        parser.delegate = parserDelegate;
        
        if([parser parse]) {
            
            NSLog(@"Parse OK.");
            
            _objects = [NSMutableArray arrayWithArray:[parserDelegate getResults]];
            
            // Ask tableview to reload.
            dispatch_async(dispatch_get_main_queue(), ^{
               
                [self.tableView reloadData];
                
            });
            
            
        } else {
            
            NSLog(@"Parse Fail.");
            
        }
        
        
    
    }];
    
    [task resume];
    
    
}


@end







