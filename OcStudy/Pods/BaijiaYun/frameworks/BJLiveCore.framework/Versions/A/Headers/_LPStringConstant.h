//
//  _LPStringConstant.h
//  BJLiveCore
//
//  Created by Randy on 16/3/29.
//  Copyright © 2016 BaijiaYun. All rights reserved.
//

#ifndef _LPStringConstant_h
#define _LPStringConstant_h

#pragma mark - error string
#define _LP_STRING_ERROR_JSON_PARSE_FAIL BJLLocalizedString(@"数据解析失败")
#define _LP_STRING_ERROR_FILE_NO_EXIST BJLLocalizedString(@"文件不存在")
#define _LP_STRING_ERROR_NO_TOKEN BJLLocalizedString(@"用户验证失败")
#define _LP_STRING_ERROR_COMPRESS_FAIL BJLLocalizedString(@"数据压缩失败")
#define _LP_STRING_ERROR_LOGIN_FAIL BJLLocalizedString(@"登录失败")
#define _LP_STRING_ERROR_UNAUTH_LOGIN BJLLocalizedString(@"此账号没有登录权限")

#pragma mark network error
#define _LP_STRING_ERROR_NETWORK_NONE BJLLocalizedString(@"请检查你的网络设置")
#define _LP_STRING_WARN_NETWORK_3G BJLLocalizedString(@"请确认是否使用3G网络")

#pragma mark - notice string
//#define _LP_STRING_NOTICE_XXXX @""
#define _LP_STRING_NOTICE_TITLE BJLLocalizedString(@"提示")
#define _LP_STRING_NOTICE_DELETE_NOTES BJLLocalizedString(@"确定要删除所有的标注吗?")
#define _LP_STRING_NOTICE_DELETE_CONFIR BJLLocalizedString(@"删除")
#define _LP_STRING_NOTICE_CANCEL BJLLocalizedString(@"取消")
#define _LP_STRING_NOTICE_EXIT BJLLocalizedString(@"退出")
#define _LP_STRING_NOTICE_RETRY BJLLocalizedString(@"重试")
#define _LP_STRING_NOTICE_CONTINUE BJLLocalizedString(@"继续")
#define _LP_STRING_NOTICE_3G BJLLocalizedString(@"检测到你正在使用运营商网络，是否继续使用")
#define _LP_STRING_NOTICE_NONE BJLLocalizedString(@"没网了，快去设置网络吧")

#endif /* _LPStringConstant_h */
