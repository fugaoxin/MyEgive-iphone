//
//  EGAbstractModel.m
//  Egive
//
//  Created by sinogz on 15/9/4.
//  Copyright (c) 2015年 sino. All rights reserved.
//

#import "EGAbstractModel.h"

@implementation EGAbstractModel

-(id)initWithDictionary:(NSDictionary*)dict
{
    self = [super init];
    if (self) {
        [self configureWithDictionary:dict];
    }
    return self;
}

- (void)configureWithDictionary:(NSDictionary *)dictionary {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in %@", NSStringFromSelector(_cmd),NSStringFromClass(self.class)]
                                 userInfo:nil];
}

@end
