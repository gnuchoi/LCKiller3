//
//  SongCell.m
//  LCKiller
//
//  Created by gnu on 02/02/2015.
//  Copyright (c) 2015 gnu. All rights reserved.
//

#import "SongCell.h"
#import "SharedStore.h"

@interface SongCell (){
    AudioFilePlayerController* audioFilePlayerController;
    SharedStore* global;
}
@end

@implementation SongCell

- (void)awakeFromNib {
    // Initialization code
    audioFilePlayerController = [[AudioFilePlayerController alloc] init];
    global = [SharedStore globals];
    self.backgroundColor = [UIColor clearColor];

    
    self.cloudButton.hidden = YES;
    NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
    NSString* imgURL = [bundlePath stringByAppendingString:@"/img_icons/iconCloud.png"];
    [self.cloudButton setImage:[UIImage imageWithContentsOfFile:imgURL] forState:UIControlStateNormal];
    [self.cloudButton setTitle:@"" forState:UIControlStateNormal];
    [self.cloudButton setAlpha:0.2];

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void) showCloudButton{
    self.cloudButton.hidden = NO;
//    UIView* grayView = [[UIView alloc] initWithFrame:self.frame];
//    [grayView setBackgroundColor:[UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:0.4]];
//    [self insertSubview:grayView atIndex:0];
    
    }
-(void) hideCloudButton{ self.cloudButton.hidden = YES; }

- (IBAction)cloudButtonPressed:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Song is not found in device" message:@"This song only exists in your iCloud. You can download the song in Music app" delegate:self cancelButtonTitle:@"Open Music" otherButtonTitles:nil];
    [alert addButtonWithTitle:@"Close"];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"music:"]];

    }else if (buttonIndex == 1){
        // do nothing
    }
}
@end
