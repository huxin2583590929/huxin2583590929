//
//  _LPMediaServerModel.h
//  BJLiveCore
//
//  Created by Randy on 16/3/31.
//  Copyright © 2016 BaijiaYun. All rights reserved.
//

#import "_LPDataModel.h"
#import "_LPIpAddress.h"



NS_ASSUME_NONNULL_BEGIN

@interface _LPMediaServerModel : _LPDataModel

@property (nonatomic, nullable) NSNumber *videoOn;
@property (nonatomic, nullable) NSNumber *audioOn;
@property (nonatomic, nullable) NSString *mediaID;
@property (nonatomic) BJLMediaSource mediaSource;
@property (nonatomic) _LPIpAddress *publishServer;
@property (nonatomic) NSInteger publishIndex;
@property (nonatomic) BJLLinkType linkType;
@property (nonatomic) NSArray *definitions;

@property (nonatomic) NSNumber *supportsMuteStream, *needNotReloadStream;

@end

NS_ASSUME_NONNULL_END
