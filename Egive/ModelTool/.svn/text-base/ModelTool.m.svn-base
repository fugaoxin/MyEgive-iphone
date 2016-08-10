//
//  ModelTool.m
//  MyDamaiProjct
//
//  Created by qianfeng on 15-5-28.
//  Copyright (c) 2015年 Dany_Chan. All rights reserved.
//

#import "ModelTool.h"

@implementation ModelTool
//代码创建model类
+(void)createModelWithDictionary:(NSDictionary *)dict modelName:(NSString *)modelName
{
    printf("\n@interface %s :NSObject\n",modelName.UTF8String);
    for (NSString *key in dict) {
        printf("@property (nonatomic,copy) NSString *%s;\n",key.UTF8String);
    }
    printf("@end\n");
    
}
@end
