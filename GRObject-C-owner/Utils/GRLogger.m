//
//  GRLogger.m
//  GRObject-C-owner
//
//  Created by sen on 2016/9/23.
//  Copyright © 2016年 sen. All rights reserved.
//

#import "GRLogger.h"
#import "SystemInfo.h"

@implementation GRLogger


+ (void)load
{
#ifdef DEBUG
    fprintf(stderr, "****************************************************************************************\n");
    fprintf(stderr, "    											   \n");
    fprintf(stderr, "    	copyright (c) 2016, {GR}               \n");
    fprintf(stderr, "    	http://git.....                         \n");
    fprintf(stderr, "    										       \n");
#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
    
    fprintf(stderr, "    	%s %s	\n", [SystemInfo platformString].UTF8String, [SystemInfo osVersion].UTF8String);
    //    fprintf( stderr, "    	ip: %s	\n", [SystemInfo localIPAddress].UTF8String );
    fprintf(stderr, "    	运营商: %s	\n", [SystemInfo getCarrierName].UTF8String);
    //    fprintf(stderr, "    	手机唯一标识: %s	\n", [SystemInfo uuidSolution].UTF8String);
    fprintf(stderr, "    	Home: %s	\n", [NSBundle mainBundle].bundlePath.UTF8String);
    fprintf(stderr, "    												\n");
    fprintf(stderr, "****************************************************************************************\n");
#endif
    
#endif
}

+ (instancetype)sharedInstance
{
    static GRLogger* _instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[GRLogger alloc] init];
    });
    return _instance;
}


@end
