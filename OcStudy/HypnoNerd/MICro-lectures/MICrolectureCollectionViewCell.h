//
//  MICrolectureCollectionViewCell.h
//  HypnoNerd
//
//  Created by HuXin on 2021/7/26.
//

#import <UIKit/UIKit.h>
#import "MICrolecture.h"

NS_ASSUME_NONNULL_BEGIN

@interface MICrolectureCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong)UIImageView *imageUrl;
@property (nonatomic, strong)NSString *playerurl;
@property (nonatomic, strong)UILabel *title;
@property (nonatomic, strong)UILabel *length;
@property (nonatomic) MICrolecture *lecture;

- (void)setCellView:(MICrolecture *)lecture;

@end

NS_ASSUME_NONNULL_END
