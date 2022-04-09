//
//  _LPRunTimeInfo.h
//  BJLiveCore
//
//  Created by Randy on 16/5/18.
//  Copyright © 2016 BaijiaYun. All rights reserved.
//

#import "_LPDataModel.h"

@class _LPIpAddress;

@interface _LPRunTimeInfo : _LPDataModel
@property (strong, nonatomic) NSString *versionInfo;                    // 版本号
@property (strong, nonatomic) NSString *userIp;                         // 用户的ip地址
@property (strong, nonatomic) _LPIpAddress *masterServer;               // master server
@property (strong, nonatomic) _LPIpAddress *roomServer;                 // room server
@property (strong, nonatomic) _LPIpAddress *chatServer;                 // chat server
@property (assign, nonatomic) NSTimeInterval downLinkBuffer;            // 播放延迟
@property (assign, nonatomic) NSInteger videoDefinition;                // 视频清晰度 0为流畅 1为高清
@property (assign, nonatomic) NSInteger upLinkType;                     // 采集自己的音视频的链路类型 0为tcp，1为udp
@property (assign, nonatomic) NSInteger downLinkType;                   // 播放别人的音视频的链路类型
@property (assign, nonatomic) CGFloat volume;                         // 音量大小
@property (strong, nonatomic) NSString *userAgent;                      // 用户代理
@property (strong, nonatomic) NSString *publicIp;                       // 公网IP
@property (strong, nonatomic) NSString *localDNS;                       // 本地dns
@property (strong, nonatomic) NSString *partner;                        // 传空，仅为了前段调试时显示表单界面
@property (strong, nonatomic) NSString *partnerId;                      // 用户账号ID

- (instancetype)initWithVersionInfo:(NSString *)versionInfo
                             userIp:(NSString *)userIp
                       masterServer:(_LPIpAddress *)masterServer
                         roomServer:(_LPIpAddress *)roomServer
                         chatServer:(_LPIpAddress *)chatServer
                     downLinkBuffer:(NSTimeInterval)downlinkBuffer
                    videoDefinition:(NSInteger)videoDefinition
                         upLinkType:(NSInteger)upLinkType
                       downLinkType:(NSInteger)downLinkType
                             volume:(CGFloat)volume
                          userAgent:(NSString *)userAgent
                           publicIp:(NSString *)publicIp
                           localDNS:(NSString *)localDNS
                          partnerId:(NSString *)partnerId;

@end
