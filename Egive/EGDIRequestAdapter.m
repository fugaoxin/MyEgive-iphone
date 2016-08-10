//
//  EGDIRequestAdapter.m
//  Egive
//
//  Created by sinogz on 15/9/4.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "EGDIRequestAdapter.h"

@implementation EGDIRequestAdapter

+ (void)getEventDtlListWithSoapMsg:(NSString *)soapMsg success:(void (^)(EGGetEventDtlListResult *))success failure:(void (^)(NSError *))failure
{
    [EGDIRequestAdapter postWithSoapMsg:soapMsg success:^(id responseObj) {
        if (success) {
            //把获取的数据（返回结果）由字典转换为模型
            EGGetEventDtlListResult *result=[EGGetEventDtlListResult objectWithKeyValues:responseObj];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)getAnnouncementCentreListWithLang:(AppLang)lang success:(void (^)(EGGetAnnouncementCentreListResult *))success failure:(void (^)(NSError *))failure
{
    NSString * soapMsg =[NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                "<soap:Body>"
                                    "<GetAnnouncementCentreList xmlns=\"egive.appservices\">"
                                        "<Lang>%ld</Lang>"
                                    "</GetAnnouncementCentreList>"
                                "</soap:Body>"
                             "</soap:Envelope>",lang];
    
    [EGDIRequestAdapter postWithSoapMsg:soapMsg success:^(id responseObj) {
        if (success) {
//            NSString *jsonString = [[NSString alloc] initWithData:(NSData *)responseObj encoding:NSUTF8StringEncoding];
            MyLog(@"getAnnouncementCentreListWithLang JSON:%@", responseObj);
            //把获取的数据（返回结果）由字典转换为模型
            EGGetAnnouncementCentreListResult *result=[EGGetAnnouncementCentreListResult objectWithKeyValues:responseObj];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
     
@end
