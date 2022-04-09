//
//  _LPResRoomGIftReceive.h
//  BJLiveCore
//
//  Created by Randy on 16/3/30.
//  Copyright © 2016 BaijiaYun. All rights reserved.
//

#import "_LPResRoomModel.h"

@class BJLUser;
@class _LPGiftModel;

@interface _LPResRoomGiftReceive : _LPResRoomModel
@property (strong, nonatomic) BJLUser *from;
@property (strong, nonatomic) BJLUser *to;
@property (strong, nonatomic) _LPGiftModel *gift;

@end
