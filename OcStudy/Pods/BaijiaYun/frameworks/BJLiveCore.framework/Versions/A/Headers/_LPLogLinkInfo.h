//
//  _LPLogLinkInfo.h
//  BJLiveCore
//
//  Created by Randy on 16/5/25.
//  Copyright © 2016 BaijiaYun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "_LPConstants.h"

NS_ASSUME_NONNULL_BEGIN

@class _LPLinkInfo, _LPIpAddress;

@interface _LPLogLinkInfo : NSObject

@property (assign, nonatomic) NSInteger linkType;//0：上行 1：下行
@property (assign, nonatomic) BOOL useUDP;//0：未使用 1：使用<仅对AVSDK有效>
@property (assign, nonatomic) NSInteger avType;//0：音频 1：合流
@property (strong, nonatomic) _LPIpAddress *address;
@property (copy, nonatomic) NSString *fromNumber;//只有下行需要
@property (assign, nonatomic) BJLUserRole fromRole;//只有下行需要
@property (assign, nonatomic) NSInteger blockCount;

@property (strong, nonatomic) _LPIpAddress *oldAddress;//切换链路的时候 ，旧的链路信息

@property (assign, nonatomic) NSInteger definitionWidth;
@property (assign, nonatomic) NSInteger definitionHeight;
@property (assign, nonatomic) BOOL videoOn, audioOn;

@property (assign, nonatomic) BJLPlayerType playType;//当前推/拉流类型<0:avsdk, 1:webrtc, 2:声网>
@property (copy, nonatomic, nullable) NSString *webrtcServer;// 仅针对webrtc教室有用
@property (assign, nonatomic) BOOL thirdSDKBlock; // 第三方SDK上报的卡顿
@property (assign, nonatomic) BOOL bjySDKBlock; // 百家云内部的一套规则认定的卡顿
@property (assign, nonatomic) BOOL useIJK; //是否使用的ijk拉合流

+ (instancetype)logLinkInfoWithLinkInfo:(_LPLinkInfo *)linkInfo;

// 仅统计下行老师数据
+ (NSArray<_LPLogLinkInfo *> *)logLinkInfoArrayWithLinkInfoArray:(NSArray<_LPLinkInfo *> *)allLinkInfo;

//统计所有下行数据
+ (NSArray<_LPLogLinkInfo *> *)AlllogLinkInfoArrayWithLinkInfoArray:(NSArray<_LPLinkInfo *> *)allLinkInfo;

@end

NS_ASSUME_NONNULL_END
