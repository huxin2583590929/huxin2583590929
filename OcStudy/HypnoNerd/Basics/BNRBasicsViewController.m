//
//  BNRBasicsViewController.m
//  HypnoNerd
//
//  Created by HuXin on 2021/7/13.
//

#import "BNRBasicsViewController.h"

@interface BNRBasicsViewController ()

@end

@implementation BNRBasicsViewController

- (instancetype) init {
    
    self = [super initWithStyle:UITableViewStylePlain];
    
    if (self) {
        UINavigationItem *navItem = self.navigationItem;
        navItem.title = @"Basics";
        
        UITabBarItem *tbi = self.tabBarItem;
        tbi.title = @"Basics";
        
        UIImage *i = [UIImage imageNamed:@"basics.png"];
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
    return 4;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            [[UIApplication sharedApplication] openURL: [NSURL URLWithString:@"https://www.jianshu.com/p/d3f343b71cc2" ] options:@{} completionHandler: nil];
            break;
        case 1:
            [[UIApplication sharedApplication] openURL:[ NSURL URLWithString:@"https://www.jianshu.com/p/c8caa30afd9d" ] options:@{} completionHandler:nil];
            break;
        case 2:
            [[UIApplication sharedApplication] openURL:[ NSURL URLWithString:@"https://www.cnblogs.com/quwujin/p/4768858.html" ] options:@{} completionHandler:nil];
            break;
        case 3:
            [[UIApplication sharedApplication] openURL: [ NSURL URLWithString:@"https://blog.csdn.net/potato512/article/details/51482893" ] options:@{} completionHandler:nil];
            break;
        default:
            break;
    }
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    NSMutableArray *uiItems = [NSMutableArray arrayWithObjects:@"NSString",@"NSArray",@"NSDictionary",@"NSSet", nil];
    
    cell.textLabel.text = uiItems[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    return cell;
}

@end
