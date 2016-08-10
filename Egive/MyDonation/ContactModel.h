//
//  ContactModel.h
//  Egive
//
//  Created by sinogz on 15/9/15.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactModel : NSObject

@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *email;
@property (nonatomic, assign)int recordID;

@property (nonatomic, assign)BOOL isChecked;

@end
