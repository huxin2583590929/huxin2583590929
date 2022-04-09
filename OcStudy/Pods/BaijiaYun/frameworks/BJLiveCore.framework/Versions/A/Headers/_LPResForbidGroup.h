//
//  _LPResForbidGroup.h
//  BJLiveCore
//
//  Created by fanyi on 2019/8/29.
//  Copyright © 2019 BaijiaYun. All rights reserved.
//

#import "_LPResRoomModel.h"
#import "BJLUser.h"

NS_ASSUME_NONNULL_BEGIN

@interface _LPResForbidGroup : _LPResRoomModel

@property (nonatomic, readonly) BJLUser *fromUser;
@property (nonatomic, readonly) NSTimeInterval duration;
@property (nonatomic, readonly) NSInteger groupID;

@end

NS_ASSUME_NONNULL_END
