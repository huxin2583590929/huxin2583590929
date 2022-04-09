//
//  _LPVideoContainerView.h
//  BJLiveCore
//
//  Created by HuangJie on 2018/11/1.
//  Copyright © 2018年 BaijiaYun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface _LPVideoContainerView : UIView

@property (nonatomic, weak) UIView *playerView;
@property (nonatomic, readonly) UIImageView *watermarkView;
@property (nonatomic) BOOL showWatermark;
@property (nonatomic) NSDictionary *watermarkParams;
@property (nonatomic, copy, nullable) void (^lp_layoutSubviewsBlock)(UIView *view);

- (void)setupWatermarkWithParams:(NSDictionary *)watermarkParams;
- (void)bringWaterMarkToFront;
// fit 模式根据视频尺寸显示水印
- (void)updateWatermarkPositionWithVideoSize:(CGSize)videoSize;
// fill 模式根据被 fill 的视图显示水印，需要通知被 fill 的视图的尺寸
- (void)updateWatermarkPositionWithSuperContainerViewSize:(CGSize)superContainerViewSize;

@end

NS_ASSUME_NONNULL_END
