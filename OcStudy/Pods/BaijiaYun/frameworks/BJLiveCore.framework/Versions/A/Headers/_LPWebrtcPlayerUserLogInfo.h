//
//  _LPWebrtcPlayerUserLogInfo.h
//  BJLiveCore
//
//  Created by 凡义 on 2019/3/4.
//  Copyright © 2019 BaijiaYun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "_LPDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface _LPWebrtcPlayerUserLogInfo : _LPDataModel

@property (nonatomic) NSString *audioBandwidth;
@property (nonatomic) CGFloat audioBufferLength;
@property (nonatomic) CGFloat audioLossRate;

@property (nonatomic) NSString *videoBandwidth;
@property (nonatomic) CGFloat videoBufferLength;
@property (nonatomic) CGFloat videoLossRate;

@end

NS_ASSUME_NONNULL_END
