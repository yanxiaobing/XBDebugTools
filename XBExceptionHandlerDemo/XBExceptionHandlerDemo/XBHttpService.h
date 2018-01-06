//
//  XBHttpService.h
//  XBExceptionHandlerDemo
//
//  Created by XBingo on 2018/1/6.
//  Copyright © 2018年 XBingo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

#define XBAPI(string) [XBHttpService apiWithString:string]

@interface XBHttpService : NSObject

+ (instancetype)sharedInstance;

+ (NSString *)apiWithString:(NSString *)string;

- (void)POSTWithURL:(NSString *)URLString
         parameters:(id)parameters
            success:(void (^)(NSDictionary *responseObject))success
            failure:(void (^)(NSError *error))failure;

@end
