//
//  _LPLinkInfo.h
//  BJLiveCore
//
//  Created by Randy on 16/5/18.
//  Copyright © 2016 BaijiaYun. All rights reserved.
//

#import "_LPDataModel.h"
#import "_LPConstants.h"

@class _LPIpAddress;

@interface _LPLinkInfo : _LPDataModel

@property (nonatomic) BJLLinkType linkType;
@property (nonatomic) BJLMediaSource mediaSource;
@property (nonatomic) NSInteger blockCount;
@property (nonatomic, copy) _LPIpAddress *linkServer;
@property (nonatomic) NSInteger streamID;
@property (nonatomic, copy) NSString *streamName;
@property (nonatomic, copy) NSDictionary *streamInfo;
@property (nonatomic) BOOL playVideo, playAudio;

+ (instancetype)upLinkInfo;
+ (instancetype)downLinkInfo;

#pragma mark - local use

@property (nonatomic, copy) NSString *userID, *userName;
@property (nonatomic) NSInteger playId;

#pragma mark - _LPLogStat use

@property (nonatomic, copy) NSString *userNumber;
@property (nonatomic) BJLUserRole userRole;
@property (nonatomic, readonly) BOOL isDownLink;
@property (nonatomic) BOOL audioOn, videoOn;
@property (assign, nonatomic) NSInteger definitionWidth;
@property (assign, nonatomic) NSInteger definitionHeight;
@property (assign, nonatomic) NSInteger fps;

@property (assign, nonatomic) BJLPlayerType playType;//当前推/拉流类型<0:avsdk, 1:webrtc, 2:声网>
@property (copy, nonatomic) NSString *webrtcServer;// 仅针对webrtc教室有效

@end
