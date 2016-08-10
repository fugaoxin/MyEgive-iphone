//
//  NSString+RegexKitLite.m
//  Egive
//
//  Created by sino on 15/8/25.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "NSString+RegexKitLite.h"
#import "baseController.h"
#import "EGUtility.h"
#import "Constants.h"
static NSString * _dataString;
@implementation NSString (RegexKitLite)

//用户名
+ (BOOL) validateUserName:(NSString *)name
{
    NSString *userNameRegex = @"^[A-Za-z0-9+\\s]{1,20}+$";
    if (![name isMatchedByRegex:userNameRegex]) {
        baseController * bcl = [[baseController alloc] init];
        [bcl setAlertView:EGLocalizedString(@"无效的用户名称", nil)];
    }
    return [name isMatchedByRegex:userNameRegex];
}
//密码
+ (BOOL) validatePassword:(NSString *)passWord
{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,20}+$";
    if (![passWord isMatchedByRegex:passWordRegex])
    {
        baseController * bcl = [[baseController alloc] init];
        [bcl setAlertView:@"无效的密码,请重新输入!"];
        NSLog(@"未通过校验，数据格式有误，请检查！");
    }
    return [passWord isMatchedByRegex:passWordRegex];
}
//确认密码
+ (BOOL) validateConfirmPsw:(NSString *)confirmPsw andPassWord:(NSString *)passWord{
    
    if (![passWord isEqualToString:confirmPsw]) {
        baseController * bcl = [[baseController alloc] init];
        [bcl setAlertView:@"确认密码与登入密码不一致,请重新输入!"];
    }
    return [passWord isEqualToString:confirmPsw];
}

//验证邮箱
+ (BOOL)isEmail:(NSString *)email {
    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    if (![email isMatchedByRegex:regex]) {
        baseController * bcl = [[baseController alloc] init];
        [bcl setAlertView:EGLocalizedString(@"无效的电子邮箱", nil)];

    }
    return [email isMatchedByRegex:regex];
}

//昵称
+ (BOOL) validateNickname:(NSString *)nickname
{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{1,8}$";
    if (![nickname isMatchedByRegex:nicknameRegex]) {
        baseController * bcl = [[baseController alloc] init];
        [bcl setAlertView:@"无效的姓或名,请重新输入!"];
    }
    return [nickname isMatchedByRegex:nicknameRegex];

}
//判断输入为空
+ (BOOL) isEmpty:(NSString *)NSString andNote:(NSString *)note {
   
    if ([NSString isEqualToString:@""]) {
        baseController * bcl = [[baseController alloc] init];
        [bcl setAlertView:note];
    }
    return [NSString isEqualToString:@""];
}

+ (CGSize)getUILabelHight:(NSString *)str {
    
   CGSize retSize = [str boundingRectWithSize:CGSizeMake(300, CGFLOAT_MAX)                                                                                                                                                             options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin |
                NSStringDrawingUsesFontLeading
                                        attributes:nil context:nil].size;
    return retSize;
}

+(NSString*)strmethodComma:(NSString*)string
{
    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setFormatterBehavior: NSNumberFormatterBehavior10_4];
    [numberFormatter setNumberStyle: NSNumberFormatterDecimalStyle];
    NSString *numberString = [numberFormatter stringFromNumber: [NSNumber numberWithInteger:[string integerValue]]];
    return numberString;
    
}

//截取XML中的数据
+ (NSString *)captureData:(NSString *)dataString{
    NSRange r;
    while ((r = [dataString rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound){
        dataString = [dataString stringByReplacingCharactersInRange:r withString:@""];

    }
    return dataString;
}

+ (NSDictionary *)parseJSONStringToNSDictionary:(NSString *)JSONString {
    NSRange r;
    while ((r = [JSONString rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound){
        JSONString = [JSONString stringByReplacingCharactersInRange:r withString:@""];
        
    }
    NSData *JSONData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];

    return responseJSON;
}


+ (NSArray *)parseJSONStringToNSArray:(NSString *)JSONString {
    NSRange r;
    while ((r = [JSONString rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound){
        JSONString = [JSONString stringByReplacingCharactersInRange:r withString:@""];
        
    }
    NSData *JSONData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
    
    return responseJSON;
    
}

+ (NSString *)requestApiData:(NSString *)soapMessage{
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/appservices/webservice.asmx?wsdl",SITE_URL ]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    [request addValue: @"text/xml" forHTTPHeaderField:@"Content-Type"];
    [request addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    //    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 请求的序列化
    //    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    // 回复序列化
    //    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    //    operation.responseSerializer = [AFXMLParserResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        // 请求头部信息(我们执行网络请求的时候给服务器发送的包头信息)
        //        NSLog(@"%@", operation.request.allHTTPHeaderFields);
        //
        //        // 服务器给我们返回的包得头部信息
        //        NSLog(@"%@", operation.response);
        
        _dataString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        //        NSLog(@"%@",str);
        
        
        //        NSLog(@"data2String = %@", data2String);
        
        //        for (GDataXMLElement * itemElement in itemArray) {
        //            GDataXMLElement * idElenent = [itemElement elementsForName:@"id"][0];
        //
        //        }
        
        // 返回的数据
        //        NSLog(@"success = %@",responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // 请求头部信息(我们执行网络请求的时候给服务器发送的包头信息).
        NSLog(@"%@", operation.request.allHTTPHeaderFields);
        // 服务器给我们返回的包得头部信息
        NSLog(@"%@", operation.response);
        // 返回的数据
        NSLog(@"success = %@", error);
    }];
    
    [operation start];
    
    return _dataString;
}
@end

