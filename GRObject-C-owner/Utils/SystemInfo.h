//
//  SystemInfo.h
//  GRObject-C-owner
//
//  Created by sen on 2016/9/23.
//  Copyright © 2016年 sen. All rights reserved.
//   系统信息工具类

#import <Foundation/Foundation.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <UIKit/UIKit.h>

@interface SystemInfo : NSObject

/*系统版本*/
+ (NSString*)osVersion;

/*硬件版本*/
+ (NSString*)platform;

/*硬件版本名称*/
+ (NSString*)platformString;

/*系统当前时间 格式：yyyy-MM-dd HH:mm:ss*/
+ (NSString*)systemTimeInfo;

/*软件版本*/
+ (NSString*)appVersion;

/*是否是iPhone5*/
+ (BOOL)is_iPhone_5;

/*是否越狱*/
//+ (BOOL)isJailBroken;

/*越狱版本*/
+ (NSString*)jailBreaker;

/*本地ip*/
//+ (NSString *)localIPAddress;

/** 获取运营商 */
+ (NSString*)getCarrierName;

/** UUID解决方案 */
//+ (NSString*)uuidSolution;

@end
