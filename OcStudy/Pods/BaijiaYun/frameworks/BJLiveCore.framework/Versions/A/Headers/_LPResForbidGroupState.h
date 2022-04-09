//
//  _LPResForbidGroupState.h
//  BJLiveCore
//
//  Created by fanyi on 2019/8/29.
//  Copyright © 2019 BaijiaYun. All rights reserved.
//

#import "_LPResRoomModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface _LPResForbidGroupState : _LPResRoomModel

@property (nonatomic, readonly) NSTimeInterval forbidGroupDuration;
@property (nonatomic, readonly) NSTimeInterval forbidAllDuration;

@end

NS_ASSUME_NONNULL_END
