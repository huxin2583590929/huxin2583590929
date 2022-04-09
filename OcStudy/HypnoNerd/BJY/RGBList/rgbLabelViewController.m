//
//  rgbLabelViewController.m
//  HypnoNerd
//
//  Created by HuXin on 2021/9/10.
//

#import "rgbLabelViewController.h"
#import "AvatarBackgroundColorGenerator.h"
#import <Masonry/Masonry.h>

@interface rgbLabelViewController ()

@end

@implementation rgbLabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.view.backgroundColor = UIColor.clearColor;
    [self.view addSubview:scrollView];

    for (int i = 0; i < 100; i++) {
        UILabel *label = [[UILabel alloc] init];
        label.text = [NSString stringWithFormat:@"label%d", i];
        label.backgroundColor = [AvatarBackgroundColorGenerator backgroundColorWithUserNumber:[NSString stringWithFormat:@"%d", i]];
        [scrollView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@30);
            make.width.equalTo(@(self.view.bounds.size.width));
            make.top.equalTo(scrollView.mas_top).offset(30 * i);
            make.centerX.equalTo(scrollView);
        }];
    }
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, 3000);
}

@end
