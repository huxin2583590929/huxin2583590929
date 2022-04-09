//
//  _LPMasterServer.h
//  BJLiveCore
//
//  Created by 杨磊 on 16/3/25.
//  Copyright © 2016 BaijiaYun. All rights reserved.
//

#import <BJLiveBase/NSObject+BJLObserving.h>

#import "_LPWSServerBase.h"
#import "_LPMasterLoginModel.h"

/**
 *  master server 业务逻辑
 */
@interface _LPMasterServer : _LPWSServerBase

- (BJLObservable)onResponseWithDictionary:(NSDictionary *)response;

/**
 *  登录返回
 */
- (BJLObservable)onResponseLoginModel:(_LPMasterLoginModel *)loginModel;

/**
 *  登录 master 服务器
 *
 *  #param classId       classId
 *  #param parentClassId parentClassId
 *  #param teacherNumber teacherNumber
 *  #param userType      userType
 *  #param classType     classType
 *  #param clientIp      clientIp
 */
// 预先设置登录信息、在连接成功后发送
- (void)loginWithClassId:(NSString *)classId
           parentClassId:(NSString *)parentClassId
           teacherNumber:(NSString *)teacherNumber
                userType:(NSInteger)userType
               classType:(NSInteger)classType
           partnerConfig:(NSDictionary *)partnerConfig
                clientIp:(NSString *)clientIp
                userInfo:(NSDictionary *)userInfo;

@end
