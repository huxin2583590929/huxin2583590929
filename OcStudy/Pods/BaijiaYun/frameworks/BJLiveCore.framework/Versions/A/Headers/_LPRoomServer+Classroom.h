//
//  _LPRoomServer+Classroom.h
//  BJLiveCore
//
//  Created by 杨磊 on 16/3/30.
//  Copyright © 2016 BaijiaYun. All rights reserved.
//

#import "_LPRoomServer.h"
#import "_LPResClassNotice.h"
#import "_LPReqRollcall.h"
#import "_LPSurveyRes.h"
#import "_LPResClassStart.h"
#import "_LPResClassEnd.h"
#import "_LPResCloudRecordModel.h"
#import "_LPResForbidUser.h"
#import "_LPResForbidUserState.h"
#import "_LPResQuestion.h"
#import "_LPResForbidGroup.h"
#import "_LPResForbidGroupState.h"
#import "BJLAnswerSheet.h"
#import "BJLQuiz.h"
#import "_LPMasterUser.h"
#import "_LPResForbidUserList.h"
#import "BJLRollCallResult.h"

/**
 *  教室相关信令服务
 */
@interface _LPRoomServer (Classroom)

- (void)regitsterSelectorsForResponsesForClassroom;

/**
 *  上课
 */
- (void)requestClassStart:(NSDictionary *)dictionary;
/**
 *  _LPResClassStart
 */
- (BJLObservable)onResponseClassStart:(_LPResClassStart *)model;

/**
 *  下课
 */
- (void)requestClassEnd;
/**
 *  _LPResClassEnd
 */
- (BJLObservable)onResponseClassEnd:(_LPResClassEnd *)model;

#pragma mark - cloud record

/**
 长期课生成回放之前清理画笔

 #param classId classId
 #param userId userId 
 */
- (void)requestRecordShapeClean:(NSString *)classId userId:(NSString *)userId;

/**
 * 请求转码
 */
- (void)requestServerRecodingStartProcessing;

/**
 转码请求被接受

 #param model _LPResCloudRecordModel
 */
- (BJLObservable)onResponseServerRecodingStartProcessing:(_LPResCloudRecordModel *)model;

/**
 切换清晰度通知

 #param size size
 */
- (void)requestServerRecodingChangeResolution:(CGSize)size;

/**
 清晰度切换被接受

 #param model _LPResCloudRecordModel
 */
- (BJLObservable)onResponseServerRecodingChangeResolution:(_LPResCloudRecordModel *)model;

#pragma mark - 公告

/**
 *  修改公告栏
 */
- (void)requestClassNoticeChange:(NSString *)content link:(NSString *)link groupID:(NSInteger)groupID;
/**
 *  _LPResClassNoticeChange
 */
- (BJLObservable)onResponseNoticeChanged:(_LPResClassNoticeChange *)model;

/**
 *  请求公告
 #param groupID 小组ID
 */
- (void)requestNoticeWithGroupID:(NSInteger)groupID;

/**
 *  _LPResClassNotice
 */
- (BJLObservable)onResponseNoticeResponse:(_LPResClassNotice *)model;

#pragma mark - 置顶消息

/**
 *  修改置顶消息
 */
- (void)requestStickMessageChange:(NSArray <BJLMessage *> *)messagelist;

/**
 *  请求置顶消息
 */
- (void)requestStickMessageWithCurrentGroupID:(NSInteger)groupID;

#pragma mark - 点名 答到

- (void)requestRollcallWithTimeout:(NSTimeInterval)timeout;

/** 结束点名
 */
- (void)finishRollcall;

/**
 *  请求上一次点名结果
 */
- (void)requestLastRollcallResult;

/** 请求收到最近一次点名数据 */
- (BJLObservable)onReceiveRollCallResult:(BJLRollCallResult *)result;

/**
 *  收到点名
 *  _LPReqRollcall
 */
- (BJLObservable)onResponseRollcall:(_LPReqRollcall *)model;

/**
 *  答到
 */
- (void)requestAnswerToRollcall;

#pragma mark - 专注度检测

/** 回复专注度检测 */
- (void)requestAnswerToAttentionDetection:(_LPMasterUser *)user attention:(BOOL)attention;

/* 收到专注度检测 */
- (BJLObservable)onResponseAttentionDetection:(NSDictionary *)dic;

