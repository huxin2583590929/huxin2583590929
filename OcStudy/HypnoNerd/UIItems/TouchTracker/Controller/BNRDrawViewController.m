//
//  BNRDrawViewController.m
//  TouchTracker
//
//  Created by HuXin on 2021/7/13.
//

#import "BNRDrawViewController.h"
#import "BNRDrawView.h"


@interface BNRDrawViewController ()

@end


@implementation BNRDrawViewController
- (instancetype) init {
    
    if (self) {
        UINavigationItem *navItem = self.navigationItem;
        navItem.title = @"drawView";
    }
    
    return self;
}


- (void)loadView {
    self.view = [[BNRDrawView alloc] initWithFrame:CGRectZero];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)setTitle:(NSString *)title {
    self.navigationItem.title = @"drawView";
}
@end
