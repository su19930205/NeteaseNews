//
//  NetWorkTools.h
//  新闻
//
//  Created by mac on 15/8/30.
//  Copyright (c) 2015年 szh. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface NetWorkTools : AFHTTPSessionManager
/**
 *  全局访问入口
 */
+(instancetype)sharedNetworkTools;

@end
