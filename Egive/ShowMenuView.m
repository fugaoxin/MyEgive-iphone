//
//  ShowMenuView.m
//  Egive
//
//  Created by sino on 15/8/4.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "ShowMenuView.h"

@implementation ShowMenuView


+(NSMutableDictionary *)getUserInfo{
    static NSMutableDictionary * _dict;
    if (_dict == nil) {
        _dict = [[NSMutableDictionary alloc] init];
        
    }
    return _dict;
}

+(NSMutableDictionary *)getIsSaveShoppingCart{
    
    static NSMutableDictionary * _dict;
    if (_dict == nil) {
        _dict = [[NSMutableDictionary alloc] init];
    }
    return _dict;
}

+(NSMutableDictionary *)getDonationAmount{
    static NSMutableDictionary * _dict;
    if (_dict == nil) {
        _dict = [[NSMutableDictionary alloc] init];
    }
    return _dict;
}


+ (ShowMenuView *)sharedInstance{
    
    __strong static ShowMenuView *sharedSingleton = nil;
    
    static dispatch_once_t onceToken = 0;
    
    dispatch_once(&onceToken, ^(void){
        
        sharedSingleton = [[self alloc] initialize];
        
    });
    
    return  sharedSingleton;
    
}

-(id)initialize
{
    if(self == [super init] )
    {
        //在这可以初始化自己定义的东西
        
        _userInfoArray = [[NSMutableArray alloc] init];
        
    }
    return self;
}


- (NSDictionary *)parseJSONStringToNSDictionary:(NSString *)JSONString {
    NSRange r;
    while ((r = [JSONString rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound){
        JSONString = [JSONString stringByReplacingCharactersInRange:r withString:@""];
        
    }
    NSData *JSONData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
    
    return responseJSON;
}
@end
