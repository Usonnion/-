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

- (NSString *)orderStatus
{
    if ([self isEqualToString:@"NOTRECEIVED"]) {
        return @"店家还未接单";
    } else if ([self isEqualToString:@"RECEIVED"]) {
        return @"店家已接单";
    }
    return @"";
}

- (NSDate *)toDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd'T'HH:mm:ss"];
    NSDate *destDate= [dateFormatter dateFromString:self];
    
    return destDate;
}

+ (BOOL)validatePhone:(NSString *)phone
{
    NSString *phoneRegex = @"1[3|5|7|8|][0-9]{9}";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:phone];
}


@end
