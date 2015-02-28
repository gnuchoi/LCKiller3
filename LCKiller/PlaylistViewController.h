//
//  PlaylistViewController.h
//  LCKiller
//
//  Created by gnu on 31/01/2015.
//  Copyright (c) 2015 gnu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SetPlstDelegate <NSObject>
- (void) setPlst:(NSString*) plstID;

@end

@interface PlaylistViewController : UITableViewController

@property (nonatomic, retain) id <SetPlstDelegate> setPlstDelegate;
@property (nonatomic, strong) UIView* headerView;

@end
