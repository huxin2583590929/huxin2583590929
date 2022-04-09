//
//  _LPResVideoMirrorMode.h
//  BJLiveCore
//
//  Created by Ney on 3/18/21.
//  Copyright © 2021 BaijiaYun. All rights reserved.
//

#import "_LPDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface _LPResVideoMirrorMode : _LPDataModel
@property (copy, nonatomic) NSString *toUserNumber;
@property (copy, nonatomic) NSString *toUserID;
@property (assign, nonatomic) BOOL isSendToAllUser;
@property (assign, nonatomic) BOOL horizonMirror;
@property (assign, nonatomic) BOOL verticalMirror;
@end

NS_ASSUME_NONNULL_END
