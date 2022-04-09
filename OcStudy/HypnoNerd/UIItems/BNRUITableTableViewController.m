//
//  BNRUITableTableViewController.m
//  HypnoNerd
//
//  Created by HuXin on 2021/7/13.
//

#import "BNRUITableTableViewController.h"
#import "ViewController.h"
#import "BNRReminderViewController.h"
#import "BNRItemsTableViewController.h"
#import "BNRDrawViewController.h"
#import "BNRCoursesViewController.h"
#import "MYMasonryViewController.h"
#import "MYScrollViewController.h"
#import "MYCollectionVIew.h"
#import "MYNsurlsession.h"
#import "MYAFNetworking.h"

@interface BNRUITableTableViewController ()

@end

@implementation BNRUITableTableViewController

- (instancetype)init {
    self = [super initWithStyle:UITableViewStylePlain];
    
    if (self) {        
        UINavigationItem *navItem = self.navigationItem;
        navItem.title = @"UIItems";
        
        
        UIImage *i = [UIImage imageNamed:@"ui.png"];
        self.tabBarItem.image = i;
    }
    
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:{
            ViewController *view = [[ViewController alloc] init];
            [self.navigationController pushViewController:view animated:YES];
        }break;
        case 1:
        {
            BNRReminderViewController *reminderView = [[BNRReminderViewController alloc] init];
            [self.navigationController pushViewController:reminderView animated:YES];
        }break;
        case 2:{
            BNRItemsTableViewController *itemsTable = [[BNRItemsTableViewController alloc] init];
            [self.navigationController pushViewController:itemsTable animated:YES];
        }break;
        case 3:{
            BNRDrawViewController *drawView = [[BNRDrawViewController alloc] init];
            [self.navigationController pushViewController:drawView animated:YES];
        }break;
        case 4:{
            MYMasonryViewController *masonry = [[MYMasonryViewController alloc] init];
            [self.navigationController pushViewController:masonry animated:YES];
        }break;
        case 5:{
            MYScrollViewController *scrollView = [[MYScrollViewController alloc] init];
            [self.navigationController pushViewController:scrollView animated:YES];
        }break;
        case 6:{
            MYCollectionVIew *collection = [[MYCollectionVIew alloc] init];
            [self.navigationController pushViewController:collection animated:YES];
        }break;
        default:
            break;
    }
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    NSMutableArray *uiItems = [NSMutableArray arrayWithObjects:@"Concentric circle",@"timereminer",@"navigationItems",@"touchtracker",@"masonrytest",@"scrollView",@"colletionView",nil];
    
    cell.textLabel.text = uiItems[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    return cell;
}

@end
