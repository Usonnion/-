//
//  NSString+Format.h
//  约拍
//
//  Created by apple on 16/3/5.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Format)

+ (BOOL)isNilOrEmpty:(NSString *)str;
+ (NSString *)getEmptyIfNull:(NSString *)str;
+ (NSString *)stringByDate:(NSDate *)date;
+ (NSString *)jsonByDate:(NSDate *)date;
- (NSString *)orderStatus;
- (NSDate *)toDate;
+ (BOOL)validatePhone:(NSString *)phone;

@end
