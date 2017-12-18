//
//  XBApiDebugInfo.h
//  XBExceptionHandler
//
//  Created by XBingo on 2017/12/18.
//  Copyright © 2017年 XBingo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XBApiDebugInfo : NSObject<NSCoding>
@property (nonatomic ,strong) NSString *domain;             // 域名
@property (nonatomic ,strong) NSString *date;                 // 请求时间
@property (nonatomic ,strong) NSString *url;                // 请求地址
@property (nonatomic ,strong) NSString *params;             // 参数
@property (nonatomic ,strong) NSString *response;           // 请求结果
@property (nonatomic ,assign) BOOL succeed;                 // 是否成功

-(NSString *)description;

@end
