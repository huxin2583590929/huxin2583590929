//
//  BJLFeatureConfig.h
//  BJLiveCore
//
//  Created by 杨磊 on 16/7/18.
//  Copyright © 2016 BaijiaYun. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BJLConstants.h"

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT const NSInteger BJLDoodleVersion;

typedef NS_ENUM(NSInteger, BJLStudentWhisperRole) {
    BJLStudentWhisperRoleAll = 0,
    BJLStudentWhisperRoleTeacher = 1,
    BJLStudentWhisperRoleAssistant = 2,
};

typedef NS_ENUM(NSInteger, BJLVideoMirrorMode) {
    BJLVideoMirrorModeDisable = 0,
    BJLVideoMirrorModeHorizontal = 1,
    BJLVideoMirrorModeVertical = 2,
    BJLVideoMirrorModeHorizontalAndVertical = 3,
};

@interface BJLFeatureConfig : NSObject <NSCopying, NSCoding>

#pragma mark - common

/// webrtc 类型
@property (nonatomic, readonly) BOOL isWebRTC;
@property (nonatomic, readonly) BJLPlayerType playerType;

/// 禁止举手
@property (nonatomic, readonly) BOOL disableSpeakingRequest;
@property (nonatomic, readonly, copy, nullable) NSString *disableSpeakingRequestReason;
/// 举手通过后自动打开摄像头
@property (nonatomic, readonly) BOOL autoPublishVideoStudent;

/// 分享
@property (nonatomic, readonly) BOOL enableShare;

@property (nonatomic, readonly) BJLMediaLimit mediaLimit;
@property (nonatomic, readonly) BOOL autoStartServerRecording;

/// 老师助教标签（用户列表里显示的“老师”、“助教”）
@property (nonatomic, readonly, copy, nullable) NSString *teacherLabel, *assistantLabel;

/// 隐藏技术支持消息, #see BJLClientType
@property (nonatomic, readonly) NSArray<NSNumber *> *forbiddenClientTypes;

/// 隐藏技术支持消息
@property (nonatomic, readonly) BOOL hideSupportMessage;
/// 隐藏用户列表
@property (nonatomic, readonly) BOOL hideUserList;
/// 小班课支持以文档形式打开图片
@property (nonatomic, readonly) BOOL enableOpenImageAsPPT;
/// 禁用 H5 实现的 PPT 动画
@property (nonatomic, readonly) BOOL disablePPTAnimation;
/// 支持多白板
@property (nonatomic, readonly) BOOL enableMutiBoard;
/// 支持私聊
@property (nonatomic, readonly) BOOL enableWhisper;
/// 学生私聊允许 at 的用户的群组
@property (nonatomic, readonly) BJLStudentWhisperRole studentWhisperRole;
/// 支持全体禁言下私聊老师
@property (nonatomic, readonly) BOOL enableWhisperToTeacherWhenForbidAll;
/// 支持聊天文本翻译
@property (nonatomic, readonly) BOOL enableChatTranslation;
/// 支持答题器
@property (nonatomic, readonly) BOOL enableAnswerSheet;
/// 支持问答
@property (nonatomic, readonly) BOOL enableQuestion;
/// 支持红包雨
@property (nonatomic, readonly) BOOL enableRedPackage;
/// 最大红包雨数量
@property (nonatomic, readonly) NSInteger maxRedPackageCount;
/// 支持切换主讲
@property (nonatomic, readonly) BOOL canChangePresenter;
/// 【禁用】授权画笔功能 - 可上麦状态就有画笔
@property (nonatomic, readonly) BOOL disableGrantDrawing;
/// 举手超时时间
@property (nonatomic, readonly) NSTimeInterval speakingRequestTimeoutInterval;
/// 丢包率边界 - 超过界限认为网络差
@property (nonatomic, readonly) CGFloat lossRateBoundary;
/// 试听结束提示文案
@property (nonatomic, readonly, copy, nullable) NSString *auditionEndTip;
/// 试听结束跳转地址
@property (nonatomic, readonly, copy, nullable) NSString *auditionEndLink;
/// 是否展示表情报告
@property (nonatomic, readonly) BOOL enableExpressExport;
/// 是否展示课后评价
@property (nonatomic, readonly) BOOL enableEvaluation;
/// 课后评价开关
@property (nonatomic, readonly) BOOL evaluationSwitch;
/// 禁止学生本地翻页
@property (nonatomic, readonly) BOOL disableStudentChangePPTPage;
/// H5课件是否允许学生翻页
@property (nonatomic, readonly) BOOL enableStudentWebPPTChangePage;

