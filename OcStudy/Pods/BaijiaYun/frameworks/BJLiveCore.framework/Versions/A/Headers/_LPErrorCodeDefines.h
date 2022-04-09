//
//  _LPErrorCodeDefines.h
//
//  Created by Randy on 16/3/25.
//  Copyright © 2016年 Randy. All rights reserved.
//

#ifndef _LPErrorCodeDefines_h
#define _LPErrorCodeDefines_h

#define _LP_ERROR_DAMAIN @"LPLivePlayerError"

typedef NS_ENUM(NSUInteger, _LPErrorCode) {
    
    _LPErrorCode_UNKNWON = -1,
    _LPErrorCode_SUC = 0,
    _LPErrorCode_FAIL = 1,
    _LPErrorCode_LOGIN_ROOM_FULL = 2, // 教室人数超过限制
    _LPErrorCode_INVALID_PARAM = 100, // 参数错误
    _LPErrorCode_JSON_PARSE_FAIL = 101, // json解析错误
    _LPErrorCode_LOGIN_MASTER_FAIL = 102, // 登录master服务错误
    _LPErrorCode_LOGIN_ROOM_FAIL = 103, // 登录room服务错误
    _LPErrorCode_LOGIN_CHAT_FAIL = 104, // 登录chat服务错误
    _LPErrorCode_COMPRESS_FAIL = 105, // 解压缩失败
    
    _LPErrorCode_NETWORK_NONE = 200, // 无网络错误
    _LPErrorCode_WARN_NETWORK_3G = 201, // 3G网络警告
    _LPErrorCode_NETWORK_FAIL = 202, // 网络请求失败
    
    _LPErrorCode_DEVICE_MICROPHONE_UNAVAILABLE = 300, // 麦克风不可用
    _LPErrorCode_DEVICE_CAMERA_UNAVAILABLE = 301, // 摄像头不可用
};

#endif /* _LPErrorCodeDefines_h */
