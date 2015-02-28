//
//  HeaderViewController.m
//  LCKiller
//
//  Created by gnu on 07/02/2015.
//  Copyright (c) 2015 gnu. All rights reserved.
//

#import "HeaderViewController.h"

@interface HeaderViewController ()
@end

@implementation HeaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.afpController = [[AudioFilePlayerController alloc] init];
//    self.view.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor= [UIColor clearColor];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)rewindButtonPressed:(id)sender {
    [self.afpController fastRewindPressed];
}

- (IBAction)rewindForTenButtonPressed:(id)sender {
    [self.afpController fastRewindForTenPressed];
}

- (IBAction)ffForTenButtonPressed:(id)sender {
    [self.afpController fastForwardForTenPressed];
}

- (IBAction)ffButtonPressed:(id)sender {
    NSLog(@"ff button pressed: from header view controller.");
    [self.afpController fastForwardPressed];
}



-(void) updateButtonPauseToPlay{
    [self.playPauseButton setTitle:@">" forState:UIControlStateNormal];
}
-(void) updateButtonPlayToPause{
    [self.playPauseButton setTitle:@"||" forState:UIControlStateNormal];
}

- (IBAction)playPauseButtonPressed:(id)sender {
    
    [self.afpController playPausePressed];
}
@end
