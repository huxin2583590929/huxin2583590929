//
//  MYScrollViewController.m
//  HypnoNerd
//
//  Created by HuXin on 2021/7/16.
//

#import "MYScrollViewController.h"
#import <Masonry/Masonry.h>

@interface MYScrollViewController () <UITextViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic) CGPoint point;
@property (nonatomic) UILabel *refresh;
@property (nonatomic) UILabel *loadmore;
@property (nonatomic) CGFloat keybordHeight;

@end

@implementation MYScrollViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        UINavigationItem *navItem = self.navigationItem;
        navItem.title = @"scrollview";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardAction:) name:UIKeyboardWillShowNotification object:nil];
    
    self.view = [[UIView alloc] init];
    self.view.backgroundColor = UIColor.whiteColor;
    CGRect screenRect = self.view.bounds;
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:screenRect];
//    self.scrollView.pagingEnabled =YES;
    self.scrollView.delegate = self;
    
    UITapGestureRecognizer *Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    Tap.numberOfTapsRequired = 1;
    
    [self.scrollView addGestureRecognizer:Tap];
    
    self.view.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.scrollView];
    
    UIView *containerView = [[UIView alloc] init];
    [self.scrollView addSubview:containerView];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.width.equalTo(self.scrollView);
    }];
    
    self.refresh = [[UILabel alloc] initWithFrame:CGRectMake(0, -50, 320, 50)];
    self.refresh.text = @"下拉刷新";
    self.refresh.tag = 0;
    [containerView addSubview:self.refresh];
    self.refresh.textAlignment = NSTextAlignmentCenter;
    
    [self.refresh mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@-50);
        make.left.right.equalTo(containerView);
        make.height.equalTo(@50);
    }];
    
    self.loadmore = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    self.loadmore.text = @"上拉加载更多";
    self.loadmore.tag = 0;
    [containerView addSubview:self.loadmore];
    self.loadmore.textAlignment = NSTextAlignmentCenter;
    
    UILabel *lastView;
    NSInteger viewsNumber = 14;
    for (int i = 0; i<viewsNumber; i++) {
        UILabel *view= [[UILabel alloc] init];
        view.backgroundColor = [UIColor colorWithRed:(arc4random()%255)/255.0 green:(arc4random()%255)/255.0 blue:(arc4random()%255)/255.0 alpha:1.f];
        view.text = @"label";
        [containerView addSubview:view];
        view.textAlignment = NSTextAlignmentCenter;
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            if (0 == i) {
                //第一个视图
                make.top.equalTo(self.refresh.mas_bottom);
            }
            else {
                make.top.equalTo(lastView.mas_bottom);
            }
            make.left.equalTo(containerView.mas_left);
            make.right.equalTo(containerView.mas_right);
            make.height.mas_equalTo(60);
        }];
        lastView = view;
    }
    
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, self.scrollView.contentSize.width, 100)];
    [containerView addSubview:self.textView];
    self.textView.text = @"this is textView";
    self.textView.layer.borderColor = [UIColor.blackColor CGColor];
    self.textView.layer.borderWidth = 2.0;
    self.textView.font = [UIFont systemFontOfSize:20];
    self.textView.returnKeyType = UIReturnKeyDone;
    self.textView.delegate = self;
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lastView.mas_bottom).mas_offset(10);
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.height.equalTo(@30);
    }];
    
    [self.loadmore mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.top.equalTo(containerView.mas_bottom).mas_offset(0);
        make.top.equalTo(self.textView.mas_bottom).offset(-10);
        make.left.right.equalTo(containerView);
        make.height.equalTo(@50);
    }];
    
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.textView.mas_bottom);
    }];
}

-(void)keyboardAction:(NSNotification *)notification
{
//打印通知的内容
    NSLog(@"%@",notification);
    
    NSValue * value = [notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect rect = [value CGRectValue];
    CGFloat height = CGRectGetHeight(rect);
    self.keybordHeight = height;
}

- (void)tapAction:(UITapGestureRecognizer *)gr{
    [self.textView resignFirstResponder];
}

- (void)textViewDidChange:(UITextView *)textView {
    CGSize size = [textView sizeThatFits:CGSizeMake(CGRectGetWidth(textView.frame), MAXFLOAT)];
    CGRect frame = textView.frame;
    frame.size.height = size.height;
    //textView.frame = frame;
    [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(frame.size.height));
    }];
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x, self.scrollView.contentSize.height - self.scrollView.bounds.size.height + self.keybordHeight)];
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    //self.point = self.scrollView.contentOffset;
    self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, self.keybordHeight + 10, 0);
    [UIView animateWithDuration:2.0 animations:^{
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x,self.scrollView.contentSize.height - self.scrollView.bounds.size.height + self.keybordHeight) animated:YES];
    }];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    self.scrollView.contentInset = UIEdgeInsetsZero;
    [UIView animateWithDuration:2.0 animations:^{
        [self.scrollView setContentOffset:CGPointMake(self.point.x, self.point.y) animated:YES];
    }];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y <= -100) {
        if (self.refresh.tag == 0) {
            self.refresh.text = @"松开刷新";
        }
        self.refresh.tag = 1;
    }
    else {
//防止用户在下拉到contentOffset.y <= -50后不松手，然后又往回滑动，需要将值设为默认状态
        self.refresh.tag = 0;
        self.refresh.text = @"下拉刷新";
    }
    
    if (scrollView.contentOffset.y >= (self.scrollView.contentSize.height - self.scrollView.bounds.size.height + 100)) {
        if (self.loadmore.tag == 0) {
            self.loadmore.text = @"松开加载";
        }
        self.loadmore.tag = 1;
    }
    else {
        self.loadmore.tag = 0;
        self.loadmore.text = @"上拉加载更多";
    }
}

//即将结束拖拽
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint*)targetContentOffset {
    if (self.refresh.tag == 1) {
        [UIView animateWithDuration:2.0 animations:^{
            self.refresh.text = @"加载中";
            scrollView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0);
        }];
        //数据加载成功后执行；这里为了模拟加载效果，一秒后执行恢复原状代码
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:2.0 animations:^{
                self.refresh.tag = 0;
                self.refresh.text = @"下拉刷新";
                scrollView.contentInset = UIEdgeInsetsZero;
                self.textView.text = @"";
            }];
        });
    }
    
    if (self.loadmore.tag == 1) {
        [UIView animateWithDuration:2.0 animations:^{
            self.loadmore.text = @"加载中";
            scrollView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
        }];
        //数据加载成功后执行；这里为了模拟加载效果，一秒后执行恢复原状代码
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:2.0 animations:^{
                self.loadmore.tag = 0;
                self.loadmore.text = @"下拉加载更多";
                scrollView.contentInset = UIEdgeInsetsZero;
                self.textView.text = @"加载成功";
            }];
        });
    }
}
@end
