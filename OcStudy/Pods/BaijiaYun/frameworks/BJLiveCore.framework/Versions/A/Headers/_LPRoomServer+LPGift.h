//
//  _LPRoomServer+LPGift.h
//  BJLiveCore
//
//  Created by Randy on 16/3/30.
//  Copyright © 2016 BaijiaYun. All rights reserved.
//

#import "_LPRoomServer.h"

#import "_LPGiftModel.h"
#import "_LPResRoomGiftHistory.h"
#import "_LPResRoomGiftReceive.h"

/**
 *  礼物相关信令服务
 */

@interface _LPRoomServer (_LPGift)

- (void)regitsterSelectorsForResponsesForGift;

/**
 *  请求打赏记录
 */
- (void)requestGiftMyHistory;
/**
 *  _LPResRoomGiftHistory
 */
- (BJLObservable)onResponseGiftHistory:(_LPResRoomGiftHistory *)gift;

/**
 *  _LPResRoomGiftReceive
 */
- (BJLObservable)onResponseGiftReceive:(_LPResRoomGiftReceive *)gift;

/**
 *  给老师打赏
 */
- (void)requestGiftSend:(_LPGiftModel *)gift from:(BJLUser *)user to:(BJLUser *)teacher;

@end
