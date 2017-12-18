//
//  XBExceptionHandler.m
//  XBExceptionHandler
//
//  Created by XBingo on 2017/12/13.
//  Copyright © 2017年 XBingo. All rights reserved.
//

#import "XBExceptionHandler.h"
#import "XBExceptionViewController.h"

@interface XBExceptionHandler()

@end

static NSString *const kLogPath = @"Library/Caches/XBExceptions";

@implementation XBExceptionHandler
{
    NSUncaughtExceptionHandler *previousExceptionHandler;
}

void UncaughtExceptionHandler(NSException *exception) {
    [[XBExceptionHandler sharedInstance] dealWithException:exception];
}


+ (instancetype)sharedInstance
{
    static XBExceptionHandler *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        previousExceptionHandler = NSGetUncaughtExceptionHandler();
        NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);
    }
    return self;
}

-(void)showExceptionTools{
    [XBExceptionViewController present];
}

-(void)dealWithException:(NSException *)exception{
    [self recordException:exception];
    [self noticeException:exception];
    if (previousExceptionHandler) {
        previousExceptionHandler(exception);
    }
}

// 保存异常信息
- (void)recordException:(NSException *)exception{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *dateStr = [formatter stringFromDate:[NSDate date]];
    
    NSString *exceptionPath = [NSHomeDirectory() stringByAppendingPathComponent:kLogPath];
    if (![[NSFileManager defaultManager] fileExistsAtPath:exceptionPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:exceptionPath withIntermediateDirectories:YES attributes:NULL error:NULL];
    }
    NSString *path = [exceptionPath stringByAppendingFormat:@"/%@", dateStr];
    
    NSString * systemVersion = [UIDevice currentDevice].systemVersion;
    NSString * appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *appBuild = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    
    XBExceptionInfo *info = [XBExceptionInfo new];
    info.date = dateStr;
    info.name = exception.name;
    info.reason = exception.reason;
    info.callStackSymbols = exception.callStackSymbols;
    info.systemVersion = systemVersion;
    info.appVersion = appVersion;
    info.appBuild = appBuild;
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:info];
    [data writeToFile:path atomically:YES];
}

// 发送通知
-(void)noticeException:(NSException *)exception{

    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
        UNMutableNotificationContent* content = [[UNMutableNotificationContent alloc] init];
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
        content.title = [NSString stringWithFormat:@"%@~奔溃啦🤣",app_Name];
        content.body = exception.name;
        content.sound = [UNNotificationSound defaultSound];
        UNTimeIntervalNotificationTrigger* trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:2 repeats:NO];
        content.userInfo = @{@"type":@"crash"};
        UNNotificationRequest* request = [UNNotificationRequest requestWithIdentifier:@"Crash"                                    content:content trigger:trigger];
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
            dispatch_semaphore_signal(semaphore);
        }];
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    }else{
        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:2];
        localNotification.alertBody = exception.name;
        localNotification.soundName = UILocalNotificationDefaultSoundName;
        localNotification.userInfo = @{@"type" : @"xb_crash"};
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    }
}

- (NSArray *)crashInfoList {
    
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:kLogPath];
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    NSMutableArray *array = [NSMutableArray array];
    for (NSString *file in files) {
        NSData *data = [NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",path,file]];
        XBExceptionInfo *info = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        [array insertObject:info atIndex:0];
    }
    return array;
}
@end


