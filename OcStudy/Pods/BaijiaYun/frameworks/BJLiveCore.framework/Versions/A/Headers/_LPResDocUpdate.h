//
//  _LPResDocUpdate.h
//  BJLiveCore
//
//  Created by HuangJie on 2018/9/12.
//  Copyright © 2018年 BaijiaYun. All rights reserved.
//

#if __has_feature(modules) && BJL_USE_SEMANTIC_IMPORT
@import BJLiveBase;
#else
#import <BJLiveBase/BJLiveBase.h>
#endif

#import "_LPResRoomModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface _LPResDocUpdate : _LPResRoomModel

@property (nonatomic) NSString *documentID;
@property (nonatomic) BJLDocumentDisplayInfo *displayInfo;

@end

NS_ASSUME_NONNULL_END
