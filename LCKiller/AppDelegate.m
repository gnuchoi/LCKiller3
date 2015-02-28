//
//  AppDelegate.m
//  LCKiller
//
//  Created by gnu on 25/01/2015.
//  Copyright (c) 2015 gnu. All rights reserved.
//

#import "AppDelegate.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //customise navigation bar look
//    [[UINavigationBar appearance] setBarTintColor:[UIColor yellowColor]];
    NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
    NSString* bgNavURL = [bundlePath stringByAppendingString:@"/img_bgs/bgNavBar.png"];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageWithContentsOfFile:bgNavURL] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           UIColorFromRGB(0xf9e4ad), NSForegroundColorAttributeName,
                                                           [UIFont fontWithName:@"HelveticaNeue-Bold" size:21.0], NSFontAttributeName, nil]];
    [[UINavigationBar appearance] setTintColor:UIColorFromRGB(0xf9e4ad)];
    
    [[UITabBar appearance] setBackgroundColor:[UIColor yellowColor]];
    //
    
    
    //preview player
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];


    NSString* previewFileName = @"ANY_WRONG_NAME.mp3";
    NSString* previewFilePath = [NSString stringWithFormat:@"%@/IRs/%@", bundlePath, previewFileName];
    NSURL* previewFileURL = [NSURL fileURLWithPath:previewFilePath];
    self.previewPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:previewFileURL error:nil];
    
    self.previewPlayer.numberOfLoops = 0;

    
    return YES;
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
