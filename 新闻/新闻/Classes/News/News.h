//
//  News.h
//  新闻
//
//  Created by mac on 15/8/30.
//  Copyright (c) 2015年 szh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject
/**
 *  新闻标题
 */
@property (nonatomic, copy) NSString *title;
/**
 *  新闻摘要
 */
@property (nonatomic, copy) NSString *digest;
/**
 *  跟贴数量
 */
@property (nonatomic, assign) int replyCount;
/**
 *  配图地址
 */
@property (nonatomic, copy) NSString *imgsrc;

+ (instancetype)newsWithDict:(NSDictionary *)dict;
/**
 *  加载制定URL的新闻数组
 */
+(void)loadNewsListWithURLString:(NSString *)urlString;
@end
