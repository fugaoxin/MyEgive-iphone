//
//  EGMyDonationRequestAdapter.m
//  Egive
//
//  Created by sinogz on 15/9/11.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "EGMyDonationRequestAdapter.h"

@implementation EGMyDonationRequestAdapter

+ (void)getDonationRecordWithMemberID:(NSString *)memberID DonationID:(NSString*)DonationID success:(void (^)(EGGetDonationRecordResult *result))success failure:(void (^)(NSError *))failure
{
    AppLang lang = [EGUtility getAppLang];
    NSString * soapMsg =[NSString stringWithFormat:
                         @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                         "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                         "<soap:Body>"
                         "<GetDonationRecord xmlns=\"egive.appservices\">"
                         "<Lang>%ld</Lang>"
                         "<MemberID>%@</MemberID>"
                         "<DonationID>%@</DonationID>"
                         "<StartRowNo>1</StartRowNo>"
                         "<NumberOfRows>999</NumberOfRows>"
                         "</GetDonationRecord>"
                         "</soap:Body>"
                         "</soap:Envelope>",lang, memberID,DonationID];
    
    [EGGeneralRequestAdapter postWithSoapMsg:soapMsg success:^(id responseObj) {
        if (success) {
            
            MyLog(@"%@",responseObj);
            //把获取的数据（返回结果）由字典转换为模型
            EGGetDonationRecordResult *result=[EGGetDonationRecordResult objectWithKeyValues:responseObj];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)getShoppingCartDisclaimerWithLocationCode:(NSString *)LocationCode memberID:(NSString *)memberID success:(void (^)(NSString *result))success failure:(void (^)(NSError *error))failure
{
    AppLang lang = [EGUtility getAppLang];
    NSString * soapMsg =[NSString stringWithFormat:
                         @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                         "<soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">"
                         "<soap12:Body>"
                         "<GetShoppingCartDisclaimer xmlns=\"egive.appservices\">"
                         "<Lang>%ld</Lang>"
                         "<LocationCode>%@</LocationCode>"
                         "<MemberID>%@</MemberID>"
                         "</GetShoppingCartDisclaimer>"
                         "</soap12:Body>"
                         "</soap12:Envelope>",lang, LocationCode, memberID];
    
    [EGGeneralRequestAdapter postWithSoapMsg1:soapMsg success:^(id responseObj) {
        if (success) {
            NSString *response = [[NSString alloc] initWithData:(NSData *)responseObj encoding:NSUTF8StringEncoding];
            NSArray * array = [NSString parseJSONStringToNSArray:response];
            NSMutableString *content = [[NSMutableString alloc] init];
            for (NSDictionary *dict in array) {
                NSString *LabelName = dict[@"LabelName"];
                NSString *LabelDescription = dict[@"LabelDescription"];
                if (![LabelName hasPrefix:@"AcceptDisclaimer"]) {
                    [content appendFormat:@"<p>%@</p>",LabelDescription];
                }
            }
            success(content);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


+ (void)getGetAndSaveShoppingCart:(EGGetAndSaveShoppingCartRequest *)request success:(void (^)(EGGetAndSaveShoppingCartResult *result))success failure:(void (^)(NSError *error))failure
{
    
    NSString * soapMsg =[NSString stringWithFormat:
                         @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                         "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                         "<soap:Body>"
                         "<GetAndSaveShoppingCart xmlns=\"egive.appservices\">"
                         "<Lang>%ld</Lang>"
                         "<LocationCode>%@</LocationCode>"
                         "<DonateWithCharge>%d</DonateWithCharge>"
                         "<MemberID>%@</MemberID>"
                         "<CookieID>%@</CookieID>"
                         "<StartRowNo>%ld</StartRowNo>"
                         "<NumberOfRows>%ld</NumberOfRows>"
                         "</GetAndSaveShoppingCart>"
                         "</soap:Body>"
                         "</soap:Envelope>",request.lang, request.LocationCode,request.DonateWithCharge,request.MemberID,request.CookieID,request.StartRowNo,request.NumberOfRows];
    
    [EGGeneralRequestAdapter postWithHttpsConnection:YES soapMsg:soapMsg success:^(id responseObj) {
        if (success) {
            NSString *jsonString = [[NSString alloc] initWithData:(NSData *)responseObj encoding:NSUTF8StringEncoding];
            MyLog(@"EGGetAndSaveShoppingCartResult JSON: %@", jsonString);
            NSDictionary * dict = [NSString parseJSONStringToNSDictionary:jsonString];
            EGGetAndSaveShoppingCartResult *result=[EGGetAndSaveShoppingCartResult objectWithKeyValues:dict];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)saveShoppingCartItem:(EGSaveShoppingCartItemRequest *)request success:(void (^)(NSString *result))success failure:(void (^)(NSError *error))failure
{
    NSString * soapMsg =[NSString stringWithFormat:
                         @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                         "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                         "<soap:Body>"
                         "<SaveShoppingCartItem xmlns=\"egive.appservices\">"
                         "<MemberID>%@</MemberID>"
                         "<CookieID>%@</CookieID>"
                         "<CaseID>%@</CaseID>"
                         "<DonateAmt>%ld</DonateAmt>"
                         "<IsChecked>%d</IsChecked>"
                         "</SaveShoppingCartItem>"
                         "</soap:Body>"
                         "</soap:Envelope>",request.MemberID, request.CookieID, request.CaseID, request.DonateAmt, request.IsChecked];
    MyLog(@"saveShoppingCartItem = %@", soapMsg);
    [EGGeneralRequestAdapter postWithHttpsConnection:YES soapMsg:soapMsg success:^(id responseObj) {
        if (success) {
            NSString *result = [[NSString alloc] initWithData:(NSData *)responseObj encoding:NSUTF8StringEncoding];
            result = [NSString captureData:result];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)checkOutShoppingCart:(EGCheckOutShoppingCartRequest *)request success:(void (^)(NSString *result))success failure:(void (^)(NSError *error))failure
{
    
   
    MyLog(@"%@",request.AppToken);
    
    NSString * soapMsg = @"";
    
//    if (request.AppToken != nil){
//    NSString *deviceid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
//        request.AppToken = deviceid;
//    
//    }
    
   NSString *Apptoken = [[NSUserDefaults standardUserDefaults] objectForKey:@"GetendpointArn"];
    
    //if (request.AppToken != nil) {
    
    
//       soapMsg =[NSString stringWithFormat:
//                         @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
//                         "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                         "<soap:Body>"
//                         "<CheckOutShoppingCartWithAppToken xmlns=\"egive.appservices\">"
//                         "<MemberID>%@</MemberID>"
//                         "<CookieID>%@</CookieID>"
//                         "<DisplayName>%@</DisplayName>"
//                         "<NameOnReceipt>%@</NameOnReceipt>"
//                         "<Email>%@</Email><AppToken>%@</AppToken>"
//                         "</CheckOutShoppingCartWithAppToken>"
//                         "</soap:Body>"
//                         "</soap:Envelope>",request.MemberID, request.CookieID, request.DisplayName, request.NameOnReceipt, request.Email,Apptoken];
    
    soapMsg =[NSString stringWithFormat:
              @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
              "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
              "<soap:Body>"
              "<CheckOutShoppingCart xmlns=\"egive.appservices\">"
              "<MemberID>%@</MemberID>"
              "<CookieID>%@</CookieID>"
              "<DisplayName>%@</DisplayName>"
              "<NameOnReceipt>%@</NameOnReceipt>"
              "<Email>%@</Email>"
              "</CheckOutShoppingCart>"
              "</soap:Body>"
              "</soap:Envelope>",request.MemberID, request.CookieID, request.DisplayName, request.NameOnReceipt, request.Email];
    
//    }else{
//
//        soapMsg =[NSString stringWithFormat:
//                  @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
//                  "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                  "<soap:Body>"
//                  "<CheckOutDonateCartWithoutAppToken xmlns=\"egive.appservices\">"
//                  "<MemberID>%@</MemberID>"
//                  "<CookieID>%@</CookieID>"
//                  "<DisplayName>%@</DisplayName>"
//                  "<NameOnReceipt>%@</NameOnReceipt>"
//                  "<Email>%@</Email>"
//                  "</CheckOutDonateCartWithoutAppToken>"
//                  "</soap:Body>"
//                  "</soap:Envelope>",request.MemberID, request.CookieID, request.DisplayName, request.NameOnReceipt, request.Email];
//    
//    
//    
//    }
    
    
    [EGGeneralRequestAdapter postWithHttpsConnection:YES soapMsg:soapMsg success:^(id responseObj) {
        if (success) {
           
            NSString *result = [[NSString alloc] initWithData:(NSData *)responseObj encoding:NSUTF8StringEncoding];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
