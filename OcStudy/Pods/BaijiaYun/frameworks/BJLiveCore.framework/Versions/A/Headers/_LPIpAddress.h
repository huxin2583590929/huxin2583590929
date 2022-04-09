//
//  _LPIpAddress.h
//  BJLiveCore
//
//  Created by 杨磊 on 16/3/24.
//  Copyright © 2016 BaijiaYun. All rights reserved.
//

#import "_LPDataModel.h" 

/**
 *  地址数据
 */
@interface _LPIpAddress : _LPDataModel

#pragma mark - 通用字段
@property (nonatomic) NSString *ipAddr;
@property (nonatomic) NSUInteger port;
@property (nonatomic) NSString *name;

#pragma mark - debug
@property (nonatomic, strong) NSString *url;
@property (nonatomic) NSString *tag;// 流畅率上报需要使用该字段

@end

static inline _LPIpAddress *_LPIpAddressMake(NSString *ip, NSUInteger port) {
    _LPIpAddress *ipAddress = [_LPIpAddress new];
    ipAddress.ipAddr = ip;
    ipAddress.port = port;
    return ipAddress;
}
