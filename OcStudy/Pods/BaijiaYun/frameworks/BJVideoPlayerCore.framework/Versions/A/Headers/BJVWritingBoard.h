//
//  BJVWritingBoard.h
//  BJVideoPlayerCore
//
//  Created by 辛亚鹏 on 2021/7/5.
//  Copyright © 2021 BaijiaYun. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BJVUser.h"

NS_ASSUME_NONNULL_BEGIN

/** 小黑板状态 */
typedef NS_ENUM(NSInteger, BJLIcWriteBoardStatus) {
    /** 默认状态 */
    BJLIcWriteBoardStatus_None,
    /** 老师编辑小黑板 */
    BJLIcWriteBoardStatus_teacherEditing,
    /** 老师已发布小黑板未收回 */
    BJLIcWriteBoardStatus_teacherPublished,
    /** 老师已收回小黑板 */
    BJLIcWriteBoardStatus_teacherGathered,
    /** 分享 */
    BJLIcWriteBoardStatus_teacherShare,
    /** 学生作答中 */
    BJLIcWriteBoardStatus_studentEdit
};

/** 小黑板发布操作 */
typedef NS_ENUM(NSInteger, BJVWritingBoardPublishOperate) {
    /** 结束 */
    BJVWritingBoardPublishOperate_end,
    /** 开始 */
    BJVWritingBoardPublishOperate_begin,
    /** 撤销 */
    BJVWritingBoardPublishOperate_revoke
};


@interface BJVWritingBoard : NSObject

@property (nonatomic, readonly) NSString *boardID;
@property (nonatomic, readonly) NSInteger pageIndex;

@property (nonatomic) BOOL isActive;
@property (nonatomic) NSInteger duration;
@property (nonatomic) NSTimeInterval startTime;
@property (nonatomic) BJVWritingBoardPublishOperate operate;

@property (nonatomic, readonly) BJVUser *fromUser; // only user `ID、number、avatar、name` available
@property (nonatomic, readonly) NSArray<BJVUser *> *submitedUsers;
@property (nonatomic, readonly) NSArray<BJVUser *> *participatedUsers;

@property (nonatomic) BJLIcWriteBoardStatus status;

/* 小黑板所属user的name , 用于分享的窗口显示用户名*/
@property (nonatomic, nullable) NSString *userName;

- (instancetype)initWithBoardID:(NSString *)boardID pageIndex:(NSInteger)pageIndex;

@end

NS_ASSUME_NONNULL_END
