//
//  AppDelegate.m
//  test
//
//  Created by 夏桂峰 on 16/1/9.
//  Copyright (c) 2016年 夏桂峰. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //搞个导航
    ViewController *vc=[[ViewController alloc]init];
    UINavigationController *navi=[[UINavigationController alloc]initWithRootViewController:vc];
    navi.navigationBar.barStyle=UIBarStyleBlack;
    self.window.rootViewController=navi;
    return YES;
}


@end
