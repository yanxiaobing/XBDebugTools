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

@interface XBExceptionHandler : NSObject

+ (instancetype)sharedInstance;

//显示所有功能
- (void)showExceptionTools;

//获取奔溃日志列表
- (NSArray *)crashInfoList;

@end
