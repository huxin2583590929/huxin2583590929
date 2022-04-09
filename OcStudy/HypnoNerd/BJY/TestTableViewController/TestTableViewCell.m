//
//  TestTableViewCell.m
//  HypnoNerd
//
//  Created by HuXin on 2021/11/11.
//

#import "TestTableViewCell.h"

@implementation TestTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self makeSubViews];
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)makeSubViews {
    self.contentView.backgroundColor = UIColor.greenColor;

    UIButton *button = [UIButton new];
    [button setTitle:@"点击测试" forState:UIControlStateNormal];
    [button setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    button.frame = CGRectMake(self.bounds.size.width / 2, self.bounds.size.height / 2, 100, 50);
    [button addTarget:self action:@selector(buttonTap) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:button];
    self.contentView.frame = CGRectMake(20, 20, self.bounds.size.width - 40, self.bounds.size.height - 40);
}

- (void)buttonTap {
    NSLog(@"按钮被点击！");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    NSLog(@"Cell被点击！");
}

@end
