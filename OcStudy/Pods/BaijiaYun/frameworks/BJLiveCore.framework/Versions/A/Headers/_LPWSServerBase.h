//
//  _LPWSServerBase.h
//  BJLiveCore
//
//  Created by 杨磊 on 16/3/24.
//  Copyright © 2016 BaijiaYun. All rights reserved.
//

#import <BJLiveBase/BJL_M9Dev.h>
#import <BJLiveBase/NSObject+BJLObserving.h>

#import "_BJWebSocketBase.h"
#import "_LPIpAddress.h"

FOUNDATION_EXPORT NSString *const _LP_WS_KEY_MESSAGE_TYPE;
/**
 包装 _LPWSServerInterface 类， 
 1、增加备用地址列表功能。
 2、请求队列， 连接成功前发出的请求会缓存下来。待连接成功后自动重新发送. 防止中间断开重连时消息丢失
 
 供外界调用或继承的类。 以便于总要需要修改成 mm 文件。
 */
@interface _LPWSServerBase : _BJWebSocketBase

@property (nonatomic, readonly) NSInteger backupAddrIndex;
@property (nonatomic, readonly, copy) NSArray<NSString *> *backupURLStrings;
- (void)resetBackupAddrIndex;

/**
 *  #param backupAddrs 重连备用地址列表
 */
- (instancetype)initWithURLString:(NSString *)urlString backupAddrs:(NSArray<NSString *> *)backupAddrs NS_DESIGNATED_INITIALIZER;
- (void)updateWithURLString:(NSString *)urlString backupAddrs:(NSArray<NSString *> *)backupAddrs;

@end
