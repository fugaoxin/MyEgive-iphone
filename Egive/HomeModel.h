//
//  HomeModel.h
//  Egive
//
//  Created by sino on 15/8/31.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeModel : NSObject
@property (nonatomic,copy) NSString *CaseID;
@property (nonatomic,copy) NSString *Msg;
@property (nonatomic,copy) NSString *Title;
@property (nonatomic,copy) NSString *URL;
@property (nonatomic,copy) NSString *FilePath;
@property (nonatomic,copy) NSString *RelatedImageFilePath;
@property (nonatomic,copy) NSString *RelatedVideoFilePath;
@end
