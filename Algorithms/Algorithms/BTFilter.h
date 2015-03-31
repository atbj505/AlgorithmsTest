//
//  BTFilter.h
//  BTFilter
//
//  Created by Robert on 15/3/9.
//  Copyright (c) 2015年 NationSky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTFilter : NSObject

/**
 *  单例方法
 *
 *  @return 实例对象
 */
+ (BTFilter *)shareBTFilter;

/**
 *  字符过滤方法
 *
 *  @param string 被过滤字符
 *
 *  @return 过滤后字符
 */
- (NSString *)filterWithStringTest1:(NSString *)string;
- (NSString *)filterWithStringTest2:(NSString *)string;
- (NSString *)filterWithStringTest3:(NSString *)string;
- (NSString *)filterWithStringTest4:(NSString *)string;

/**
 *  写入关键字
 *
 *  @param dic 关键字字典
 */
- (void)keyWordWriteWithDictionary:(NSMutableDictionary *)dic;
- (void)keyWordWriteWithArray:(NSArray *)array;

@end
