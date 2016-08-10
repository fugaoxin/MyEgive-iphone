//
//  GlobalMacro.m
//  HKGTA
//
//  Created by lufei on 15/7/28.
//  Copyright (c) 2015年 香港. All rights reserved.
//

#import "GlobalMacro.h"

float g_fDirectorScale = 1.0f;
CGSize g_tDirectorSize = DEFAULT_SCREEN_SIZE;
CGPoint g_tSceneScale = CGPointMake(1.0f, 1.0f);

@implementation GlobalMacro


-(void)InitDirectorInfo{
    
    
    g_tDirectorSize = [UIScreen mainScreen].bounds.size;
    
    g_tSceneScale = CGPointMake(g_tDirectorSize.width/DEFAULT_SCREEN_SIZE.width, g_tDirectorSize.height/DEFAULT_SCREEN_SIZE.height);
    
    //g_fDirectorScale = MAX(g_tSceneScale.x, g_tSceneScale.y);
    g_fDirectorScale = MIN(g_tSceneScale.x, g_tSceneScale.y);
    
    NSLog(@"设备屏幕 width: %f, height: %f", g_tDirectorSize.width, g_tDirectorSize.height);
    NSLog(@"屏幕拉伸参数 Scene_Scale.x = %f  Scene_Scale.y = %f", Scene_Scale.x, Scene_Scale.y);
    NSLog(@"g_fDirectorScale = %f", g_fDirectorScale);
    
}



@end

