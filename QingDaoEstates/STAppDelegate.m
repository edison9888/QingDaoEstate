//
//  STAppDelegate.m
//  QingDaoEstates
//
//  Created by scott on 13-11-11.
//  Copyright (c) 2013年 scott. All rights reserved.
//

#import "STAppDelegate.h"
#import "STHomeViewController.h"
#import "STBaseNavigationController.h"

@implementation STAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    /*显示主页面*/
    STHomeViewController *home = [[STHomeViewController alloc] init];
    STBaseNavigationController *navController = [[STBaseNavigationController alloc] initWithRootViewController:home];
    /*自定义导航栏样式*/
    [navController.navigationBar setBackgroundImage:[UIImage imageNamed:@"LP_fabu_topBG.png"] forBarMetrics:UIBarMetricsDefault];
    
    self.window.rootViewController = navController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
