//
//  EGGetDonationRecordResult.h
//  Egive
//
//  Created by sinogz on 15/9/11.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "EGDonationRecord.h"

@interface EGGetDonationRecordResult : NSObject

@property (nonatomic, assign) NSInteger TotalNumberOfRecord;
@property (nonatomic, strong) NSArray *RecordList;

@end
