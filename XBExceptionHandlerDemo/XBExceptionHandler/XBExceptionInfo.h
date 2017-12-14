//
//  XBExceptionInfo.h
//  XBExceptionHandler
//
//  Created by XBingo on 2017/12/13.
//  Copyright © 2017年 XBingo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XBExceptionInfo : NSObject<NSCoding>

@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *reason;
@property (nonatomic, strong) NSArray<NSString *> *callStackSymbols;

@property (nonatomic, strong) NSString *systemVersion;
@property (nonatomic, strong) NSString *appVersion;
@property (nonatomic, strong) NSString *appBuild;


-(NSString *)toReadableDescription;

@end
