//
//  _LPResForbidUserState.h
//  BJLiveCore
//
//  Created by MingLQ on 2017-01-11.
//  Copyright © 2017 BaijiaYun. All rights reserved.
//

#import "_LPResRoomModel.h"

#import "BJLUser.h"

@interface _LPResForbidUserState : _LPResRoomModel

@property (nonatomic, readonly) BJLUser *fromUser;
@property (nonatomic, readonly, copy) NSString *toUserNumber;

@property (nonatomic, readonly) NSTimeInterval duration;

@end
