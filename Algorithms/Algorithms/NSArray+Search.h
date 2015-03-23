//
//  NSArray+Search.h
//  Algorithms
//
//  Created by Robert on 15/3/23.
//  Copyright (c) 2015年 NationSky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Search)

/**
 *  线性查找
 *
 *  @param object 检索对象
 *
 *  @return 查找结果
 */
- (NSInteger)linearSearchFor:(id)object;
- (id)linearSearchForIn:(id)objectt;
- (id)linearSearchEnumerate:(id)object;

/**
 *  折半查找
 *
 *  @param object 检索目标
 *
 *  @return 查找结果
 */
- (NSInteger)halfSearch:(id)object;

/**
 *  NSSet查找
 *
 *  @param objext 检索目标
 *
 *  @return 查找结果
 */
- (id)setSearch:(id)object;

@end
