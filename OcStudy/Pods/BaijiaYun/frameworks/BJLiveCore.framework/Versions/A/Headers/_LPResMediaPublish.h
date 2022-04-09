//
//  _LPResMediaPublish.h
//  BJLiveCore
//
//  Created by HuangJie on 2018/10/31.
//  Copyright © 2018年 BaijiaYun. All rights reserved.
//

#import "_LPResRoomModel.h"
#import "_LPIpAddress.h"

NS_ASSUME_NONNULL_BEGIN

@interface _LPResMediaPublish : _LPResRoomModel

@property (nonatomic, readonly) NSString *sessionID;
@property (nonatomic, readonly) _LPIpAddress *publishServer;

@end

NS_ASSUME_NONNULL_END
