//
//  ECAppDelegate.m
//  ExplodeChristmas
//
//  Created by Kishikawa Katsumi on 11/12/02.
//  Copyright (c) 2011 Kishikawa Katsumi. All rights reserved.
//

#import "ECAppDelegate.h"
#import "ECViewController.h"

@implementation ECAppDelegate

@synthesize window;
@synthesize viewController;

- (void)dealloc {
    [window release];
    [viewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryAmbient error:nil];
    [audioSession setActive:YES error:nil];
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.viewController = [[[ECViewController alloc] initWithNibName:@"ECViewController" bundle:nil] autorelease];
    window.rootViewController = viewController;
    [window makeKeyAndVisible];
    return YES;
}

@end
