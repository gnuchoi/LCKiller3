//
//  RoomCell.h
//  LCKiller
//
//  Created by gnu on 21/02/2015.
//  Copyright (c) 2015 gnu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface RoomCell : UITableViewCell <AVAudioPlayerDelegate>
@property (strong, nonatomic) IBOutlet UIView *bgView;
@property (strong, nonatomic) IBOutlet UILabel *roomnameLabel;
@property (strong, nonatomic) IBOutlet UILabel *roomTitle;
@property (strong, nonatomic) IBOutlet UILabel *speakerTitle;

@property (strong, nonatomic) IBOutlet UILabel *roomDescriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *speakerDescriptionLabel;
@property (strong, nonatomic) IBOutlet UIButton *previewButton;
- (IBAction)previewButtonPressed:(id)sender;

-(void) updateRoomnameLabel:(NSString*) label;
-(void) updateRoomDescriptionLabel:(NSString*) label;
-(void) updateSpeakerDescriptionLabel:(NSString*) label;

@property NSString* roomId;
@end
