//
//  EGStaticPageRequestAdapter.m
//  Egive
//
//  Created by sinogz on 15/9/9.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "EGStaticPageRequestAdapter.h"

@implementation EGStaticPageRequestAdapter

+ (void)GetStaticPageContentWithFormID:(NSString *)formID success:(void (^)(EGGetStaticPageContentResult *))success failure:(void (^)(NSError *))failure
{
    AppLang lang = [EGUtility getAppLang];
    NSString * soapMsg =[NSString stringWithFormat:
                         @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                         "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                         "<soap:Body>"
                         "<GetStaticPageContent xmlns=\"egive.appservices\">"
                         "<Lang>%ld</Lang>"
                         "<FormID>%@</FormID>"
                         "</GetStaticPageContent>"
                         "</soap:Body>"
                         "</soap:Envelope>",lang,formID];
    
    [EGGeneralRequestAdapter postWithSoapMsg:soapMsg success:^(id responseObj) {
        if (success) {
            //把获取的数据（返回结果）由字典转换为模型
            EGGetStaticPageContentResult *result=[EGGetStaticPageContentResult objectWithKeyValues:responseObj];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
