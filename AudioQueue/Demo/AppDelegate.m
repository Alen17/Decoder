//
//  AppDelegate.m
//  Demo
//
//  Created by hu on 14-7-21.
//  Copyright (c) 2014年 jxj. All rights reserved.
//

#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>

void interruptionListener(	void *	inClientData,
                          UInt32	inInterruptionState)
{
}
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.viewController =[[ViewController alloc] init];
    //增加导航
    self.navController = [[UINavigationController alloc] init];
    self.viewController.title =@"登录";
    [self.navController pushViewController:self.viewController animated:YES];
    //    [self.window addSubview:self.navController.view];
    [self.window setRootViewController:self.navController];//设置屏幕旋转，必须要用setRootViewController
    
    [self.window makeKeyAndVisible];
    
    OSStatus error = AudioSessionInitialize(NULL, NULL, interruptionListener, (__bridge void *)(self));
    UInt32 category = kAudioSessionCategory_PlayAndRecord;
    AudioSessionSetProperty(kAudioSessionProperty_AudioCategory, sizeof(category), &category);
    UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
    AudioSessionSetProperty (kAudioSessionProperty_OverrideCategoryDefaultToSpeaker, sizeof (audioRouteOverride),&audioRouteOverride);
    AudioSessionSetActive(true); //激活AudioSession
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
