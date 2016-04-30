//
//  AppDelegate.m
//  DH3D Touch
//
//  Created by 董浩 on 16/4/14.
//  Copyright © 2016年 donghao. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self creatShortcutItems];
    if (launchOptions[@"UIApplicationLaunchOptionsShortcutItemKey"] == nil) {
        return YES;
    } else {
        return NO;
    }
    
}

//创建shortcutItems
-(void)creatShortcutItems{
    NSMutableArray *shortcutItems=[NSMutableArray array];
    UIApplicationShortcutItem *item1=[[UIApplicationShortcutItem alloc]initWithType:@"1" localizedTitle:@"美女1"];
    UIApplicationShortcutItem *item2=[[UIApplicationShortcutItem alloc]initWithType:@"2" localizedTitle:@"跑车2"];
    
    [shortcutItems addObject:item1];
    [shortcutItems addObject:item2];
    
    [[UIApplication sharedApplication]setShortcutItems:shortcutItems];
}
//默认进来调用下边方法

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {

    switch (shortcutItem.type.integerValue) {
        case 1:{
            [[NSNotificationCenter defaultCenter]postNotificationName:@"gototextVC" object:self userInfo:@{@"type":@"1"}];
            break;
        }
        case 2:{
        
            [[NSNotificationCenter defaultCenter]postNotificationName:@"gototextVC" object:self userInfo:@{@"type":@"2"}];
            
        
        
        }
        default:
            break;
    }








}

















- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
