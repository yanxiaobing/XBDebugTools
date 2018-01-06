//
//  XBHttpService.m
//  XBExceptionHandlerDemo
//
//  Created by XBingo on 2018/1/6.
//  Copyright © 2018年 XBingo. All rights reserved.
//

#import "XBHttpService.h"
#import "XBDebugTools.h"

@interface XBHttpService() {
    AFHTTPSessionManager *sessionManager;
}
@end

@implementation XBHttpService

+(NSString *)server {
    
    return @"https://www.baidu.com";
    
}

+ (NSString *)apiWithString:(NSString *)string {
    NSString *url = [NSString stringWithFormat:@"%@/%@", [self server], string];
    return url;
}

+ (instancetype)sharedInstance
{
    static XBHttpService *_instance;
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
        sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:[XBHttpService server]]];
        
        // responseSerializer
        sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects: @"application/json", @"text/json", @"text/javascript", nil];
        
        // requestSerializer
        sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
        sessionManager.requestSerializer.timeoutInterval = 30;
        [sessionManager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        
        // securityPolicy
        sessionManager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        sessionManager.securityPolicy.allowInvalidCertificates = YES;
        sessionManager.securityPolicy.validatesDomainName = NO;
        
    }
    return self;
}

- (void)POSTWithURL:(NSString *)URLString
         parameters:(id)parameters
            success:(void (^)(NSDictionary *responseObject))success
            failure:(void (^)(NSError *error))failure {
    
    NSDictionary *params = [self paramsWithData:parameters];
    
    [sessionManager POST:URLString parameters:params progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSData *data = [self unzipData:responseObject];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        if (success) {
            success(dict);
        }
        
#if DEBUG
        [[XBDebugTools sharedInstance] addApiDebugInfoWithDomain:[XBHttpService server] url:URLString params:params response:dict succeed:YES];
#endif
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error);
        }
#if DEBUG
        [[XBDebugTools sharedInstance] addApiDebugInfoWithDomain:[XBHttpService server] url:URLString params:params response:@{@"errorDes":error.localizedDescription} succeed:NO];
#endif
    }];
}

- (NSDictionary *)paramsWithData:(NSDictionary *)data {
    //TODO 组装公共的参数
    
    return data;
}

-(id)unzipData:(id)obj{
    //TODO 如果解压服务端返回的数据
    return obj;
}

@end
