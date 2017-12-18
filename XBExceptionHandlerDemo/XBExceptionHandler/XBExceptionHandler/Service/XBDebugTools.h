//
//  XBExceptionHandler.h
//  XBExceptionHandler
//
//  Created by XBingo on 2017/12/13.
//  Copyright © 2017年 XBingo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>
#import "XBExceptionInfo.h"
#import "XBApiDebugInfo.h"

typedef NS_ENUM(NSInteger ,XBDebugType) {
    XBDebugTypeCrashInfo,
    XBDebugTypeApiInfo
};

@interface XBDebugTools : NSObject

+ (instancetype)sharedInstance;


-(void)addApiDebugInfoWithDomain:(NSString *)domain
                             url:(NSString *)url
                       params:(NSDictionary *)params
                     response:(NSDictionary *)response
                      succeed:(BOOL)succeed;

// 显示所有功能
- (void)showExceptionTools;

// 获取奔溃日志列表
- (NSArray *)crashInfoList;

// 获取api日志列表
- (NSArray *)apiDebugInfoList;

@end
