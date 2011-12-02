//
//  ECGameView.m
//  ExplodeChristmas
//
//  Created by Kishikawa Katsumi on 11/12/02.
//  Copyright (c) 2011 Kishikawa Katsumi. All rights reserved.
//

#import "ECGameView.h"

@implementation ECGameView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        id sparkImage = (id)[[UIImage imageNamed:@"spark"] CGImage];
        
        CGColorRef backgroundColor = [self.backgroundColor CGColor];
        CALayer *rootLayer = self.layer;
        
        fireLayer = [CAEmitterLayer layer];
        fireLayer.frame = self.frame;
        fireLayer.renderMode = kCAEmitterLayerAdditive;
        fireLayer.backgroundColor = backgroundColor;
        fireLayer.emitterSize = CGSizeMake(3.0f, 3.0f);
        [rootLayer addSublayer:fireLayer];
        
        explosionLayer = [CAEmitterLayer layer];
        explosionLayer.frame = self.frame;
        explosionLayer.renderMode = kCAEmitterLayerAdditive;
        explosionLayer.backgroundColor = backgroundColor;
        [rootLayer addSublayer:explosionLayer];
        
        fire = [CAEmitterCell emitterCell];
        fire.lifetime = 1.0f;
        fire.lifetimeRange = 0.5f;
        fire.color = [[UIColor colorWithRed:1.000 green:0.433 blue:0.173 alpha:0.3] CGColor];
        fire.contents = (id)[[UIImage imageNamed:@"fire"] CGImage];
        fire.scale = 0.2f;
        fire.scaleRange = 0.1f;
        fire.velocity = 20.0f;
        fire.velocityRange = 10.0f;
        fire.emissionRange = 2 * M_PI;
        fire.scaleSpeed = 0.3f;
        fire.spin = 0.5f;
        [fire setName:@"fire"];
        
        explosion = [CAEmitterCell emitterCell];
        explosion.color = [[UIColor colorWithRed:1.000 green:0.433 blue:0.173 alpha:1.000] CGColor];
        explosion.contents = sparkImage;
        explosion.scale = 0.2f;
        explosion.scaleRange = 0.1f;
        explosion.velocity = 130.0f;
        explosion.lifetime = 1.0f;
        explosion.alphaSpeed = -0.2f;
        explosion.duration = 0.1f;
        explosion.emissionRange = 2 * M_PI;
        explosion.scaleSpeed = -0.1f;
        explosion.spin = 2.0f;
        [explosion setName:@"explosion"];
        
        fireLayer.emitterCells = [NSArray arrayWithObject:fire];
        explosionLayer.emitterCells = [NSArray arrayWithObjects:explosion, nil];
    }
    return self;
}

- (void)explode:(CGPoint)point {
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    fireLayer.emitterPosition = point;
    explosionLayer.emitterPosition = point;
    [CATransaction commit];
    
    fire.birthRate = 400.0f;
    explosion.birthRate = 4000.0f;
    
    [self performSelector:@selector(hideExplosionEffect:) withObject:nil afterDelay:0.1];
}

- (void)fail:(CGPoint)point {
}

- (void)hideExplosionEffect:(CAEmitterCell *)cell {
    [fireLayer setValue:[NSNumber numberWithFloat:0.0f] forKeyPath:@"emitterCells.fire.birthRate"];
    [explosionLayer setValue:[NSNumber numberWithFloat:0.0f] forKeyPath:@"emitterCells.explosion.birthRate"];
}

@end
