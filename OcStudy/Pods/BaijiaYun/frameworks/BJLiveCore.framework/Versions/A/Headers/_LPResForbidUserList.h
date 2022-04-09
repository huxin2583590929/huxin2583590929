//
//  _LPResForbidUserList.h
//  BJLiveCore
//
//  Created by 凡义 on 2020/3/11.
//  Copyright © 2020 BaijiaYun. All rights reserved.
//

#import "_LPResRoomModel.h"
#import "BJLUser.h"

NS_ASSUME_NONNULL_BEGIN

@class BJLUser;

@interface _LPResForbidUserList : _LPResRoomModel

@property (nonatomic, readonly) NSArray<BJLUser *> *users;

@end

NS_ASSUME_NONNULL_END
