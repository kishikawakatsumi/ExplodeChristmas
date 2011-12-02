//
//  ECGameView.h
//  ExplodeChristmas
//
//  Created by Kishikawa Katsumi on 11/12/02.
//  Copyright (c) 2011 Kishikawa Katsumi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface ECGameView : UIView {
    CAEmitterLayer *fireLayer;
    CAEmitterLayer *explosionLayer;
    
    CAEmitterCell *star;
    CAEmitterCell *fire;
    CAEmitterCell *explosion;
}

- (void)explode:(CGPoint)point;
- (void)fail:(CGPoint)point;
@end
