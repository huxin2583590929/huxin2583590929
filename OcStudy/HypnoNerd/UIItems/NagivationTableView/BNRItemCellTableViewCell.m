//
//  BNRItemCellTableViewCell.m
//  HypnoNerd
//
//  Created by HuXin on 2021/7/12.
//

#import "BNRItemCellTableViewCell.h"
#import "BNRTtem.h"
#import<Masonry/Masonry.h>
#import "BNRImageStore.h"

@interface BNRItemCellTableViewCell ()

@end

@implementation BNRItemCellTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    self.nameLabel = [[UILabel alloc] init];
    self.valueLAbel = [[UILabel alloc] init];
    self.cellImage = [[UIImageView alloc] init];
    
    self.nameLabel.numberOfLines = 0;
    self.valueLAbel.numberOfLines = 0;
    
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.valueLAbel];
    [self.contentView addSubview:self.cellImage];
    
    [self.cellImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.greaterThanOrEqualTo(@10);
        make.bottom.lessThanOrEqualTo(@-10);
        make.height.equalTo(@80);
        make.width.equalTo(@80);
        make.centerY.equalTo(self.contentView);
    }];

    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cellImage.mas_right).mas_offset(20);
        make.right.equalTo(self.valueLAbel.mas_right).mas_offset(@-20);
        make.top.equalTo(@20).priority(UILayoutPriorityRequired - 1);
        make.bottom.equalTo(@-20).priority(UILayoutPriorityRequired - 1);
    }];
    
    [self.valueLAbel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-20);
        make.top.equalTo(self.nameLabel);
        make.bottom.equalTo(self.nameLabel);
        make.width.equalTo(@40);
    }];
    
    return  self;
}

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setBNRItemLabel:(BNRTtem *)item {
    NSString *imagePath = [[BNRImageStore sharedStore] imagePathForKey:item.itemKey];
    self.nameLabel.text = item.itemName;
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    self.valueLAbel.text = [NSString stringWithFormat:@"%d", item.valueInDollars];
    self.cellImage.image = [UIImage imageWithContentsOfFile:imagePath];
}
@end
