//
//  TestTableViewController.m
//  HypnoNerd
//
//  Created by HuXin on 2021/11/11.
//

#import "TestTableViewController.h"
#import "TestTableViewCell.h"

@interface TestTableViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) UITableView *tableView;

@property (nonatomic) UIView *topView;
@property (nonatomic) UIView *topMoveView;
@property (nonatomic) UILabel *selectedLabel;

@end

@implementation TestTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self makeSubViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)makeSubViews {
    self.view.backgroundColor = UIColor.whiteColor;
    self.view.frame = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height);
    
    self.topView = ({
        UIView *view = [UIView new];
        view.backgroundColor = UIColor.grayColor;
        view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height / 2);
        view;
    });
    
    self.tableView = ({
        UITableView *table = [UITableView new];
        table.backgroundColor = UIColor.whiteColor;
        table.rowHeight = 80.0;
        table.scrollEnabled = YES;
        table.frame = self.view.frame;
        [table registerClass:[TestTableViewCell class] forCellReuseIdentifier:@"cell"];
        table;
    });
    [self.view addSubview:self.tableView];
    
    self.tableView.tableHeaderView = self.topView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self makeTopMoveView];
}

- (void)makeTopMoveView {
    self.topMoveView = ({
        UIView *view = [UIView new];
        view.backgroundColor = UIColor.redColor;
        view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height / 3);
        view;
    });
    [self.view addSubview:self.topMoveView];
    
    UILabel *label1 = ({
        UILabel *label = [UILabel new];
        label.backgroundColor = UIColor.yellowColor;
        label.text = @"Label One";
        label.frame = CGRectMake(0, 10, self.topMoveView.bounds.size.width, self.topMoveView.bounds.size.height / 4);
        label;
    });
    [self.topMoveView addSubview:label1];
    
    UILabel *label2 = ({
        UILabel *label = [UILabel new];
        label.backgroundColor = UIColor.yellowColor;
        label.text = @"Label Two";
        label.frame = CGRectMake(0, self.topMoveView.bounds.size.height / 3, self.topMoveView.bounds.size.width, self.topMoveView.bounds.size.height / 4);
        label;
    });
    [self.topMoveView addSubview:label2];
    
    self.selectedLabel = ({
        UILabel *label = [UILabel new];
        label.hidden = YES;
        label.backgroundColor = UIColor.yellowColor;
        label.text = @"Label Two";
        label.frame = CGRectMake(0, self.topMoveView.bounds.size.height / 3, self.topMoveView.bounds.size.width, self.topMoveView.bounds.size.height / 4);
        label;
    });
    [self.view addSubview:self.selectedLabel];
    
    UILabel *label3 = ({
        UILabel *label = [UILabel new];
        label.backgroundColor = UIColor.yellowColor;
        label.text = @"Label Three";
        label.frame = CGRectMake(0, self.topMoveView.bounds.size.height / 3 * 2 - 10, self.topMoveView.bounds.size.width, self.topMoveView.bounds.size.height / 4);
        label;
    });
    [self.topMoveView addSubview:label3];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = self.tableView.contentOffset.y;
    CGRect stickFrame = self.topMoveView.frame;
    CGRect selectedFrame = self.selectedLabel.frame;
    CGFloat offset = self.view.bounds.size.height / 9;
    self.selectedLabel.hidden = NO;
    
    if (offsetY >= offset) {
        stickFrame.origin.y = -offset;
        selectedFrame.origin.y = 0;
        self.topMoveView.alpha = 0;
    }
    else {
        stickFrame.origin.y = -offsetY;
        selectedFrame.origin.y = offset - offsetY;
        self.topMoveView.alpha = 1 - (offsetY / offset);
        if (offsetY == 0) {
            self.selectedLabel.hidden = YES;
        }
    }
    self.topMoveView.frame = stickFrame;
    self.selectedLabel.frame = selectedFrame;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell){
        cell = [[TestTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    return cell;
}

@end
