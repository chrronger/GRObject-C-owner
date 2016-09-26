//
//  NSObject+JudgeNull.m
//  GRObject-C-owner
//
//  Created by sen on 2016/9/26.
//  Copyright © 2016年 sen. All rights reserved.
//

#import "NSObject+JudgeNull.h"

@implementation NSObject (JudgeNull)
//判断对象是否为空
- (BOOL)isNull
{
    if ([self isEqual:[NSNull null]])
    {
        return YES;
    }
    else
    {
        if ([self isKindOfClass:[NSNull class]])
        {
            return YES;
        }
        else
        {
            if (self==nil)
            {
                return YES;
            }
        }
    }
    if ([self isKindOfClass:[NSString class]]) {
        if ([((NSString *)self) isEqualToString:@"(null)"]) {
            return YES;
        }
    }
    return NO;
}
@end
