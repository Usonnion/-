//
//  NSString+Format.m
//  约拍
//
//  Created by apple on 16/3/5.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import "NSString+Format.h"

@implementation NSString (Format)

+ (BOOL)isNilOrEmpty:(NSString *)str
{
    return [str isKindOfClass:[NSNull class]] || !str || [str isEqualToString:@""];
}

+ (NSString *)getEmptyIfNull:(NSString *)str
{
    return [NSString isNilOrEmpty:str] ? @"" : str;
}

+ (NSString *)stringByDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateIntervalFormatterMediumStyle;
    dateFormatter.timeStyle = kCFDateFormatterMediumStyle;
    return [dateFormatter stringFromDate:date];
}

+ (NSString *)jsonByDate:(NSDate *)date
{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZZZ"];
    return [outputFormatter stringFromDate:date];
}

@end
