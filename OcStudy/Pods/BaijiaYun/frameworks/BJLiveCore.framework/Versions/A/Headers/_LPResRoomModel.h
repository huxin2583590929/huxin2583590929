//
//  _LPRoomResponseModel.h
//  BJLiveCore
//
//  Created by Randy on 16/3/30.
//  Copyright © 2016 BaijiaYun. All rights reserved.
//

#import "_LPDataModel.h"
#import "BJLUser.h"

NS_ASSUME_NONNULL_BEGIN

@interface _LPResRoomModel : _LPDataModel

@property (nonatomic, readonly, copy) NSString *messageType;
@property (nonatomic, readonly, copy) NSString *classID;

@property (nonatomic, readonly, copy) NSString *userID;
@property (nonatomic, readonly, nullable) _BJLBaseUser *sender;

@end

NS_ASSUME_NONNULL_END