/**
 丢包率数组, 某一个值为0 表示未配置, eg:[5, 10, 20, 30, 90]
 [0, 5) && 持续时长`lossRateRetainTime` -> 网络正常
 [5, 10) && 持续时长`lossRateRetainTime` -> 网络较差
 [10, 20) && 持续时长`lossRateRetainTime` -> 网络差
 [20, 30) && 持续时长`lossRateRetainTime` -> 网络极差
 [30, 90) && 持续时长`lossRateRetainTime` -> 网络极度差
 [90, 100] -> 建议阻塞直播
 */
@property (nonatomic, readonly) NSArray <NSNumber *> *lossRateLevelArray;
/// 丢包率持续时间
@property (nonatomic, readonly) CGFloat lossRateRetainTime;

/// 老师是否邀请学生强制上麦
@property (nonatomic, readonly) BOOL inviteSpeakByForce;

/// 是否隐藏学生端的录制状态
@property (nonatomic, readonly) BOOL hideRecordStatusOfStudent;

/// 是否隐藏老师助教端的录制状态按钮
@property (nonatomic, readonly) BOOL hideRecordStatusOfTeacherAndAssistant;

/// 学生是否允许使用激光笔工具
@property (nonatomic, readonly) BOOL enableStudentUseLaserTool;

/// 老师是否允许踢人
@property (nonatomic, readonly) BOOL enableKickOut;

/// 隐藏学生摄像头开关
@property (nonatomic, readonly) BOOL hideStudentCamera;

/// 隐藏学生画笔
@property (nonatomic, readonly) BOOL hideStudentBrush;

/// 是否支持作业区功能
@property (nonatomic, readonly) BOOL enableHomework;

/// 是否允许老师授权学生操作h5格式的课件
@property (nonatomic, readonly) BOOL canShowH5PPTAuthButton;

/// 录制类型
@property (nonatomic, readonly) BJLServerRecordingType cloudRecordType;

/// 支持外接移动端摄像头
@property (nonatomic, readonly) BOOL enableAttachPhoneCamera;

/// 学生可以提前进入教室的时间, 单位分钟
@property (nonatomic, readonly) NSTimeInterval studentPreEnterTime;

/// 是否禁用iOS14的 Phpicker （新的照片picker）
@property (nonatomic, readonly) BOOL disablePhpicker;

/// 是否开启禁止录屏功能
@property (nonatomic, readonly) BOOL enablePreventScreenCapture;

/// 是否禁用 RequiresFullScreen 检查，一般情况下是开启的
@property (nonatomic, readonly) BOOL disableRequiresFullScreenMask;

/// 学生上台默认是否授予画笔权限
@property (nonatomic, readonly) BOOL autoGrantDrawingForActiveStudent;

/// 是否允许使用智写云笔手写板
@property (nonatomic, readonly) BOOL enableUseHandWritingBoard;

#pragma mark - 教室控制区功能开关

/// 切换布局
@property (nonatomic, readonly) BOOL enableSwitchRoomLayout;

/// 一键开关麦克风
@property (nonatomic, readonly) BOOL enableOperateAllMic;

/// 禁止/允许举手
@property (nonatomic, readonly) BOOL enableForbidRaiseHand;

#pragma mark - 教学工具启用开关

/// 打开网页
@property (nonatomic, readonly) BOOL enableUseWebpage;

/// 小黑板
@property (nonatomic, readonly) BOOL enableUseSnippet;

/// 答题器
@property (nonatomic, readonly) BOOL enableUseAnswer;

/// 抢答器
@property (nonatomic, readonly) BOOL enableUseRaceAnswer;

/// 计时器
@property (nonatomic, readonly) BOOL enableUseTimer;

/// 点名
@property (nonatomic, readonly) BOOL enableSignIn;


#pragma mark - 1VN

/// 当前登录用户是否支持720p
@property (nonatomic, readonly) BOOL support720p;
/// 当前登录用户是否支持1080p
@property (nonatomic, readonly) BOOL support1080p;

