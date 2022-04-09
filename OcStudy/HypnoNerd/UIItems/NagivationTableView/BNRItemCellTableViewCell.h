//
//  BNRItemCellTableViewCell.h
//  HypnoNerd
//
//  Created by HuXin on 2021/7/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class BNRTtem;

@interface BNRItemCellTableViewCell : UITableViewCell

@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *valueLAbel;
@property (strong, nonatomic) UIImageView *cellImage;
- (void)setBNRItemLabel:(BNRTtem *)item;

@end

NS_ASSUME_NONNULL_END
