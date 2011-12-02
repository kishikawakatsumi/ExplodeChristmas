//
//  ECGameOverViewController.m
//  ExplodeChristmas
//
//  Created by Kishikawa Katsumi on 11/12/02.
//  Copyright (c) 2011 Kishikawa Katsumi. All rights reserved.
//

#import "ECGameOverViewController.h"

@implementation ECGameOverViewController

@synthesize score;
@synthesize rootViewController;

- (void)loadView {
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 460.0f)];
    contentView.backgroundColor = [UIColor blackColor];
    self.view = contentView;
    [contentView release];
    
    scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 10.0f, 300.0f, 440.0f)];
    scoreLabel.backgroundColor = [UIColor clearColor];
    scoreLabel.textColor = [UIColor whiteColor];
    scoreLabel.textAlignment = UITextAlignmentCenter;
    scoreLabel.font = [UIFont boldSystemFontOfSize:20.0f];
    scoreLabel.text = @"Score: 0";
    scoreLabel.numberOfLines = 2;
    [contentView addSubview:scoreLabel];
    [scoreLabel release];
    
    UIButton *retryButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    retryButton.frame = CGRectMake(20.0f, 291.0f, 280.0f, 37.0f);
    [retryButton setTitle:NSLocalizedString(@"Retry", nil) forState:UIControlStateNormal];
    [retryButton addTarget:self action:@selector(retry:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:retryButton];
    
    UIButton *returnButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    returnButton.frame = CGRectMake(20.0f, 348.0f, 280.0f, 37.0f);
    [returnButton setTitle:NSLocalizedString(@"Back to title", nil) forState:UIControlStateNormal];
    [returnButton addTarget:self action:@selector(backToTitle:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:returnButton];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    scoreLabel.text = [NSString stringWithFormat:@"Score: %d\n%@", score, NSLocalizedString(@"Christmas exploded.", nil)];
    
}

- (void)viewDidUnload {
    scoreLabel = nil;
    [super viewDidUnload];
}

- (void)retry:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)backToTitle:(id)sender {
    [rootViewController dismissModalViewControllerAnimated:YES];
}

@end
