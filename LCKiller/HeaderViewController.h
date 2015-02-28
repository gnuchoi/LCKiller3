//
//  HeaderViewController.h
//  LCKiller
//
//  Created by gnu on 07/02/2015.
//  Copyright (c) 2015 gnu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AudioFilePlayerController.h"

@interface HeaderViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *playPauseButton;
- (IBAction)playPauseButtonPressed:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *rewindButton;
- (IBAction)rewindButtonPressed:(id)sender;
- (IBAction)rewindForTenButtonPressed:(id)sender;
- (IBAction)ffForTenButtonPressed:(id)sender;


@property (strong, nonatomic) IBOutlet UIButton *ffButton;
- (IBAction)ffButtonPressed:(id)sender;

@property AudioFilePlayerController* afpController;



@end
