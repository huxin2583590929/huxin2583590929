//
//  _LPRoomServer+sell.h
//  BJLiveCore
//
//  Created by 凡义 on 2020/11/14.
//  Copyright © 2020 BaijiaYun. All rights reserved.
//

#import "_LPRoomServer.h"

NS_ASSUME_NONNULL_BEGIN

@interface _LPRoomServer (sell)

- (void)regitsterSelectorsForResponsesForSell;

#pragma mark - like

/** 进教室点赞数据请求 */
- (void)requestLikeCountFrom:(BJLUser *)user;

/** 请求点赞 */
- (void)requestAddLikeCount:(NSInteger)likeCount
                       from:(BJLUser *)user;

/** 回调：收到点赞数据 */
- (BJLObservable)onResponseLikeInfo:(NSDictionary *)likeInfo;

#pragma mark - gift

/** 进教室礼物数据请求 */
- (void)requestGiftCount;

/** 主播礼物数据更新 */
- (BJLObservable)onResponseUpdateGiftInfo:(NSDictionary *)giftInfo;

/** 请求送礼 */
- (void)requestSendGiftID:(NSInteger)giftID
                    count:(NSInteger)count
                     from:(BJLUser *)user;

/** 请求送礼回调 */
- (BJLObservable)onResponseSendGiftInfo:(NSDictionary *)giftInfo;

/** 10秒对学生同步一次主播礼物增量数据 */
- (BJLObservable)onResponseNewGiftInfo:(NSDictionary *)giftInfo;

@end

NS_ASSUME_NONNULL_END
