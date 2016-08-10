//
//  RequestApiFunc.m
//  Egive
//
//  Created by sino on 15/8/31.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "RequestApiFunc.h"
#import "Constants.h"
@implementation RequestApiFunc

- (NSString *)requestApiData:(NSString *)soapMessage{
    
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
        // 请求头部信息(我们执行网络请求的时候给服务器发送的包头信息)
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
