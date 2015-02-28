//
//  SongCell.h
//  LCKiller
//
//  Created by gnu on 02/02/2015.
//  Copyright (c) 2015 gnu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AudioFilePlayerController.h"

@interface SongCell : UITableViewCell <UIAlertViewDelegate>
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *artistLabel;
//@property (strong, nonatomic) IBOutlet UIButton *playPauseButton;
@property (strong, nonatomic) IBOutlet UILabel *trackNumberLabel;
@property (strong, nonatomic) IBOutlet UIButton *cloudButton;
- (IBAction)cloudButtonPressed:(id)sender;

@property (strong, nonatomic) MPMediaItem* song;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *titelLabelTrailingConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *artistLabelTrailingConstraint;

-(void) showCloudButton;
-(void) hideCloudButton;
@end
