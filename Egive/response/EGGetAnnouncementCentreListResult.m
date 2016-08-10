//
//  EGGetAnnouncementCentreListResult.m
//  Egive
//
//  Created by sinogz on 15/9/9.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "EGGetAnnouncementCentreListResult.h"

@implementation EGGetAnnouncementCentreListResult

MJLogAllIvars;

+(NSDictionary *)objectClassInArray
{
    return @{@"itemlist":[EGAnnouncement class]};
}

@end
