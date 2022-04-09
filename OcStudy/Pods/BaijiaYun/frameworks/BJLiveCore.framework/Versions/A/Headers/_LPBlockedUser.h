//
//  _LPBlockedUser.h
//  BJLiveCore
//
//  Created by xijia dai on 2018/12/3.
//  Copyright © 2018 BaijiaYun. All rights reserved.
//

#import "_LPResRoomModel.h"
#import "BJLUser.h"

NS_ASSUME_NONNULL_BEGIN

@interface _LPBlockedUser : _LPResRoomModel

@property (nonatomic) BJLUser *user;
@property (nonatomic) NSString *fromUserID;
@property (nonatomic) NSString *blockedUserID;

@end

NS_ASSUME_NONNULL_END
