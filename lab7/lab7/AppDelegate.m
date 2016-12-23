//
//  AppDelegate.m
//  lab7
//
//  Created by Admin on 09/08/14.
//  Copyright (c) 2014 Noveo Summer Internship. All rights reserved.
//

#import "AppDelegate.h"
#import "SequenceViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    SequenceViewController *sequenceViewController = [[SequenceViewController alloc] init];
    self.window.rootViewController = sequenceViewController;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
