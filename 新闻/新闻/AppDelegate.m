//
//  AppDelegate.m
//  新闻
//
//  Created by mac on 15/8/29.
//  Copyright (c) 2015年 szh. All rights reserved.
//

#import "AppDelegate.h"
#import <AFNetworkActivityIndicatorManager.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 1. 设置缓存
    NSURLCache *urlCache = [[NSURLCache alloc] initWithMemoryCapacity:4 * 1024 * 1024 diskCapacity:20 * 1024 * 1024 diskPath:nil];
    
    [NSURLCache setSharedURLCache:urlCache];
    
    // 2. 设置网络访问指示器
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    return YES;
}


@end