/* 收到专注度检测提示 */
- (BJLObservable)onResponseAttentionAlert:(NSDictionary *)dic;

#pragma mark - 题目 答题 答题统计

/** 请求历史题目 */
- (void)loadSurveyHistoryWithUserNumber:(NSString *)userNumber;
/**
 *  收到历史题目以及当前用户的答题情况
 *  _LPSurveyRes
 */
- (BJLObservable)onResponseSurvey:(_LPSurveyRes *)res;

/**
 *  老师: 发送题目
 */
- (void)sendSurvey:(BJLSurvey *)survey;

/**
 *  学生: 收到新题目
 *  _LPSurveyReceive
 */
- (BJLObservable)onReceiveSurvey:(_LPSurveyReceive *)receive;
/**
 学生: 答题
 */
- (void)sendSurveyAnswerAnswers:(NSArray<NSString *> *)answers
                         result:(NSInteger)result
                          order:(NSInteger)order
                     userNumber:(NSString *)userNumber
                       userName:(NSString *)userName;

/**
 *  收到答题统计
 *  _LPSurveyResult
 */
- (BJLObservable)onReceiveSurveyResult:(_LPSurveyResult *)receive;

/**
 *  老师&管理员: 收到答题用户统计
 *  _LPSurveyUserResult
 */
- (BJLObservable)onReceiveSurveyUserResult:(_LPSurveyUserResult *)receive;

/**
 *  收到答题结束
 *  _LPSurveyUserResult
 */
- (BJLObservable)onReceiveSurveyClose;

#pragma mark - 小测 测验

- (BOOL)sendQuizRequest:(NSDictionary *)request;
// method: (NSDictionary *dict)
- (BJLMethodMeta *)signalOfReceiveQuiz;

- (void)requestQuizStartWithID:(NSString *)quizID force:(BOOL)force;
- (void)requestQuizEndWithID:(NSString *)quizID;
- (void)requestQuizSolutionPublishWithQuiz:(BJLQuiz *)quiz;
- (void)requestCurrentQuizWithUserNumber:(NSString *)userNumber;
- (void)requestSubmitQuizWithID:(NSString *)quizID solutions:(NSDictionary *)solutions fromUser:(BJLUser *)fromUser;
- (void)requestParentRoomFinishedQuiz;

#pragma mark - 禁言

/** 禁言单个用户 */
- (void)requestForbidUser:(BJLUser *)user
                 duration:(NSTimeInterval)duration
                     from:(BJLUser *)user;

/** 单个用户被禁言 */
// _LPResForbidUser
- (BJLObservable)onResponseForbidUser:(_LPResForbidUser *)model;

/** 助教禁言自己的分组 */
- (void)requestForbidGroupWithDuration:(NSTimeInterval)duration
                                  from:(BJLUser *)from;

/** 某个分组被禁言 */
- (BJLObservable)onResponseForbidGroup:(_LPResForbidGroup *)model;

/** 获取某个分组的禁言状态 */
- (void)requestForbidGroupStateWithID:(NSInteger)groupID;

/** 返回某个分组的禁言状态 */
- (BJLObservable)onResponseForbidGroupState:(_LPResForbidGroupState *)model;

/** 获取用户禁言状态 */
- (void)requestForbidUserStateWithUserNumber:(NSString *)userNumber;

/** 返回用户禁言状态 */
// _LPResForbidUserState
- (BJLObservable)onResponseForbidUserState:(_LPResForbidUserState *)model;

/** 请求当前禁言用户列表 */
- (void)requestForbidList;

/** 返回禁言用户列表 */
- (BJLObservable)onResponseForbidList:(_LPResForbidUserList *)userList;

#pragma mark - 创建题目

/** 请求拉取题目，页码从 0 开始 */
- (void)requestPullQuestionWithUserNumber:(NSString *)userNumber page:(NSInteger)page countPerPage:(NSInteger)perPageCount status:(NSInteger)status isSelf:(BOOL)isSelf;

/** 收到拉取到的题目信息，目前暂时用字典 */
- (BJLObservable)onReceiveQuestionPullResult:(NSDictionary *)dic;

/** 创建题目 */
- (void)requestSendQuestion:(NSString *)question fromUser:(BJLUser *)fromUser;

/** 收到创建题目的结果，目前暂时用字典 */
- (BJLObservable)onReceiveQuestionSendResult:(NSDictionary *)dic;

