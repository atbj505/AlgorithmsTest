//
//  BTFilter.m
//  BTFilter
//
//  Created by Robert on 15/3/9.
//  Copyright (c) 2015年 NationSky. All rights reserved.
//

#import "BTFilter.h"

@interface BTFilter()

@property (nonatomic, copy) NSMutableDictionary *keyDic;

@end

@implementation BTFilter

static BTFilter *sharedBTFilter = nil;

/**
 *  单例方法
 *
 *  @return 实例对象
 */
+ (BTFilter *)shareBTFilter{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedBTFilter = [[self alloc] init];
    });
    return sharedBTFilter;
}

/**
 *  初始化方法
 *
 *  @return 实例对象
 */
- (instancetype)init{
    self = [super init];
    if (self) {
        [self keyWordRead];
    }
    return self;
}

/**
 *  字符过滤方法
 *
 *  @param string 被过滤字符
 *
 *  @return 过滤后字符
 */
- (NSString *)filterWithStringTest1:(NSString *)string{
    //判断是否存在关键字
    if (!self.keyDic) {
        return string;
    }
    
    NSString *copyString = [string copy];
    //文字信息转换小写
    copyString = [copyString lowercaseString];
    //关键字替换
    copyString = [self replaceKeyWordTest1With:copyString];
    //与原始文本信息比对返回最终结果
    if ([[string lowercaseString] isEqualToString:copyString]) {
        return string;
    }else{
        return copyString;
    }
}

- (NSString *)filterWithStringTest2:(NSString *)string{
    //判断是否存在关键字
    if (!self.keyDic) {
        return string;
    }
    
    NSString *copyString = [string copy];
    //文字信息转换小写
    copyString = [copyString lowercaseString];
    //关键字替换
    copyString = [self replaceKeyWordTest2With:copyString];
    //与原始文本信息比对返回最终结果
    if ([[string lowercaseString] isEqualToString:copyString]) {
        return string;
    }else{
        return copyString;
    }
}
/**
 *  关键字替换算法
 *
 *  @param string 被过滤文字
 */
- (NSString *)replaceKeyWordTest1With:(NSString *)string {
    //"*"
    NSString *filter;
    //数组中的过滤字
    NSString *replaceString;
    //关键字位置
    NSRange range;

    for (int i = 0; i < string.length;) {
        //字符关键字过滤
        NSString *subString = [string substringWithRange:NSMakeRange(i, 1)];
        NSMutableArray *array =[self.keyDic valueForKey:subString];

        if (array) {
            for (NSString *keyString in array) {
                //取得关键字在文字信息中的range
                range = [string rangeOfString:keyString];

                if (range.length) {
                    //根据range的长度生成等长代替字符(*)
                    if (replaceString.length < [keyString length]) {
                        replaceString = keyString;
                        filter = [@"*" stringByPaddingToLength:range.length withString:@"*" startingAtIndex:0];
                    }
                }
            }
            if (replaceString) {
                //步长变为keyString的长度
                i += replaceString.length;
                //关键字替换
                string = [string stringByReplacingOccurrencesOfString:replaceString withString:filter];
                replaceString = nil;
            } else {
                i ++;
            }
        } else {
            i ++;
        }
    }
    return string;
}


- (NSString *)replaceKeyWordTest2With:(NSString *)string {
    for (int i = 0; i < string.length; i++) {
        NSString *subString = [string substringFromIndex:i];
        NSString *indexString = [subString substringToIndex:1];
        NSArray *keyArray = [self.keyDic valueForKey:indexString];
        if (keyArray) {
            for (int j = 0; j < subString.length; j++) {
                NSString *multiSubString = [subString substringToIndex:subString.length - j];
                NSUInteger index = [keyArray halfSearch:multiSubString];
                if (index != NSNotFound) {
                    NSString *filter = [@"*" stringByPaddingToLength:multiSubString.length withString:@"*" startingAtIndex:0];
                    string = [string stringByReplacingOccurrencesOfString:multiSubString withString:filter];
                    i += multiSubString.length - 1;
                    break;
                }
            }
        }
    }
    return string;
}
/**
 *  读取关键字
 */
- (void)keyWordRead{
    self.keyDic = [NSMutableDictionary dictionaryWithContentsOfFile:[self documentPath]];
}

/**
 *  写入关键字
 *
 *  @param dic 关键字字典
 */
- (void)keyWordWriteWithDictionary:(NSMutableDictionary *)dic {
    [dic writeToFile:[self documentPath] atomically:YES];
    self.keyDic = dic;
}

/**
 *  获取用户路径
 *
 *  @return 用户路径
 */
- (NSString *)documentPath{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    documentPath = [documentPath stringByAppendingPathComponent:@"keyword"];
    return documentPath;
}
@end
