//
//  NETworkingViewController.m
//  HypnoNerd
//
//  Created by HuXin on 2021/7/23.
//

#import "NETworkingViewController.h"
#import "BNRCoursesViewController.h"
#import "MYNsurlsession.h"
#import "MYAFNetworking.h"

@interface NETworkingViewController ()

@end

@implementation NETworkingViewController

- (instancetype) init {
    
    self = [super initWithStyle:UITableViewStylePlain];
    
    if (self) {
        UINavigationItem *navItem = self.navigationItem;
        navItem.title = @"Networking";
        
        UITabBarItem *tbi = self.tabBarItem;
        tbi.title = @"Networking";
        
        UIImage *i = [UIImage imageNamed:@"networking.png"];
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
    return 3;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:{
            BNRCoursesViewController *jsonView = [[BNRCoursesViewController alloc] init];
            [self.navigationController pushViewController:jsonView animated:YES];
        }break;
        case 1:{
            MYNsurlsession *session = [[MYNsurlsession alloc] init];
            [self.navigationController pushViewController:session animated:YES];
        }break;
        case 2:{
            MYAFNetworking *networking = [[MYAFNetworking alloc] init];
            [self.navigationController pushViewController:networking animated:YES];
        }break;
        default:
            break;
    }
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    NSMutableArray *uiItems = [NSMutableArray arrayWithObjects:@"JsonTableView",@"NSURLSessionn",@"AFNetworking", nil];
    
    cell.textLabel.text = uiItems[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    return cell;
}

@end
