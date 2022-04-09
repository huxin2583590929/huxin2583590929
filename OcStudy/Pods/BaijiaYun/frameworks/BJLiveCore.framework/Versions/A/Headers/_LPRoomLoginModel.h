//
//  _LPRoomLoginModel.h
//  BJLiveCore
//
//  Created by 杨磊 on 16/3/30.
//  Copyright © 2016 BaijiaYun. All rights reserved.
//

#import  "_LPResRoomModel.h"

/**
 *  room server 登录返回数据
 */
@interface _LPRoomLoginModel : _LPResRoomModel

@property (nonatomic, assign) NSInteger code;
@property (nonatomic, assign) BOOL started; // 上课状态
@property (nonatomic, assign) _LPSpeakState speakState;
@property (nonatomic, assign) NSInteger userCount;
@property (nonatomic, assign) NSInteger timestamp; // seconds since 1970
@property (nonatomic, assign) BOOL shouldSwitchClassRoom; // 大小班切换功能中，进入小班成功后是否需要立即切换到大班
@property (nonatomic, assign) NSUInteger groupID;

@end
