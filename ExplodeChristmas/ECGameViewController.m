//
//  ECGameViewController.m
//  ExplodeChristmas
//
//  Created by Kishikawa Katsumi on 11/12/02.
//  Copyright (c) 2011 Kishikawa Katsumi. All rights reserved.
//

#import "ECGameViewController.h"
#import "ECGameOverViewController.h"
#import "ECGameView.h"
#import "ECChristmasOrnamentView.h"

@implementation ECGameViewController

@synthesize waves;
@synthesize rootViewController;

- (id)init {
    self = [super init];
    if (self) {
        explosionSoundEffects = [[NSMutableArray alloc] init];
        failSoundEffects = [[NSMutableArray alloc] init];
        NSBundle *mainBundle = [NSBundle mainBundle];
        for (int i = 0; i < 10; i++) {
            AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:[mainBundle pathForResource:@"explosion" ofType:@"mp3"]] error:nil];
            [player prepareToPlay];
            
            [explosionSoundEffects addObject:player];
            [player release];
        }
        for (int i = 0; i < 10; i++) {
            AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:[mainBundle pathForResource:@"fail" ofType:@"mp3"]] error:nil];
            [player prepareToPlay];
            
            [failSoundEffects addObject:player];
            [player release];
        }
        
        ornaments = [[NSMutableSet alloc] init];
        
        waves = 20;
    }
    return self;
}

- (void)dealloc {
    [explosionSoundEffects release];
    [failSoundEffects release];
    [ornaments release];
    [super dealloc];
}

- (void)loadView {
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 460.0f)];
    contentView.backgroundColor = [UIColor clearColor];
    self.view = contentView;
    [contentView release];
    
    UIImage *backgroundImage = [UIImage imageNamed:@"background"];
    contentView.layer.contents = (id)[backgroundImage CGImage];
    
    scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 10.0f, 300.0f, 30.0f)];
    scoreLabel.backgroundColor = [UIColor clearColor];
    scoreLabel.textColor = [UIColor whiteColor];
    scoreLabel.textAlignment = UITextAlignmentRight;
    scoreLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    scoreLabel.text = @"Score: 0";
    [contentView addSubview:scoreLabel];
    [scoreLabel release];
    
    gameView = [[ECGameView alloc] initWithFrame:contentView.frame];
    gameView.backgroundColor = contentView.backgroundColor;
    [contentView addSubview:gameView];
    [gameView release];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    currentWave = 0;
    score = 0;
    scoreLabel.text = @"Score: 0";
    
    [self generateOrnament];
}

- (void)viewDidUnload {
    scoreLabel = nil;
    gameView = nil;
    [super viewDidUnload];
}

- (void)gamover {
    ECGameOverViewController *controller = [[ECGameOverViewController alloc] init];
    controller.score = score;
    controller.rootViewController = rootViewController;
    [self presentModalViewController:controller animated:YES];
    [controller release];
}

- (void)generateOrnament {
    if (currentWave >= waves) {
        [self performSelector:@selector(gamover) withObject:nil afterDelay:4.0];
        return;
    }
    
    for (NSUInteger i = 0; i < currentWave + 1; i++) {
        ECChristmasOrnamentView *ornament = [[ECChristmasOrnamentView alloc] initWithFrame:CGRectZero];
        [gameView addSubview:ornament];
        [ornament release];
        
        [ornaments addObject:ornament];
        
        u_int32_t delayFactor = arc4random() % (10 + currentWave) + 1;
        CGFloat delay = 0.6 * delayFactor;
        
        [UIView animateWithDuration:5.0f - currentWave * 0.1 delay:delay options:UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionAllowUserInteraction animations:^
         {
             ornament.center = CGPointMake(ornament.center.x, gameView.frame.size.height + ornament.frame.size.height);
         } completion:^(BOOL finished) 
         {
             if (finished) {
                 [ornament removeFromSuperview];
             }
             [ornaments removeObject:ornament];
         }];
    }
    
    currentWave++;
    [self performSelector:@selector(generateOrnament) withObject:nil afterDelay:2.0];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint point = [[touches anyObject] locationInView:gameView];
    for (ECChristmasOrnamentView *ornament in ornaments) {
        CGRect frame = [[ornament.layer presentationLayer] frame];
        if (CGRectContainsPoint(frame, point)) {
            [ornament touchesBegan:touches withEvent:event];
            [gameView explode:point];
            for (AVAudioPlayer *player in explosionSoundEffects) {
                if (!player.isPlaying) {
                    [player play];
                    break;
                }
            }
            
            score++;
            scoreLabel.text = [NSString stringWithFormat:@"Score: %d", score];
            
            return;
        }
    }
    
    [gameView fail:point];
    for (AVAudioPlayer *player in failSoundEffects) {
        if (!player.isPlaying) {
            [player play];
            break;
        }
    }
}

@end