/** 发布，取消发布题目，回复题目 */
- (void)requestPublishQuestion:(BJLQuestion *)question;

/** 收到题目发布，取消发布，回复的结果，目前暂时用字典 */
- (BJLObservable)onReceiveQuestionPublish:(NSDictionary *)dic;

/** 改变用户禁止提问状态 */
- (void)requestSwitchQuestionForbid:(BOOL)forbid user:(BJLUser *)user fromUser:(BJLUser *)fromUser;

/** 收到禁止提问状态改变结果 */
- (BJLObservable)onReceiveQuestionForbidResult:(NSDictionary *)result;

#pragma mark - 画笔权限

- (void)requestGrantDrawingUserNumbers;
- (void)requestGrantDrawingWithUserNumbers:(NSArray *)userNumbers;
- (void)requestGrantDrawingWithUserNumbersAndColors:(NSDictionary *)UserNumbersAndColors;

- (BJLObservable)onResponseGrantDrawingUserNumbers:(NSArray<NSString *> *)dict;

- (void)requestStudentAuthority;
- (void)requestSwithStudentAuthority:(NSString *)Authority userNumbers:(NSArray<NSString *> *)userNumbers;

- (BJLObservable)onResponseStudentAuthority:(NSDictionary *)Authority;

#pragma mark - 答题器

/** 发布答题器题目 */
- (void)requestPublishQuestionAnswer:(BJLAnswerSheet *)answerSheet;

/** 收到答题器题目信息 */
- (BJLObservable)onReceiveQuestionAnswerPublished:(NSDictionary *)res;

/**
 停止/撤销答题器
 
 #param end YES表示结束， NO表示为撤销
 */
- (void)requestEndQuestionAnswer:(BOOL)end;

/**
收到停止/撤销答题信息
 
 #param end YES表示结束， NO表示为撤销
 #param endTime 结束/撤销时间戳

 */

- (BJLObservable)onReceiveQuestionAnswerEnd:(BOOL)end endTime:(NSTimeInterval)endTime;

/**
 收到答题信息
 
 */
- (BJLObservable)onReceiveQuestionAnswerSubmited:(NSDictionary *)res;

/**
 请求历史答题数据信息
 
 #param ID ID为空表示请求本节课所有答题历史数据

 */
- (void)requestQuestionAnswerInfoWithID:(NSString *)ID;

/**
 收到历史答题信息
 
 */
- (BJLObservable)onReceiveQuestionAnswerInfo:(NSDictionary *)res;

#pragma mark - 抢答器
/**
 发起抢答信息
 
 */
- (void)requestPublishQuestionResponderWithCountDownTime:(NSInteger)time;

/**
 收到抢答信息
 
 */
- (BJLObservable)onReceiveQuestionResponder:(NSDictionary *)res;

/**
 撤回抢答信息
 
 */
- (void)requestRevokeQuestionResponder;

/**
 请求结束抢答信息
 
 */
- (void)requestEndQuestionResponder;

/**
 收到抢答结束信息
 
 */
- (BJLObservable)onReceiveQuestionResponderEnd:(NSDictionary *)res;

/**
 参与抢答
 
 */
- (void)requestParticipateQuestionResponderWithUser:(BJLUser *)user;

#pragma mark - 分组点赞

/**
获取分组点赞信息
*/
- (void)requestAwardGroupInfo;

- (BJLObservable)onReceiveGroupAward:(NSDictionary *)res;

- (BJLObservable)onReceiveGroupAwardInfoList:(NSDictionary *)res;

#pragma mark - 随机选人

- (BJLObservable)onReceiveRandomSelectInfoList:(NSDictionary *)res;

#pragma mark - 抽奖: 标准抽奖 & 口令抽奖

/// 标准抽奖 - 结果
- (BJLObservable)onReceiveResultStandardLottery:(NSDictionary *)res;
/// 口令抽奖 - 开始
- (BJLObservable)onReceiveBeginCommandLottery:(NSDictionary *)res;

/// 口令抽奖 - 当学生发送的聊天信息匹配口令时，需要发送此请求
/// @param userNumber userNumber
- (void)requestHitCommandLottery:(NSString *)userNumber;
/// 口令抽奖 - 发送口令请求的res
- (BJLObservable)onReceiveHitCommandLottery:(NSDictionary *)res;
/// 口令抽奖 - 结果
- (BJLObservable)onReceiveResultCommandLottery:(NSDictionary *)res;
@end
