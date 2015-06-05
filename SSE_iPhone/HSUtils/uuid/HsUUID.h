////////////////////////////////////////////////////////////////////////////////
/// CORYRIGHT NOTICE
/// Copyright (c) 2014年 hundsun. All rights reserved.
///
/// @系统名称   CRM-iPad
/// @模块名称   工具类-UUID
/// @文件名称   HsUUID.h
/// @功能说明   根据ios版本返回UUID,如果是ios6,统一返回网卡地址.
///             如果ios7以及以上,返回apple.identifierForVendor
///             UUID将保存在keychain里面.
///
/// @软件版本   1.0.0.0
//  Created by Mead on 9/3/13.
///
/// @修改记录：
///
////////////////////////////////////////////////////////////////////////////////
//

#import <Foundation/Foundation.h>

@interface HsUUID : NSObject


/*
 * @brief obtain Unique Device Identity
 */
+ (NSString*)UDID;

@end
