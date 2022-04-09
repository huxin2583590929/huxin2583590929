//
//  _LPResMediaSpeakApply.h
//  BJLiveCore
//
//  Created by Randy on 16/3/31.
//  Copyright © 2016 BaijiaYun. All rights reserved.
//

#import "_LPResRoomModel.h"
#import "_LPConstants.h"

@class BJLUser;

@interface _LPResMediaSpeakApply : _LPResRoomModel
@property (strong, nonatomic) BJLUser *user;
@property (assign, nonatomic) _LPSpeakState speakState;

@end
