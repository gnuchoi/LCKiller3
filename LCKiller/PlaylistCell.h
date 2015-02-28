//
//  PlaylistCell.h
//  LCKiller
//
//  Created by gnu on 23/02/2015.
//  Copyright (c) 2015 gnu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaylistCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *plstNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *plstInfoLabel;

-(void) updatePlstNameLabel:(NSString*) label;
-(void) updatePlstInfoLabel:(NSAttributedString*) label;

@end
