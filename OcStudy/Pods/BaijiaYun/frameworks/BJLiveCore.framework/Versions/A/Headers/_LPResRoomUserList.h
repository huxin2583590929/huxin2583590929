//
//  _LPResRoomUserList.h
//  BJLiveCore
//
//  Created by Randy on 16/3/30.
//  Copyright © 2016 BaijiaYun. All rights reserved.
//

#import "_LPResRoomModel.h"

@class BJLUser;

@interface _LPResRoomUserList : _LPResRoomModel
@property (copy, nonatomic) NSArray<BJLUser *> *users;
@property (assign, nonatomic) BOOL hasMore;
@property (assign, nonatomic) NSInteger groupID;

@end
