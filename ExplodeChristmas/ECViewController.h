//
//  ECViewController.h
//  ExplodeChristmas
//
//  Created by Kishikawa Katsumi on 11/12/02.
//  Copyright (c) 2011 Kishikawa Katsumi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ECViewController : UIViewController {
    UIButton *startButton;
}

@property (nonatomic, retain) IBOutlet UIButton *startButton;

- (IBAction)startButtonPushed:(id)sender;

@end
