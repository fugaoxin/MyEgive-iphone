//
//  EGUtility.m
//  Egive
//
//  Created by sinogz on 15/9/4.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "EGUtility.h"
#import "Constants.h"
@implementation EGUtility

+(AppLang)getAppLang
{
    // 取得 iPhone 支持的所有语言设置    
    AppLang lang = [[NSUserDefaults standardUserDefaults] floatForKey:@"Applang"];
    if (lang == 0){
        
        NSString * language = [[NSLocale preferredLanguages] objectAtIndex:0];
        MyLog(@"%@",language);
        if([language rangeOfString:@"HK"].location != NSNotFound)
        {
            lang = HK;
        }
        else if([language rangeOfString:@"TW"].location != NSNotFound)
        {
            lang = HK;
        }
        else if ([language rangeOfString:@"CN"].location != NSNotFound)
        {
            lang = HK;
        }
        else if ([language rangeOfString:@"Hans"].location != NSNotFound)
        {
            lang = HK;
        }
        else if ([language rangeOfString:@"zh"].location != NSNotFound)
        {
            lang = HK;
        }
        else
        {
            lang = HK;
        }
        
        [EGUtility setAppLang:lang];
    }
    return lang;
}

+(void)setAllowNotification:(BOOL)setIsAllow
{
    [[NSUserDefaults standardUserDefaults] setBool:setIsAllow forKey:@"notification"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(BOOL)getIsAllowNotification
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"notification"];
}

+(void)setAppLang:(AppLang)appLang
{
    [[NSUserDefaults standardUserDefaults] setFloat:appLang forKey:@"Applang"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

+ (NSString *)getLocationCode
{
    NSString *locationCode = [[NSUserDefaults standardUserDefaults] objectForKey:@"locationCode"];
    if (!locationCode) {
        locationCode = @"HK";
    }
    return locationCode;
}

+ (NSString *)getLocationNameWithCode:(NSString *)code
{
    if ([code isEqualToString:@"HK"]) {
        return EGLocalizedString(@"MyDonation_HK", nil);
    }
    return EGLocalizedString(@"MyDonation_noHK", nil);
}

+ (NSString *)getLocationCodeWithName:(NSString *)name
{
    if ([name isEqualToString:EGLocalizedString(@"MyDonation_HK", nil)]) {
        return @"HK";
    }
    return @"nonHK";
}

+(void)setLocationCode:(NSString *)locationCode
{
    [[NSUserDefaults standardUserDefaults] setObject:locationCode forKey:@"locationCode"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

+(NSString*)getAppVer
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (NSURL *)requestURL
{
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@/appservices/webservice.asmx?wsdl", SITE_URL]];
}

+(NSString *)getStringByKey:(NSString*)key
{
    AppLang lang = [EGUtility getAppLang];
    NSString *path;
    if (lang == HK)
        path = [[NSBundle mainBundle] pathForResource:@"EGLocalized_HK" ofType:@"strings"];
    else if (lang == CN)
        path = [[NSBundle mainBundle] pathForResource:@"EGLocalized_CN" ofType:@"strings"];
    else
        path = [[NSBundle mainBundle] pathForResource:@"EGLocalized_EN" ofType:@"strings"];
    
    NSDictionary *localDict = [NSDictionary dictionaryWithContentsOfFile:path];
    if([localDict objectForKey:key]!=nil)
        return [localDict objectForKey:key];
    else
        return key;
}

@end
