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
        
        //添加解析的数据格式
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    });
    return instance;
}

@end
