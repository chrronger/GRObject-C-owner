//
//  GRJudgeVPN.m
//  GRObject-C-owner
//
//  Created by sen on 2016/10/21.
//  Copyright © 2016年 sen. All rights reserved.
//

#import "GRJudgeVPN.h"
#import <ifaddrs.h>


@implementation GRJudgeVPN

+(BOOL)isVPNConnected
{
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            NSString *string = [NSString stringWithFormat:@"%s" , temp_addr->ifa_name];
            if ([string rangeOfString:@"tap"].location != NSNotFound ||
                [string rangeOfString:@"tun"].location != NSNotFound ||
                [string rangeOfString:@"ppp"].location != NSNotFound){
                return YES;
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    // Free memory
    freeifaddrs(interfaces);
    return NO;
    
}

//- (BOOL)checkForConnectivity:(NSString *)hostName
//{
//    BOOL success = false;
//    
//    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(NULL, [hostName UTF8String]);
//    SCNetworkReachabilityFlags flags;
//    success = SCNetworkReachabilityGetFlags(reachability, &flags);
//    CFRelease(reachability);
//    
//    NSLog(@"success=%x", flags);
//    
//    // this is the standard non-VPN logic, you might have to alter it for VPN connectivity
//    
//    BOOL isAvailable = success && (flags & kSCNetworkFlagsReachable) && !(flags & kSCNetworkFlagsConnectionRequired);
//    if (isAvailable) {
//        NSLog(@"Host is reachable: %d", flags);
//        return YES;
//    }else{
//        NSLog(@"Host is unreachable");
//        return NO;
//    }
//}

@end
