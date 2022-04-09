//
//  _LPResRoomActiveUsers.h
//  BJLiveCore
//
//  Created by Randy on 16/3/30.
//  Copyright © 2016 BaijiaYun. All rights reserved.
//

#import "_LPResRoomModel.h"

@class _LPMediaUser;

@interface _LPResRoomActiveUserList : _LPResRoomModel

@property (copy, nonatomic) NSString *presenterID;
@property (copy, nonatomic) NSArray<_LPMediaUser *> *users;
@property (copy, nonatomic) NSArray<_LPMediaUser *> *extraMediaUsers; // 多路流用户实例

@end
