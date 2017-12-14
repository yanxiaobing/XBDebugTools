//
//  XBExceptionInfo.m
//  XBExceptionHandler
//
//  Created by XBingo on 2017/12/13.
//  Copyright © 2017年 XBingo. All rights reserved.
//

#import "XBExceptionInfo.h"

@implementation XBExceptionInfo

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.date forKey:@"date"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.reason forKey:@"reason"];
    [aCoder encodeObject:self.callStackSymbols forKey:@"callStackSymbols"];
    [aCoder encodeObject:self.systemVersion forKey:@"systemVersion"];
    [aCoder encodeObject:self.appVersion forKey:@"appVersion"];
    [aCoder encodeObject:self.appBuild forKey:@"appBuild"];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.date = [aDecoder decodeObjectForKey:@"date"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.reason = [aDecoder decodeObjectForKey:@"reason"];
        self.callStackSymbols = [aDecoder decodeObjectForKey:@"callStackSymbols"];
        self.systemVersion = [aDecoder decodeObjectForKey:@"systemVersion"];
        self.appVersion = [aDecoder decodeObjectForKey:@"appVersion"];
        self.appBuild = [aDecoder decodeObjectForKey:@"appBuild"];
    }
    return self;
}


-(NSString *)toReadableDescription{
    return [NSString stringWithFormat:@"date: %@\n\nname: %@\n\nreason: %@\n\nsystem_version: %@\n\napp_version: %@\n\napp_build: %@\n\ncallStackSymbols:\n%@", self.date, self.name, self.reason, self.systemVersion,self.appVersion,self.appBuild,self.callStackSymbols];
}

@end
