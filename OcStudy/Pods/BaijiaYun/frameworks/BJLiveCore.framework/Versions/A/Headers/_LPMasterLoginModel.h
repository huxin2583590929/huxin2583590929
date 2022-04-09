//
//  _LPMasterLoginModel.h
//  BJLiveCore
//
//  Created by 杨磊 on 16/3/28.
//  Copyright © 2016 BaijiaYun. All rights reserved.
//

#import "_LPDataModel.h"
#import "_LPIpAddress.h"
#import "_LPTCPServer.h"
#import "_LPConstants.h"

/**
 *  直播网络配置
 */

#pragma mark -

@interface _LPMasterLoginModel : _LPDataModel

@property (nonatomic, strong) NSString *roomServerURL;
@property (nonatomic, strong) NSString *parentRoomServerURL;
@property (nonatomic, strong) NSArray<NSString *> *roomServerProxyList;
@property (nonatomic, strong) NSArray<NSString *> *parentRoomServerProxyList;

@property (nonatomic, strong) NSString *chatServerURL;
@property (nonatomic, strong) NSString *parentChatServerURL;
@property (nonatomic, strong) NSArray<NSString *> *chatServerProxyList;
@property (nonatomic, strong) NSArray<NSString *> *parentChatServerProxyList;

@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *userIp;

@property (nonatomic, strong) NSArray<_LPIpAddress *> *downlinkServerList;
@property (nonatomic, strong) NSArray<_LPIpAddress *> *uplinkServerList;

@property (nonatomic, strong) NSArray<_LPTCPServer *> *cdnDomains;

@property (nonatomic, strong) NSDictionary *config; // 包含cdn和link type信息

@property (nonatomic, strong) NSDictionary *user; //用来更新本地用户数据的user info data，目前仅仅用来修正用户昵称包含敏感词的情况

#pragma mark - webRTC

@property (nonatomic, strong) NSDictionary *webRTCInfo;
@property (nonatomic, strong) NSString *webRTCSignalURI;

@end
