//
//  _LPResMediaRemoteControl.h
//  BJLiveCore
//
//  Created by Randy on 16/3/31.
//  Copyright © 2016 BaijiaYun. All rights reserved.
//

#import "_LPResRoomModel.h"
#import "_LPMediaRemoteControlModel.h"
#import "BJLUser.h"

@interface _LPResMediaRemoteControl : _LPResRoomModel

@property (nonatomic) _LPMediaRemoteControlModel *control;
@property (nonatomic) BJLUser *user;

@end
