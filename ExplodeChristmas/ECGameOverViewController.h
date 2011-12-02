//
//  ECGameOverViewController.h
//  ExplodeChristmas
//
//  Created by Kishikawa Katsumi on 11/12/02.
//  Copyright (c) 2011 Kishikawa Katsumi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ECGameOverViewController : UIViewController {
    UILabel *scoreLabel;
    NSUInteger score;
    UIViewController *gameViewController;
}

@property (nonatomic, assign) NSUInteger score;
@property (nonatomic, assign) UIViewController *rootViewController;

@end
