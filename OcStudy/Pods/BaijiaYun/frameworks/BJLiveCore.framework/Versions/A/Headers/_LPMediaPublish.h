//
//  _LPMediaPublish.h
//  BJLiveCore
//
//  Created by Randy on 16/3/31.
//  Copyright © 2016 BaijiaYun. All rights reserved.
//

#import "_LPResRoomModel.h"

@class _LPMediaServerModel;
@class _LPMediaUser;

@interface _LPMediaPublish : _LPResRoomModel

@property (strong, nonatomic) _LPMediaUser *mediaUser;
@property (nonatomic) BOOL supportsMuteStream, needNotReloadStream;
@property (nonatomic) BOOL keepAlive;

@end
