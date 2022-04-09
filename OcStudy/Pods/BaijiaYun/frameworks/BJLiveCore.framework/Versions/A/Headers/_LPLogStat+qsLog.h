//
//  _LPLogStat+qsLog.h
//  BJLiveCore
//
//  Created by fanyi on 2019/8/7.
//  Copyright © 2019 BaijiaYun. All rights reserved.
//

#import "_LPLogStat.h"
#import "_LPLogLinkInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface _LPLogStat (qsLog)

// 卡顿率上报心跳数据
- (void)eventOfQSHeartBeat:(_LPLogLinkInfo *)publishLinkinfo
           allLogLinkInfos:(nullable NSArray <_LPLogLinkInfo *> *)allLogLinkInfos
         publishDefinition:(BJLVideoDefinition)publishDefiniton
           publishLossRate:(CGFloat)publishLossRate
                publishFPS:(NSInteger)publishFPS
                  isWebrtc:(BOOL)isWebrtc;

// 卡顿率上报卡顿数据
- (void)eventOfLagWithLinkInfo:(_LPLogLinkInfo *)linkinfo;

// 卡顿率上报实时上/下行数量
- (void)eventOfAccCountWithPublishLinkinfo:(nullable _LPLogLinkInfo *)publishLinkinfo
                           allLogLinkInfos:(nullable NSArray <_LPLogLinkInfo *> *)allLogLinkInfos;

// 卡顿率上报失败数据
- (void)eventOfConnectFailed:(BJLQSLogFailedEventType)failedEventType
                    linkInfo:(nullable _LPLogLinkInfo *)linkinfo
             allLogLinkInfos:(nullable NSArray <_LPLogLinkInfo *> *)allLogLinkInfos
             publishLinkinfo:(nullable _LPLogLinkInfo *)publishLinkinfo
           publishDefinition:(BJLVideoDefinition)publishDefiniton
             publishLossRate:(CGFloat)publishLossRate
                  publishFPS:(NSInteger)publishFPS
                    isWebrtc:(BOOL)isWebrtc;

@end

NS_ASSUME_NONNULL_END
