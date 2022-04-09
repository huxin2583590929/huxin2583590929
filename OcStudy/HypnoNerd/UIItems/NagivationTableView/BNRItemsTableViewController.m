//
//  BNRItemsTableViewController.m
//  HypnoNerd
//
//  Created by HuXin on 2021/7/8.
//

#import "BNRItemsTableViewController.h"
#import "BNRItemStore.h"
#import "BNRDetailViewController.h"
#import "BNRTtem.h"
#import "BNRItemCellTableViewCell.h"

@interface BNRItemsTableViewController () <BNRDetailVCDelegate>

//@property (nonatomic, strong) IBOutlet UIView *headerView;

@end

@implementation BNRItemsTableViewController

- (instancetype) init {
    self = [super initWithStyle:UITableViewStylePlain];
    
    if (self) {
        UINavigationItem *navItem = self.navigationItem;
        navItem.title = @"Homepwner";
        
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewItem:)];
        
        navItem.rightBarButtonItem = bbi;
    }
    
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[BNRItemStore sharedStore] allItems] count];
}

//
//- (instancetype)initWithStyle:(UITableViewStyle)style {
//    return  [self init];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    //高度自适应设置
    self.tableView.estimatedRowHeight = 60;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerClass:[BNRItemCellTableViewCell class] forCellReuseIdentifier:@"cell"];
}

//New按钮的点击事件
- (IBAction)addNewItem:(id)sender {
    BNRTtem *newItem = [[BNRItemStore sharedStore] createItem];
    NSLog(@"created");

    BNRDetailViewController *detailViewController = [[BNRDetailViewController alloc] initForNewItem:YES];
    detailViewController.item = newItem;
    detailViewController.delegate = self;

    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:detailViewController];

    [self presentViewController:navController animated:YES completion:nil];
}

- (void)addName:(NSString *)name serial:(NSString *)serial value:(NSString *)value {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[[BNRItemStore sharedStore] allItems].count - 1 inSection:0];
    
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
}


//删除行
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSArray *items = [[BNRItemStore sharedStore] allItems];
        BNRTtem *item = items[indexPath.row];
        
        [[BNRItemStore sharedStore] removeItem:item];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

//移动行
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    [[BNRItemStore sharedStore] moveItemAtIndex:sourceIndexPath.row ToIndex:destinationIndexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //BNRDetailViewController *detailViewController = [[BNRDetailViewController alloc] init];
    BNRDetailViewController *detailViewController = [[BNRDetailViewController alloc] initForNewItem:NO];
    
    NSArray *items = [[BNRItemStore sharedStore] allItems];
    
    BNRTtem *itemSelected = items[indexPath.row];
    
    detailViewController.item = itemSelected;
    
    [self.navigationController pushViewController:detailViewController animated:YES];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier =@"cell";
    
    //查找可复用的Cell
    BNRItemCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[BNRItemCellTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    NSArray *items = [[BNRItemStore sharedStore] allItems];
    BNRTtem *item = items[indexPath.row];
    
    [cell setBNRItemLabel:item];
    
    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return  80;
//}

- (void)setTitle:(NSString *)title {
    self.navigationItem.title = @"navigationItems";
}
//
//- (UIView *)headerView {
//
//    if (!_headerView) {
//        [[NSBundle mainBundle] loadNibNamed:@"BNRItemsTableViewConytroller" owner:self options:nil];
//    }
//    return _headerView;
//}


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
