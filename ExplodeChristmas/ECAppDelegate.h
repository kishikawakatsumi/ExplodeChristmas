//
//  ECAppDelegate.h
//  ExplodeChristmas
//
//  Created by Kishikawa Katsumi on 11/12/02.
//  Copyright (c) 2011 Kishikawa Katsumi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@class ECViewController;

@interface ECAppDelegate : UIResponder<UIApplicationDelegate> {
    UIWindow *window;
    ECViewController *viewController;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ECViewController *viewController;

@end
