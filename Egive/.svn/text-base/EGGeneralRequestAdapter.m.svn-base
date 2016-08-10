//
//  EGGeneralRequestAdapter.m
//  Egive
//
//  Created by sinogz on 15/9/4.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "EGGeneralRequestAdapter.h"
#import "MJExtension.h"
#import "Constants.h"

@implementation EGGeneralRequestAdapter

+ (void)postWithSoapMsg:(NSString *)soapMsg success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    //1.获得请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMsg;
    }];
    
    //NSDictionary *request = @{@"Lang": @(1), @"EventTp": @"P", @"Year": @"", @"SearchText": @"", @"StartRowNo": @(1), @"NumberOfRows": @(10)};
    
    //2.发送Post请求
    [manager POST:[NSString stringWithFormat:@"%@/appservices/webservice.asmx?wsdl", SITE_URL] parameters:soapMsg success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *response = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
        NSDictionary * result = [NSString parseJSONStringToNSDictionary:response];
        if (success) {
            success(result);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)postWithSoapMsg1:(NSString *)soapMsg success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    [EGGeneralRequestAdapter postWithURL:[NSString stringWithFormat:@"%@/appservices/webservice.asmx?wsdl", SITE_URL] soapMsg:soapMsg success:success failure:failure];
}

+ (void)postWithHttpsConnection:(BOOL)safe soapMsg:(NSString *)soapMsg success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSString *url = [NSString stringWithFormat:@"%@/appservices/webservice.asmx?wsdl", SITE_URL];//safe ? requestURLString_s : requestURLString;
    [EGGeneralRequestAdapter postWithURL:url soapMsg:soapMsg success:success failure:failure];
}

+ (void)postWithURL:(NSString *)url soapMsg:(NSString *)soapMsg success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    //1.获得请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMsg;
    }];
    
    //2.发送Post请求
    [manager POST:url parameters:soapMsg success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