/// 三分屏模板的右侧tab配置项
@property (nonatomic, readonly) NSString *liveTabs;

/// 三分屏模板的右侧学生互动区配置
@property (nonatomic, readonly) NSString *liveTabsOfStudent;

/// 老师切换ppt和老师采集视频是否需要同步学生端
@property (nonatomic, readonly) BOOL shouldSyncPPTVideoSwitch;

/// 当前教室是否为无感知录制
@property (nonatomic, readonly) BOOL secretCloudRecord;

/// 当前教室是否支持助教使用切主讲功能
@property (nonatomic, readonly) BOOL enableAssistantChangePresenter;

/// 三分屏模板是否以视频为主
@property (nonatomic, readonly) BOOL shouldVideoInMajor;

/// 大班课是否支持同时显示双摄像头和课件
@property (nonatomic, readonly) BOOL enablePPTShowWithAssistCamera;

/// 大班课当主讲切换后，旧的主讲是否自动关闭音视频推流
@property (nonatomic, readonly) BOOL enableAutoCloseOldPresenterMedia;

/// 大班课老师推流默认清晰度
@property (nonatomic, readonly) BJLVideoDefinition defaultVideoDefinition;

/// 大班课学生推流默认清晰度
@property (nonatomic, readonly) BJLVideoDefinition defaultStudentVideoDefinition;

/// 支持大小班切换的教室在大班中是否可见其他组成员
@property (nonatomic, readonly) BOOL enableShowAllGroupMember;

#pragma mark - intractive class

/// 小班课的最大清晰度值
@property (nonatomic, readonly) BJLVideoDefinition maxVideoDefinition;

/// 小班课最大台上人数
@property (nonatomic, readonly) NSInteger maxActiveUserCount;
/// 小班课最大台下人数
@property (nonatomic, readonly) NSInteger maxBackupUserCount;
/// 小班课支持台下用户时是否需要自动上台
@property (nonatomic, readonly) BOOL autoGoOnStage;

/// 助教是否有权限上下课
@property (nonatomic, readonly) BOOL enableAssistantStartClass;

/// 学生上台是否默认开音频
@property (nonatomic, readonly) BOOL shouleStudentOpenAudioDefault;

/// 小班课是否允许设置听除老师外的用户的音频
@property (nonatomic, readonly) BOOL enablePullAudioOnly;

/// 小班课黑板页数
@property (nonatomic, readonly) NSInteger blackboardPages;

/// 小班课是否支持课前自动打开课件功能
@property (nonatomic, readonly) BOOL enablPreOpenDocument;

/// 自习室是否开启场内辅导
@property (nonatomic, readonly) BOOL studyRoomEnableTutor;

/// 自习室是否开启场外辅导
@property (nonatomic, readonly) BOOL studyRoomEnableTutorOutside;

/// 是否开启镜像翻转菜单
@property (nonatomic, readonly) BJLVideoMirrorMode videoMirrorMode;

/// 是否默认开启聊天飘窗
@property (nonatomic, readonly) BOOL enableChatPanel;

/// 小班课1v1是否把聊天窗口放在头像下面
@property (nonatomic, readonly) BOOL enableChatPanelUnderVideoOn1v1;

#pragma mark - color

/// 允许小班课黑板读取主题配置，不使用配置的黑板背景图
@property (nonatomic, readonly) BOOL enableNewBlackboardConfig;

/// 小班课教室背景图
@property (nonatomic, readonly) NSString *backgroundURLString;

/// 小班课黑板背景图
@property (nonatomic, readonly) NSString *blackboardURLString;

/// 小班课加载页面logo
@property (nonatomic, readonly) NSString *loadingLogoURLString;

/// 小班课加载页面背景图
@property (nonatomic, readonly) NSString *loadingBackgroundURLString;

/// 小班课加载页面进度条颜色值, eg: #FFFFFF
@property (nonatomic, readonly) NSString *loadingBarColor;

/// 小班课加载页面 进度百分比值文本颜色值, eg: #FFFFFF
@property (nonatomic, readonly) NSString *loadingTextColor;

/// 颜色配置
@property (nonatomic, readonly) NSDictionary *customColors;

@end

NS_ASSUME_NONNULL_END
