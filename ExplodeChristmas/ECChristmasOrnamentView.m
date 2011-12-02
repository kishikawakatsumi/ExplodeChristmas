//
//  ECChristmasOrnamentView.m
//  ExplodeChristmas
//
//  Created by Kishikawa Katsumi on 11/12/02.
//  Copyright (c) 2011 Kishikawa Katsumi. All rights reserved.
//

#import "ECChristmasOrnamentView.h"

static NSArray *imageNames;
static CGFloat scale;

@implementation ECChristmasOrnamentView

+ (void)initialize {
    imageNames = [[NSArray alloc] initWithObjects:
                  @"bells", 
                  @"candygold", 
                  @"presentblue", 
                  @"snowman2", 
                  @"wreath1", 
                  @"xtree1", nil];
    scale = [[UIScreen mainScreen] scale];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        u_int32_t index = arc4random() % [imageNames count];
        
        imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[imageNames objectAtIndex:index]]];
        imageView.contentScaleFactor = scale;
        [self addSubview:imageView];
        [imageView release];
        
        u_int32_t offset = arc4random() % 32;
        CGSize size = imageView.frame.size;
        CGPoint origin = CGPointMake(MIN(10.0f * offset, 320.0f - size.width), size.height * -1);
        frame.size = size;
        frame.origin = origin;
        self.frame = frame;
    }
    return self;
}

- (void)pauseLayer:(CALayer *)layer {
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
}

- (void)resumeLayer:(CALayer *)layer {
    CFTimeInterval pausedTime = [layer timeOffset];
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    layer.beginTime = timeSincePause;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [UIView animateWithDuration:0.5 delay:0.0f options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionBeginFromCurrentState animations:^
     {
         self.frame = [[self.layer presentationLayer] frame];
         self.alpha = 0.0f;
     } completion:^(BOOL finished) 
     {
         [self removeFromSuperview];
     }];
}

@end
