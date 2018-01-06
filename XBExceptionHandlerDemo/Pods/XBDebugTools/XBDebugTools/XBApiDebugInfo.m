//
//  XBApiDebugInfo.m
//  XBExceptionHandler
//
//  Created by XBingo on 2017/12/18.
//  Copyright © 2017年 XBingo. All rights reserved.
//

#import "XBApiDebugInfo.h"

@implementation XBApiDebugInfo

- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {    
    [aCoder encodeObject:self.date forKey:@"date"];
    [aCoder encodeObject:self.url forKey:@"url"];
    [aCoder encodeObject:self.params forKey:@"params"];
    [aCoder encodeObject:self.response forKey:@"response"];
    [aCoder encodeBool:self.succeed forKey:@"succeed"];
    [aCoder encodeObject:self.domain forKey:@"domain"];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        self.date = [coder decodeObjectForKey:@"date"];
        self.url = [coder decodeObjectForKey:@"url"];
        self.params = [coder decodeObjectForKey:@"params"];
        self.response = [coder decodeObjectForKey:@"response"];
        self.succeed = [coder decodeBoolForKey:@"succeed"];
        self.domain = [coder decodeObjectForKey:@"domain"];
    }
    return self;
}

-(NSString *)description{
    
    return [NSString stringWithFormat:@"succeed: %@\n\n date: %@\n\n domain: %@\n\n url: %@\n\n params:\n %@\n\nresponse: \n%@\n\n",self.succeed ? @"成功":@"失败",self.date,self.domain,self.url,self.params,self.response];
}

@end
