//
//  NSArray+Search.m
//  Algorithms
//
//  Created by Robert on 15/3/23.
//  Copyright (c) 2015年 NationSky. All rights reserved.
//

#import "NSArray+Search.h"

@implementation NSArray (Search)

/**
 *  线性查找
 *
 *  @param object 检索对象
 *
 *  @return 查找结果index
 */
- (NSInteger)linearSearchFor:(id)object {
    NSUInteger count = [self count];
    
    for (NSUInteger i = 0; i < count; i++) {
        if ([object isEqual:self[i]]) {
            return i;
        }
    }
    
    return NSNotFound;
}

- (id)linearSearchForIn:(id)object {
    NSString *result;
    for (NSString *string in self) {
        if ([object isEqual:string]) {
            result = string;
        }
    }
    
    return result;
}

- (id)linearSearchEnumerate:(id)object {
    __block NSString *result;
    [self enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isEqualToString:object]) {
            result = obj;
        }
    }];
    return result;
}

/**
 *  折半查找
 *
 *  @param object 检索目标
 *
 *  @return 查找结果index
 */
- (NSInteger)halfSearch:(id)object {
    NSUInteger firstIndex = 0;
    NSUInteger uptoIndex  = [self count];
    
    while (firstIndex < uptoIndex) {
        NSUInteger mid = (firstIndex + uptoIndex) / 2;
        
        if ([object compare:self[mid]] == NSOrderedAscending) {
            uptoIndex = mid;
        }
        else if ([object compare:self[mid]] == NSOrderedDescending) {
            firstIndex = mid + 1;
        }
        else {
            return mid;
        }
    }
    
    return NSNotFound;
}

- (id)setSearch:(id)object{
    NSString *result;
    NSSet *set = [NSSet setWithArray:self];
    
    if ([set containsObject:object]) {
        result = object;
    }
    
    return result;
}

- (NSMutableDictionary *)structureTest {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for (NSString *string in self) {
        NSString *firstChar = [string substringToIndex:1];
        if ([[dic allKeys] containsObject:firstChar]) {
            NSMutableArray *array = [dic valueForKey:firstChar];
            [array addObject:string];
        } else {
            NSMutableArray *array = [NSMutableArray array];
            [array addObject:string];
            [dic setValue:array forKey:firstChar];
        }
    }
    return dic;
}
@end
