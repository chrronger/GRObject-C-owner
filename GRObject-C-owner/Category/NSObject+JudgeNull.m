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
     if(self.length ==  0 || [self isKindOfClass:[NSNull class]] || self == nil || self == NULL || [self isEqualToString:@"(null)"] || [[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0 || [self isEqualToString:@"null"])
    {
        return NO;
    }
    return YES;
}
@end
