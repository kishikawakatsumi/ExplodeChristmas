//
//  ECViewController.m
//  ExplodeChristmas
//
//  Created by Kishikawa Katsumi on 11/12/02.
//  Copyright (c) 2011 Kishikawa Katsumi. All rights reserved.
//

#import "ECViewController.h"
#import "ECGameViewController.h"

@implementation ECViewController

@synthesize startButton;

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidUnload {
    self.startButton = nil;
    [super viewDidUnload];
}

- (IBAction)startButtonPushed:(id)sender {
    ECGameViewController *controller = [[ECGameViewController alloc] init];
    controller.rootViewController = self;
    [self presentModalViewController:controller animated:YES];
    [controller release];
}

@end
