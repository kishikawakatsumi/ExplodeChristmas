//
//  ECGameViewController.h
//  ExplodeChristmas
//
//  Created by Kishikawa Katsumi on 11/12/02.
//  Copyright (c) 2011 Kishikawa Katsumi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@class ECGameView;

@interface ECGameViewController : UIViewController {
    UILabel *scoreLabel;
    ECGameView *gameView;
    
    NSMutableArray *explosionSoundEffects;
    NSMutableArray *failSoundEffects;
    
    NSMutableSet *ornaments;
    
    NSUInteger waves;
    NSUInteger currentWave;
    NSUInteger score;
    
    UIViewController *rootViewController;
}

@property (nonatomic, assign) NSUInteger waves;
@property (nonatomic, assign) UIViewController *rootViewController;

- (void)generateOrnament;

@end
