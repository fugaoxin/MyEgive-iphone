//
//  InformationModel.h
//  Egive
//
//  Created by zxj on 16/3/2.
//  Copyright © 2016年 sino. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InformationModel : NSObject
@property (nonatomic,copy) NSString *ImageFilePath;
@property (nonatomic,copy) NSString *MsgID;
@property (nonatomic,copy) NSString *RefID;
@property (nonatomic,copy) NSString *Msg;
@property (nonatomic,copy) NSString *Title;
@property (nonatomic,copy) NSString *MsgTp;
@property (nonatomic,copy) NSString *CreatedDate;
@end
