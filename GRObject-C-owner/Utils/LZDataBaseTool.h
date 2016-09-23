//
//  LZDataBaseTool.h

#import <Foundation/Foundation.h>

@interface LZDataBaseTool : NSObject

// 沙盒相关
+ (void)saveToUserDefaults:(id)object key:(NSString *)key;
+ (id)getUserDefaultsWithKey:(NSString *)key;

@end
