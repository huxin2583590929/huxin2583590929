//
//  _LPConstants.h
//  BJLiveCore
//
//  Created by 杨磊 on 16/3/28.
//  Copyright © 2016 BaijiaYun. All rights reserved.
//

#ifndef _LPConstants_h
#define _LPConstants_h

#import "BJLConstants.h"

/** 学生发言状态 */
typedef NS_ENUM(NSUInteger, _LPSpeakState) {
    /** 发言 */
    _LPSpeakState_free = 0,
    /** 禁止 */
    _LPSpeakState_limit = 1
};

/**
 根据 cdn 字符串返回 cdn tag

 #param cdn cdn 字符串
 */
static inline NSString *_LPCDNTag(NSString *cdn) {
    if ([cdn hasPrefix:@"push"] || [cdn hasPrefix:@"pull"]) {
        // 去掉开头的 "push" 或 "pull"
        NSString *cdnTag = [cdn substringFromIndex:4];
        NSRange range = [cdnTag rangeOfString:@"-"];
        if (range.location != NSNotFound) {
            // 去掉第一个 "-" 号及它之后的内容
            cdnTag = [cdnTag substringToIndex:range.location];
            return cdnTag;
        }
    }
    return @"";
}

#endif /* _LPConstants_h */
