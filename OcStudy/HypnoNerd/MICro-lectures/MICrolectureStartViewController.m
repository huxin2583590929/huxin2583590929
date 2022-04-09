//
//  MICrolectureStartViewController.m
//  HypnoNerd
//
//  Created by HuXin on 2021/7/26.
//

#import "MICrolectureStartViewController.h"
#import <Masonry/Masonry.h>
#import "MICrolecturesCollectionViewController.h"

@interface MICrolectureStartViewController ()

@property (nonatomic, strong) UIButton *startButton;

@end

@implementation MICrolectureStartViewController

- (instancetype) init {
    
    self = [super init];
    
    if (self) {
        UINavigationItem *navItem = self.navigationItem;
        navItem.title = @"Micro Lectures";
        
        UITabBarItem *tbi = self.tabBarItem;
        tbi.title = @"Micro Lectures";
        
        UIImage *i = [UIImage imageNamed:@"microlecture.png"];
        self.tabBarItem.image = i;

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.startButton = [[UIButton alloc] initWithFrame:CGRectMake(120, 120, 100, 100)];
    [self.startButton setTitle:@"我的微课" forState:UIControlStateNormal];
    [self.startButton addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    [self.startButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    
    [self.view addSubview:self.startButton];
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self.startButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.equalTo(@120);
        make.height.equalTo(@60);
    }];
}

- (void)start {
    MICrolecturesCollectionViewController *microLecture = [[MICrolecturesCollectionViewController alloc] init];
    [self.navigationController pushViewController:microLecture animated:YES];
}

@end
