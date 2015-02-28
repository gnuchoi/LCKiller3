//
//  RoomDashboardViewController.m
//  LCKiller
//
//  Created by gnu on 01/02/2015.
//  Copyright (c) 2015 gnu. All rights reserved.
//

#import "RoomDashboardViewController.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorFromRGB_alpha60(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:0.6]


@interface RoomDashboardViewController (){
    UIButton* overlayButton;
    NSDictionary* locationDict;
    NSDictionary* speakerDict;
}

@end

@implementation RoomDashboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self.view setBackgroundColor:[UIColor grayColor]];
    //labels
    NSString* compPlist = [[NSBundle mainBundle] pathForResource:@"Components" ofType:@"plist"];
    NSDictionary* componentDict = [NSDictionary dictionaryWithContentsOfFile:compPlist];
    locationDict = [componentDict valueForKey:@"Location"];
    speakerDict  = [componentDict valueForKey:@"Speaker"];
    [self.statusLabelWhere setText:@""];
    [self.statusLabelSpeaker setText:@""];

    
}
-(void) viewDidAppear:(BOOL)animated{
        NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
    UIImageView* bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    NSLog(@"%f, %f", self.view.frame.size.width, self.view.frame.size.height);
    NSString* bgImgURL = [bundlePath stringByAppendingString:@"/img_bgs/bgDashboard.png"];
    [bgImageView setImage:[UIImage imageWithContentsOfFile:bgImgURL]];
//    [bgImageView setContentMode:UIViewContentModeScaleAspectFill];
    [self.view insertSubview:bgImageView atIndex:0];
//button.
    if(overlayButton == nil){
        overlayButton = [[UIButton alloc] initWithFrame:self.view.bounds];
        overlayButton.backgroundColor = [UIColor clearColor];
        [self.view addSubview:overlayButton];
        [overlayButton addTarget:self action:@selector(openRoomFromDashboard) forControlEvents:UIControlEventTouchUpInside];
        
    }
    

    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) openRoomFromDashboard{
    [self.openRoomListDelegate openRoomListByDashboard];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void) updateDashboard:(NSDictionary*) roomDict{
    
    NSString* roomName = [roomDict valueForKey:@"Name"];
    NSNumber* locationID = [roomDict valueForKey:@"LocationID"];
    NSNumber* speakerID = [roomDict valueForKey:@"SpeakerID"];
    NSNumber* numStarsNum = [roomDict valueForKey:@"Difficulty"];

    NSString* stars;
    
    switch ([numStarsNum integerValue]) {
        case 0:
                stars = @"☆";
            break;
        case 1:
            stars = @"★";
            break;
        case 2:
            stars = @"★★";
            break;
        case 3:
            stars = @"★★★";
            break;
            
        default:
            break;
    }
    [self.roomNameLabel setText:[NSString stringWithFormat:@"%@ %@", roomName, stars]];
    [self.roomNameLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:30]];
    
//    UIColor* foreColor = UIColorFromRGB_alpha60(0xf9e4ad);
    UIColor* foreColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.9];
    UIColor* subColor  = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
    UIFont* foreFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
    NSDictionary* attrs = [NSDictionary dictionaryWithObjectsAndKeys:
                           foreFont, NSFontAttributeName,
                           foreColor, NSForegroundColorAttributeName, nil];
    NSDictionary* subAttrs = [NSDictionary dictionaryWithObjectsAndKeys:
                              foreFont, NSFontAttributeName,
                              subColor, NSForegroundColorAttributeName, nil];
    
    
//    NSString* locationName = [locationDict valueForKey:[locationID stringValue]];
    NSString* locationName = [NSString stringWithFormat:@"Room: %@", [roomDict valueForKey:@"LocationDescription"]];
    NSMutableAttributedString* attrLocationName = [[NSMutableAttributedString alloc] initWithString:locationName attributes:attrs];
    [attrLocationName setAttributes:subAttrs range:NSMakeRange(0,5)];
    [self.statusLabelWhere setAttributedText:attrLocationName];
    
//    NSString* speakerName = [speakerDict valueForKey:[speakerID stringValue]];
    NSString* speakerName = [NSString stringWithFormat:@"Speaker: %@", [roomDict valueForKey:@"SpeakerDescription"]];
    NSMutableAttributedString* attrSpeakerName = [[NSMutableAttributedString alloc] initWithString:speakerName attributes:attrs];
    [attrSpeakerName setAttributes:subAttrs range:NSMakeRange(0,8)];
    [self.statusLabelSpeaker setAttributedText:attrSpeakerName];

}


@end
