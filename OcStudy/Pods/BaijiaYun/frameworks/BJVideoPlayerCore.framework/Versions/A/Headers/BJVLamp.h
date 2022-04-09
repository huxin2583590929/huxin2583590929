//
//  BJVLamp.h
//  BJVideoPlayerCore
//
//  Created by 辛亚鹏 on 2021/7/3.
//  Copyright © 2021 BaijiaYun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BJVLamp : NSObject

@property (nonatomic, readonly) NSString *content;
@property (nonatomic, readonly) CGFloat fontSize;
@property (nonatomic, readonly) NSString *color;

/** 透明度 取值范围[0, 1] */
@property (nonatomic, readonly) CGFloat alpha;

/**
 跑马灯
 #param content 跑马灯内容
 #param fontSize 跑马灯字体大小，默认 10.0
 #param color 跑马灯字体颜色，默认 #FFFFFF
 #param alpha 跑马灯字体和背景透明度，默认 1.0
 */
- (instancetype)initWithContent:(NSString *)content
                       fontSize:(CGFloat)fontSize
                          color:(nullable NSString *)color
                          alpha:(CGFloat)alpha;


@end

NS_ASSUME_NONNULL_END
