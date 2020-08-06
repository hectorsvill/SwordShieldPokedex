//
//  AppDelegate.m
//  Pokedex
//
//  Created by s on 4/22/20.
//  Copyright © 2020 s. All rights reserved.
//

@import GoogleMobileAds;

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[GADMobileAds sharedInstance] startWithCompletionHandler:nil];
    
    return YES;
}




@end
