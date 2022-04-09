//
//  MICrolectureCollectionViewCell.m
//  HypnoNerd
//
//  Created by HuXin on 2021/7/26.
//

#import "MICrolectureCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <Masonry/Masonry.h>

@implementation MICrolectureCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.contentView.layer.borderWidth = 2.0;
        self.contentView.layer.borderColor = UIColor.blueColor.CGColor;
        self.contentView.layer.cornerRadius = 8.0;
        
        //使cornerRadius能影响子视图
        self.contentView.layer.masksToBounds = YES;
        
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        self.length = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        self.imageUrl = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        
        self.length.font = [UIFont fontWithName:@"PingFang SC" size:14];
        self.length.textAlignment = NSTextAlignmentCenter;
  
        self.contentView.backgroundColor = UIColor.whiteColor;
        [self.contentView addSubview:self.title];
        [self.contentView addSubview:self.length];
        [self.contentView addSubview:self.imageUrl];
        
        [self.imageUrl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.contentView).insets(UIEdgeInsetsZero);
            make.height.equalTo(@100);

        }];
        
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imageUrl.mas_bottom).mas_offset(10);
            make.left.equalTo(self.contentView).mas_offset(6);
            make.width.equalTo(@100);
            make.height.equalTo(@30);
        }];
        
        [self.length mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.title.mas_bottom).mas_offset(2);
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.width.equalTo(@60);
            make.height.equalTo(@20);
        }];
    }
    return self;
}

- (void)setCellView:(MICrolecture *)lecture {
    self.lecture = lecture;
    self.playerurl = self.lecture.player_url;
    self.title.text = self.lecture.title;
    self.length.text = [NSString stringWithFormat:@"%ld",(long)self.lecture.length];
    [self.imageUrl sd_setImageWithURL:self.lecture.preface_url];
}
@end
