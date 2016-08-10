//
//  EGUtility.h
//  Egive
//
//  Created by sinogz on 15/9/4.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+EGIVE.h"
#import "UIImageView+WebCache.h"
#import "UIView+ZJQuickControl.h"

typedef NS_ENUM(NSInteger, AppLang)
{
    HK = 1,
    CN = 2,
    EN = 3
};

@interface EGUtility : NSObject

+(AppLang)getAppLang;
+(void)setAppLang:(AppLang)appLang;
+ (NSString *)getLocationCode;
+ (NSString *)getLocationNameWithCode:(NSString *)code;
+ (NSString *)getLocationCodeWithName:(NSString *)name;
+(void)setLocationCode:(NSString *)locationCode;
+(void)setAllowNotification:(BOOL)setIsAllow;
+(BOOL)getIsAllowNotification;
+(NSString *)getAppVer;

+ (NSURL *)requestURL;

+(NSString *)getStringByKey:(NSString*)key;
@end

#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height
#define kDefaultMargin      5

// 字体
#define kTitleTextFont [UIFont systemFontOfSize:15]
#define kDescTextFont  [UIFont systemFontOfSize:12]
#define kTitleFontH2   [UIFont systemFontOfSize:16]
// textColor
#define kPurpleColor    [UIColor colorWithRed:110/255.0 green:49/255.0 blue:139/255.0 alpha:1]
#define kGreenBtnColor  [UIColor colorWithRed:110/255.0 green:184/255.0 blue:43/255.0 alpha:1]

// textSize
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
#define EG_TEXTSIZE(text, font) \
[text length] > 0 ? [text sizeWithAttributes:@{NSFontAttributeName:font}] : CGSizeZero;
#else
#define EG_TEXTSIZE(text, font) [text length] > 0 ? [text sizeWithFont:font] : CGSizeZero;
#endif

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
#define EG_MULTILINE_TEXTSIZE(text, font, maxSize, mode) [text length] > 0 ? [text \
boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) \
attributes:@{NSFontAttributeName:font} context:nil].size : CGSizeZero;
#else
#define EG_MULTILINE_TEXTSIZE(text, font, maxSize, mode) [text length] > 0 ? [text \
sizeWithFont:font constrainedToSize:maxSize lineBreakMode:mode] : CGSizeZero;
#endif

//****************************************MyLog*****************************************
#ifdef DEBUG

#define MyLog(...) NSLog(__VA_ARGS__)

#else

#define MyLog(...)

#endif



#define EGLocalizedString(key, comment) [EGUtility getStringByKey:key]

//#define baseURLString       @"http://boose1874uat.ddns.net"
//#define requestURLString    @"http://boose1874uat.ddns.net/appservices/webservice.asmx?wsdl"
//#define baseURLString_s     @"https://boose1874uat.ddns.net"
//#define requestURLString_s  @"https://boose1874uat.ddns.net/appservices/webservice.asmx?wsdl"
