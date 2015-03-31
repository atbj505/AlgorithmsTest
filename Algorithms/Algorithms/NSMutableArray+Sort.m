//
//  NSArray+Sort.m
//  Algorithms
//
//  Created by Robert on 15/3/23.
//  Copyright (c) 2015年 NationSky. All rights reserved.
//

#import "NSMutableArray+Sort.h"

@implementation NSMutableArray (Sort)

/**
 *  系统库方法
 *
 *  @return 排序后数组
 */
- (void)objcSort {
    [self sortUsingComparator:^NSComparisonResult(NSNumber *n1, NSNumber *n2) {
        return [n1 compare:n2];
    }];
}

- (void)objcSortByLength {
    [self sortUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
        if (obj1.length < obj2.length) {
            return NSOrderedAscending;
        }else if (obj1.length > obj2.length){
            return NSOrderedDescending;
        }
        return NSOrderedSame;
    }];
}
/**
 *  选择排序
 *
 *  @return 排序后数组
 */
- (void)selectionSort {
    NSUInteger minIndex = 0;
    
    for (NSUInteger i = 0; i < self.count - 1; i++) {
        minIndex = i;
        
        for (NSUInteger j = i + 1; j < self.count; j++) {
            if ([[self objectAtIndex:j] integerValue] < [[self objectAtIndex:minIndex] integerValue]) {
                minIndex = j;
            }
        }
        
        if (minIndex != i) {
            [self exchangeObjectAtIndex:i withObjectAtIndex:minIndex];
        }
    }
}

/**
 *  插入排序
 *
 *  @return 排序后数组
 */
- (void)insertionSort {
    for (NSUInteger i = 1; i < self.count; i++) {
        NSUInteger j = i;
        NSNumber *target = [self objectAtIndex:i];
        
        while (j > 0 && target.integerValue < [[self objectAtIndex:j - 1] integerValue]) {
            [self exchangeObjectAtIndex:j withObjectAtIndex:j - 1];
            j--;
        }
        [self replaceObjectAtIndex:j withObject:target];
    }
}

/**
 *  堆排序
 *
 *  @return 排序后数组
 */
- (void)heapSort {
    [self heapifyArray:self Count:self.count];
    
    NSInteger end = self.count - 1;
    
    while (end > 0) {
        [self exchangeObjectAtIndex:end withObjectAtIndex:0];
        [self sift_downArray:self Start:0 End:end-1];
        end--;
    }
}

- (void)sift_downArray:(NSMutableArray *)array Start:(NSUInteger)start End:(NSUInteger) end {
    NSUInteger root = start;
    
    while ((root * 2 + 1) <= end) {
        NSUInteger child = root * 2 + 1;
        
        if (child + 1 <= end && [[array objectAtIndex:child] integerValue] < [[array objectAtIndex:child + 1] integerValue]) {
            child++;
        }
        
        if ([[array objectAtIndex:root] integerValue] < [[array objectAtIndex:child] integerValue]) {
            [array exchangeObjectAtIndex:root withObjectAtIndex:child];
            root = child;
        }
        else {
            return;
        }
    }
}

- (void)heapifyArray:(NSMutableArray *)array Count:(NSUInteger)count{
    NSInteger start = (count - 2) / 2;
    
    while (start >= 0) {
        [self sift_downArray:array Start:start End:count];
        start--;
    }
}
/**
 *  快速排序
 *
 *  @return 排序后数组
 */
- (void)quickSort {
    [self quick_sortArray:self Left:0 right:self.count - 1];
}

- (void)quick_sortArray:(NSMutableArray *)array Left:(NSUInteger)left right:(NSUInteger)right {
    NSUInteger index = [self partitionArray:array Left:left Right:right];
    
    if (left < index - 1) {
        [self quick_sortArray:array Left:left right:index-1];
    }
    
    if (index < right) {
        [self quick_sortArray:array Left:index right:right];
    }
}

- (NSUInteger) partitionArray:(NSMutableArray *)arr Left:(NSUInteger)left Right:(NSUInteger)right {
    NSUInteger i = left;
    NSUInteger j = right;
    NSInteger pivot = [[arr objectAtIndex:(left + right) / 2] integerValue];
    
    while (i <= j) {
        while ([[arr objectAtIndex:i] integerValue] < pivot) {
            i++;
        }
        
        while (j > 0 && [[arr objectAtIndex:j] integerValue] > pivot) {
            j--;
        }
        
        if (i <= j) {
            [arr exchangeObjectAtIndex:i withObjectAtIndex:j];
            i++;
            
            if (j > 0) {
                j--;
            }
        }
    }
    return i;
}
/**
 *  归并排序
 *
 *  @return 排序后数组
 */
- (void)mergeSort {
    [self merge_sortArray:self First:0 last:self.count];
}

- (void)mergeArray:(NSMutableArray *)array First:(NSUInteger)first Mid:(NSUInteger)mid Last:(NSUInteger)last {
    NSMutableArray *tempArr = [[NSMutableArray alloc] init];
    NSUInteger indexA = first;
    NSUInteger indexB = mid;
    
    while (indexA < mid && indexB < last) {
        NSNumber *numA = [array objectAtIndex:indexA];
        NSNumber *numB = [array objectAtIndex:indexB];
        
        if (numA.integerValue < numB.integerValue) {
            [tempArr addObject:numA];
            indexA++;
        }
        else {
            [tempArr addObject:numB];
            indexB++;
        }
    }
    
    while (indexA < mid) {
        [tempArr addObject:[array objectAtIndex:indexA]];
        indexA++;
    }
    
    while (indexB < last) {
        [tempArr addObject:[array objectAtIndex:indexB]];
        indexB++;
    }
    
    indexA = first;
    
    for (NSUInteger i = 0; i < tempArr.count; i++) {
        [array replaceObjectAtIndex:indexA withObject:[tempArr objectAtIndex:i]];
        indexA++;
    }
}

- (void)merge_sortArray:(NSMutableArray *)array First:(NSUInteger)first last:(NSUInteger)last {
    if (first + 1 < last) {
        NSUInteger mid = (first + last) / 2;
        [self merge_sortArray:array First:first last:mid];
        [self merge_sortArray:array First:mid last:last];
        [self mergeArray:array First:first Mid:mid Last:last];
    }
}
/**
 *  冒泡排序
 *
 *  @return 排序后数组
 */
- (void)bubbleSort {
    BOOL swapped = YES;
    NSUInteger k = 0;
    
    while (swapped) {
        swapped = NO;
        
        for (NSInteger i = 0; i < self.count - 1 - k; i++) {
            if ([[self objectAtIndex:i] integerValue] > [[self objectAtIndex:i + 1] integerValue]) {
                [self exchangeObjectAtIndex:i withObjectAtIndex:i + 1];
                swapped = YES;
            }
        }
        k++;
    }
}

@end
