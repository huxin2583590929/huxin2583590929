//
//  ViewController.m
//  HypnoNerd
//
//  Created by HuXin on 2021/7/7.
//
#import <Masonry/Masonry.h>
#import "ViewController.h"
#import "BNRHypnosisView.h"


@interface ViewController () <UITextFieldDelegate>

@property (nonatomic, weak) UITextField *textField;

@end

@implementation ViewController


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.title = @"Hypnotize";
        UINavigationItem *navItem = self.navigationItem;
        navItem.title = @"Concentric circle";
    }
    return self;
}


- (void)loadView {
    CGRect frame = [UIScreen mainScreen].bounds;
    BNRHypnosisView *backgroudView = [[BNRHypnosisView alloc] initWithFrame:frame];
    
    //CGRect textFieldRect = CGRectMake(40, 70, 240, 30);
    CGRect textFieldRect = CGRectMake(80, -20, 240, 30);

    UITextField *textField = [[UITextField alloc] initWithFrame:textFieldRect];
    
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.placeholder = @"Hypnotize me";
    textField.returnKeyType = UIReturnKeyDone;
    textField.delegate = self;

    [backgroudView addSubview:textField];
    
    backgroudView.backgroundColor = [UIColor whiteColor];
    
    self.textField = textField;
    self.view = backgroudView;
    
//    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self.view).insets(UIEdgeInsetsMake(0, 40, 0, 40));
//        make.height.equalTo(@40);
//    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    //NSLog(@"%@",textField.text);
    
    [self drawHypnoticMessage:textField.text];
    
    textField.text = @"";
    [textField resignFirstResponder];
    return YES;
}

- (void)drawHypnoticMessage: (NSString *)message {
    
    for (int i = 0;i < 20;i++) {
        UILabel *messageLabel = [[UILabel alloc] init];
        
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.textColor = [UIColor blackColor];
        messageLabel.text = message;
        [messageLabel sizeToFit];
        
        int width = (int)(self.view.bounds.size.width - messageLabel.bounds.size.width);
        int x = arc4random() % width;
        
        int height = (int)(self.view.bounds.size.height - messageLabel.bounds.size.height);
        int y = arc4random() % height;
        
        CGRect frame = messageLabel.frame;
        frame.origin = CGPointMake(x, y);
        messageLabel.frame = frame;
        
        [self.view addSubview:messageLabel];
        
        messageLabel.alpha = 0.0;
        
        //淡入动画更平缓
        [UIView animateWithDuration:0.5
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
            messageLabel.alpha = 1.0;
        }
                         completion:NULL];
        
        
        //messageLabel从中间到散开动画
        [UIView animateKeyframesWithDuration:1.0
                                       delay:0.0
                                     options:0
                                  animations:^{
            [UIView addKeyframeWithRelativeStartTime:0
                                    relativeDuration:0.8
                                          animations:^{
                messageLabel.center = self.view.center;
            }];
            
            [UIView addKeyframeWithRelativeStartTime:0.8
                                    relativeDuration:1.0
                                          animations:^{
                int x = arc4random() % width;
                int y = arc4random() % height;
                messageLabel.center = CGPointMake(x, y);
            }];
        }
                                  completion:^(BOOL finished) {
            NSLog(@"Animation finished");
        }];
        
        UIInterpolatingMotionEffect *motionEffect;
        motionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
        motionEffect.minimumRelativeValue = @(-25);
        motionEffect.maximumRelativeValue = @(25);
        [messageLabel addMotionEffect:motionEffect];
        
        motionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
        motionEffect.minimumRelativeValue = @(-25);
        motionEffect.maximumRelativeValue = @(25);
        [messageLabel addMotionEffect:motionEffect];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //弹簧动画
    [UIView animateWithDuration:2.0
                          delay:0.0
         usingSpringWithDamping:0.25
          initialSpringVelocity:0.0
                        options:0
                     animations:^{
                        CGRect frame = CGRectMake(80, 70, 240, 30);
                        self.textField.frame = frame;
                    }
                    completion:NULL];
}

- (void)setTitle:(NSString *)title {
    self.navigationItem.title = @"Concentric circle";
}

@end
