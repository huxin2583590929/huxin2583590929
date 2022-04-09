//
//  _LPResMediaSubscribe.h
//  BJLiveCore
//
//  Created by HuangJie on 2018/10/31.
//  Copyright © 2018年 BaijiaYun. All rights reserved.
//

#import "_LPResRoomModel.h"
#import "_LPIpAddress.h"

NS_ASSUME_NONNULL_BEGIN

@interface _LPResMediaSubscribe : _LPResRoomModel

@property (nonatomic, readonly) BJLLinkType linkType;
@property (nonatomic, readonly) NSString *sessionID;
@property (nonatomic, readonly) _LPIpAddress *udpServer;
@property (nonatomic, readonly) _LPIpAddress *tcpServer;
@property (nonatomic, readonly) NSString *targetUserID;
@property (nonatomic, readonly) NSInteger responseCode;

@end

NS_ASSUME_NONNULL_END
