//
//  NSString+EGIVE.m
//  Egive
//
//  Created by sinogz on 15/9/4.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "NSString+EGIVE.h"

@implementation NSString (EGIVE)

+ (NSString *)stringWithDataString:(NSString *)dateString
{
    return [NSString stringWithDataString:dateString format:@"yyyy-MM-dd HH:mm:ss" destFormat:@"yyyy-MM-dd"];
}

+ (NSString *)stringWithDataString:(NSString *)dateString format:(NSString *)format
{
    return [NSString stringWithDataString:dateString format:format destFormat:@"yyyy-MM-dd"];
}

+ (NSString *)stringWithDataString:(NSString *)dateString format:(NSString *)format destFormat:(NSString *)destFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat: format];
    
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    
    [dateFormatter setDateFormat: destFormat];
    
    NSString *destDateString = [dateFormatter stringFromDate:destDate];

    return destDateString;
}


@end
