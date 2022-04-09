//
//  _LPResRoomUserIn.h
//  BJLiveCore
//
//  Created by Randy on 16/3/30.
//  Copyright © 2016 BaijiaYun. All rights reserved.
//

#import "_LPResUserModel.h"

@class BJLUser;

@interface _LPResRoomUserIn : _LPResUserModel

@property (assign, nonatomic) BOOL overrideIn;//覆盖进入
@property (strong, nonatomic) BJLUser *user;

@end
