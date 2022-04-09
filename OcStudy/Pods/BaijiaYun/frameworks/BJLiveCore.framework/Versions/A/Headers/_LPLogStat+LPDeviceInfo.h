//
//  _LPLogStat+LPDeviceInfo.h
//  BJLiveCore
//
//  Created by Randy on 16/5/25.
//  Copyright © 2016 BaijiaYun. All rights reserved.
//

#import "_LPLogStat.h"

@interface _LPLogStat (_LPDeviceInfo)

+ (NSString *)devicePlatform;
+ (NSString *)deviceModel;
+ (NSString *)device_os;
+ (BOOL)isSimulator;
+ (BOOL)isJailbroken;
+ (NSString *)appVersion;

+ (NSInteger)cpuUsagePercentage;
+ (NSInteger)memoryUsagePercentage;
+ (int64_t)currentAPPMemoryUsage;
+ (NSString *)getCurrentDeviceModel;
+ (NSString *)getDeviceResoulution;
+ (NSString *)getCPUType;
+ (NSString *)getCarriorInfo;

@end
