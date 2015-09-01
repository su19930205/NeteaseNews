//
//  News.m
//  新闻
//
//  Created by mac on 15/8/30.
//  Copyright (c) 2015年 szh. All rights reserved.
//

#import "News.h"
#import "NetWorkTools.h"
#import <objc/runtime.h>
@implementation News
+ (instancetype)newsWithDict:(NSDictionary *)dict {
    id obj = [[self alloc] init];
    NSArray *propertis = @[@"title",@"digest",@"replyCount",@"imgsrc"];
    
    for (NSString *key in propertis) {
        if (dict[key]!= nil) {
            [obj setValue:dict[key] forKeyPath:key];
        }
    }
    
//    [obj setValuesForKeysWithDictionary:dict];
    
    return obj;
}
// 动态加载`类`的属性

const char *kPropertiesKey = "kPropertiesKey";
+ (NSArray *)loadProperties {
    
    // 利用`关联`对象，给`类`添加属性，OC中的类，本身就是一个特殊对象
    /**
     获取关联对象
     1. 对象，属性关联到的对象
     2. key，属性的 key
     */
    NSArray *pList = objc_getAssociatedObject(self, kPropertiesKey);
    if (pList != nil) {
        return pList;
    }
    
    /**
     1. 类
     2. 属性计数指针
     */
    unsigned int count = 0;
    objc_property_t *list = class_copyPropertyList([self class], &count);
    
    NSLog(@"属性数量 %u", count);
    
    // 遍历数组
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i < count; ++i) {
        // C语言中没有对象的概念，一般不需要使用 `*`
        objc_property_t pty = list[i];
        
        // 属性名称
        const char *cname = property_getName(pty);
        
        // 添加到数组
        [arrayM addObject:[NSString stringWithUTF8String:cname]];
    }
    NSLog(@"%@", arrayM);
    
    // 释放对象
    free(list);
    
    // 设置关联对象对象
    /**
     设置关联对象属性，运行时机制中，在OC开发的应用，关联对象使用的频率最高！
     
     1. 属性关联的对象
     2. key
     3. 值
     4. 引用关系
     */
    objc_setAssociatedObject(self, kPropertiesKey, arrayM, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    return objc_getAssociatedObject(self, kPropertiesKey);
}


-(NSString *)description
{
    NSArray *propertis = @[@"title",@"digest",@"replyCount",@"imgsrc"];
    
    NSDictionary *dict = [self dictionaryWithValuesForKeys:propertis];
    
    return [NSString stringWithFormat:@"<%@: %p> %@",self.class,self,dict];
}

+(void)loadNewsListWithURLString:(NSString *)urlString
{
    [[NetWorkTools sharedNetworkTools] GET:urlString parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        //keyEnumerator.nextObject能拿到第一个key，主要用来遍历数组
        NSLog(@"%@",responseObject.keyEnumerator.nextObject);
        //根据key拿到第一个数组
        NSArray *array = responseObject[responseObject.keyEnumerator.nextObject];
        NSLog(@"%@",array);
        //字典转模型
        NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:array.count];
        for (NSDictionary *obj in array) {
            [arrayM addObject:[self newsWithDict:obj]];
        }
        NSLog(@"%@",arrayM);
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }];
}

@end
