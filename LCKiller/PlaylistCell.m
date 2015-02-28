//
//  PlaylistCell.m
//  LCKiller
//
//  Created by gnu on 23/02/2015.
//  Copyright (c) 2015 gnu. All rights reserved.
//

#import "PlaylistCell.h"

@implementation PlaylistCell

- (void)awakeFromNib {
    // Initialization code
    self.plstNameLabel.textColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.8];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void) updatePlstNameLabel:(NSString*) label{
    self.plstNameLabel.text = label;
    
}
-(void) updatePlstInfoLabel:(NSAttributedString*) label{
    [self.plstInfoLabel setAttributedText:label];
    
}

@end
