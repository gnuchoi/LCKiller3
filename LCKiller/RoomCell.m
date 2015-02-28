//
//  RoomCell.m
//  LCKiller
//
//  Created by gnu on 21/02/2015.
//  Copyright (c) 2015 gnu. All rights reserved.
//

#import "RoomCell.h"
#import "AppDelegate.h"
@implementation RoomCell

- (void)awakeFromNib {
    // Initialization code
//    CAShapeLayer* maskLayer = [CAShapeLayer layer];
//    maskLayer.path = [UIBezierPath bezierPathWithRoundedRect: self.bgView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:(CGSize){10.0, 10.}].CGPath;
    //corner
    self.bgView.layer.cornerRadius = 2.0;
    //shadow
    self.bgView.layer.shadowColor = [[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.15] CGColor];
    self.bgView.layer.shadowOpacity = 1.0;
    self.bgView.layer.shadowRadius = 0.0;
    self.bgView.layer.shadowOffset = CGSizeMake(2, 2);
    [self.bgView setBackgroundColor:[UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.15]];
    

//    [self.bgView setBackgroundColor:[UIColor grayColor]];
    self.bgView.layer.masksToBounds = NO;
    
    self.bgView.hidden= YES;
    
    //set id label round
    self.roomTitle.layer.cornerRadius = 10.0;
    self.roomTitle.layer.borderWidth = 0.5;
    self.roomTitle.layer.borderColor = self.roomTitle.textColor.CGColor;
    
    self.speakerTitle.layer.cornerRadius = 10.0;
    self.speakerTitle.layer.borderWidth = 0.5;
    self.speakerTitle.layer.borderColor = self.speakerTitle.textColor.CGColor;
    
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (IBAction)previewButtonPressed:(id)sender {
    AppDelegate *thisApp = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    //find url for this cell's room
    NSString* bundlePath = [[NSBundle mainBundle] bundlePath];
    NSString* previewFileName = [NSString stringWithFormat:@"TOEIC_%@.mp3", self.roomId];
    NSString* previewFilePath = [NSString stringWithFormat:@"%@/IRs/%@", bundlePath, previewFileName];
    NSURL* previewFileURL = [NSURL fileURLWithPath:previewFilePath];

    NSLog(@"player setting url:%@", thisApp.previewPlayer.url);
    NSLog(@"previewfile url:%@", previewFileURL);
    

    
    if ([thisApp.previewPlayer.url isEqual:previewFileURL]){ //if it was set as this song,
        //no need to init again.
        NSLog(@"same song's button is pressed");
    }else{ //need to init new player.
        if([thisApp.previewPlayer isPlaying]){
            [thisApp.previewPlayer stop];
        }
        thisApp.previewPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:previewFileURL error:nil];
        thisApp.previewPlayer.numberOfLoops = 0;
        [thisApp.previewPlayer setDelegate:self];
        [thisApp.previewPlayer prepareToPlay];
        NSLog(@"new song's button is pressed");
        
    }
    //then play or pause.
    [self togglePlayPause];
    [self updatePreviewButton];
    
}



-(void) togglePlayPause{
    AppDelegate *thisApp = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    if ([thisApp.previewPlayer isPlaying]){ // pause.
        [thisApp.previewPlayer pause];
        
        
    }else{ // play.
        [thisApp.previewPlayer play];
    }
}

-(void) updatePreviewButton{
    AppDelegate *thisApp = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    if ([thisApp.previewPlayer isPlaying]){
  //      [self.previewButton setTitle:@"Pause" forState:UIControlStateNormal];
    }else{
    //    [self.previewButton setTitle:@"Play" forState:UIControlStateNormal];
    }
    
    
}


// view
-(void) updateRoomnameLabel:(NSString*) label{
    self.roomnameLabel.text = label;
}
-(void) updateRoomDescriptionLabel:(NSString*) label{
    self.roomDescriptionLabel.text = label;
    
}
-(void) updateSpeakerDescriptionLabel:(NSString*) label{
    self.speakerDescriptionLabel.text = label;
    
}
//preview player delegate method

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player
                       successfully:(BOOL)flag{
    NSString* flagStr;
    if(flag) flagStr = @"YES";
    else flagStr = @"NO";
    NSLog(@"avaudioplayer delegate method was called : did finish playing, with flag: %@", flagStr);
    [self updatePreviewButton];
    
    
}
//
- (UIEdgeInsets)layoutMargins
{
    return UIEdgeInsetsZero;
}



@end
