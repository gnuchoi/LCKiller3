//
//  FloatingStatusCellViewController.h
//  LCKiller
//
//  Created by gnu on 19/02/2015.
//  Copyright (c) 2015 gnu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FloatingStatusCellViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *artistLabel;
@property (strong, nonatomic) IBOutlet UILabel *trackNumberLabel;


-(void) updateTrackNumberLabel:(NSString*) trackNumber;
-(void) updateTitleLabel:(NSString*) title;
-(void) updateArtistLabel:(NSString*) artist;

@end
