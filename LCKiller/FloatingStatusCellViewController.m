//
//  FloatingStatusCellViewController.m
//  LCKiller
//
//  Created by gnu on 19/02/2015.
//  Copyright (c) 2015 gnu. All rights reserved.
//

#import "FloatingStatusCellViewController.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface FloatingStatusCellViewController ()

@end

@implementation FloatingStatusCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLabel.textColor       = UIColorFromRGB(0xf2b9a0);
    self.artistLabel.textColor      = UIColorFromRGB(0xf2b9a0);
    self.trackNumberLabel.textColor = UIColorFromRGB(0xf2b9a0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) updateTitleLabel:(NSString*) title{
    [self.titleLabel setText:title];
}
-(void) updateArtistLabel:(NSString*) artist{
    [self.artistLabel setText:artist];
}
-(void) updateTrackNumberLabel:(NSString*) trackNumber{
    [self.trackNumberLabel setText:trackNumber];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
