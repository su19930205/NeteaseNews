//
//  NetWorkTools.m
//  新闻
//
//  Created by mac on 15/8/30.
//  Copyright (c) 2015年 szh. All rights reserved.
//

#import "NetWorkTools.h"

@implementation NetWorkTools

+(instancetype)sharedNetworkTools
{
    static NetWorkTools *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *url = [NSURL URLWithString:@"http://c.m.163.com/nc/article/headline/"];
        instance = [[self alloc]initWithBaseURL:url];
    });
    return instance;
}

@end
