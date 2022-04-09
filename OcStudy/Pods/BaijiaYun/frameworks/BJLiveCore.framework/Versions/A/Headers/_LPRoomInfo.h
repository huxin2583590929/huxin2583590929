//
//  _LPRoomInfo.h
//  BJLiveCore
//
//  Created by 杨磊 on 16/4/29.
//  Copyright © 2016 BaijiaYun. All rights reserved.
//

#import "_LPDataModel.h"

/** 小班课教室子类型 */
typedef NS_ENUM(NSInteger, BJLRoomSubtype) {
    /** 自习室 */
    BJLRoomSubtypeStudyRoom = 1,
};

@interface _LPRoomInfo : _LPDataModel

@property (nonatomic) NSString *roomId;
@property (nonatomic) NSString *title;
@property (nonatomic) NSTimeInterval startTime;
@property (nonatomic) NSTimeInterval startTimeMillisecond;
@property (nonatomic) NSTimeInterval endTime;
@property (nonatomic) BJLRoomType roomType;
@property (nonatomic) BJLRoomSubtype roomSubtype; //子教室类型，现在仅仅只有 1: 自习室，这种类型
@property (nonatomic) BJLIcTemplateType interactiveClassTemplateType;
@property (nonatomic) BOOL isMockLive;          // 是否是伪直播
@property (nonatomic) BOOL isPushLive;          // 是否是推流直播
@property (nonatomic) BOOL isVideoWall;         // 是否是视频墙直播
@property (nonatomic) BOOL isPureVideo;         // 是否是纯视频模板（纯视频不能切换布局，视频墙可以切换），仅大班课
@property (nonatomic) BOOL isLongTerm;          // 是否为长期大班课
@property (nonatomic) BOOL isDoubleCamera;      // 是否为双摄像头模板

@property (nonatomic) NSString *partnerId;
@property (nonatomic) NSString *environmentName;
@property (nonatomic) NSString *customerSupportMessage;

@property (nonatomic) BJLRoomGroupType roomGroupType;
@property (nonatomic) BJLRoomNewGroupType newRoomGroupType;
@property (nonatomic) BOOL enableGroupUser;// 分组用户可见
@property (nonatomic) BOOL enableGroupInSmallRoom;// 大小班切换到大班之后是否允许分组，该设置仅对旧版分组直播有效
@property (nonatomic) BOOL enableGroupInNewSmallRoom;// 大小班切换到大班之后是否允许分组，该设置对新版线上双师和分组课堂有效

@property (nonatomic, readonly) BOOL isStudyRoom;  //是否是自习室，这里仅实现了get方法
@property (nonatomic) BOOL studyRoomEnableDiscuss; // 自习室是否允许讨论
@property (nonatomic) BOOL studyRoomEnableTeach;   // 自习室是否允许授课

// 是否是场外辅导1v1的教室
@property (nonatomic) BOOL tutorOutsideRoom;

// 自习室是否允许发送场外求助
@property (nonatomic) BOOL studyRoomEnableSendTutorOutsideQuestion;

#pragma mark - internal

@property (nonatomic) NSString *masterURL;
@property (nonatomic) NSArray<NSString *> *masterURLs;
@property (nonatomic) BOOL recordStudentMedia;
@property (nonatomic) BOOL recordSignal;

@property (nonatomic) NSString *cover; // 啥？
@property (nonatomic) NSString *adminCode;
@property (nonatomic) NSString *teacherCode;
@property (nonatomic) NSString *userCode;

@property (nonatomic) id extraInfo; // 透传 HTTPS 服务端的信息传递给 WebScoket 服务端，目前一般为字符串

#pragma mark - logStat

@property (nonatomic) NSInteger logStatRoomType; //用于透传上报班型的字段
@end
