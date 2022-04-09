//
//  MYMasonryViewController.m
//  HypnoNerd
//
//  Created by HuXin on 2021/7/15.
//

#import "MYMasonryViewController.h"
#import <Masonry/Masonry.h>

@interface MYMasonryViewController () <UITextViewDelegate>

@end

@implementation MYMasonryViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        UINavigationItem *navItem = self.navigationItem;
        navItem.title = @"masonry";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImage *image = [UIImage imageNamed:@"wuhan"];
    UIImageView *wuhanImage = [[UIImageView alloc] initWithImage:image];
    
    [self.view addSubview:wuhanImage];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.text = @"武汉";
    label1.textAlignment = NSTextAlignmentCenter;
    label1.layer.borderColor = [UIColor.blackColor CGColor];
    label1.layer.borderWidth = 1.0;
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.text = @"城市风景";
    label2.textAlignment = NSTextAlignmentCenter;
    label2.layer.borderColor = [UIColor.blackColor CGColor];
    label2.layer.borderWidth = 1.0;
    
    [self.view addSubview:label1];
    [self.view addSubview:label2];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.cornerRadius = 8.0;
    gradient.colors = @[(id)[UIColor redColor].CGColor,(id)[UIColor greenColor].CGColor,(id)[UIColor blueColor].CGColor];
    gradient.startPoint = CGPointMake(0, 0.5);
    gradient.endPoint   = CGPointMake(1, 0.5);
    gradient.locations = @[@0.0, @0.5, @1.0];
    
    UIView *gradientView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width - 40, 80)];
    //gradientView.backgroundColor = UIColor.blueColor;
    [self.view addSubview:gradientView];
    
    UITextView *textView = [[UITextView alloc] init];
    textView.text = @"描述你的想法";
    textView.font = [UIFont systemFontOfSize:30];
    textView.layer.borderColor = [UIColor.blackColor CGColor];
    textView.layer.borderWidth = 2.0;
    textView.delegate = self;
    
    [self.view addSubview:textView];
    
    [wuhanImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).mas_offset(80);
        make.left.equalTo(self.view).mas_offset(20);
        make.height.equalTo(@100);
    }];
    
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wuhanImage.mas_top);
        make.left.equalTo(wuhanImage.mas_right).mas_offset(20);
        make.width.equalTo(@80);
        make.height.equalTo(@70);
        make.right.equalTo(self.view).mas_offset(-20);
        make.bottom.equalTo(label2.mas_top).mas_offset(-10);
    }];
    
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(label1);
        make.width.equalTo(label1);
        make.bottom.equalTo(wuhanImage.mas_bottom);
    }];
    
    [gradientView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).insets(UIEdgeInsetsMake(0, 20, 0, 20));
        make.top.equalTo(wuhanImage.mas_bottom).mas_offset(20);
        make.height.equalTo(@80);
    }];
    
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view).insets(UIEdgeInsetsMake(0, 20, 50, 20));
        make.top.equalTo(gradientView.mas_bottom).mas_offset(20);
    }];
    
    gradient.frame = gradientView.bounds;
    [gradientView.layer addSublayer:gradient];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
@end
