//
//  NSArray+Sort.h
//  Algorithms
//
//  Created by Robert on 15/3/23.
//  Copyright (c) 2015年 NationSky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Sort)

/**
 *  系统库方法
 *
 *  @return 排序后数组
 */
- (void)objcSort;

/**
 *  选择排序
 *
 *  @return 排序后数组
 */
- (void)selectionSort;

/**
 *  插入排序
 *
 *  @return 排序后数组
 */
- (void)insertionSort;

/**
 *  堆排序
 *
 *  @return 排序后数组
 */
- (void)heapSort;

/**
 *  快速排序
 *
 *  @return 排序后数组
 */
- (void)quickSort;

/**
 *  归并排序
 *
 *  @return 排序后数组
 */
- (void)mergeSort;

/**
 *  冒泡排序
 *
 *  @return 排序后数组
 */
- (void)bubbleSort;

@end
