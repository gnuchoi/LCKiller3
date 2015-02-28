//
//  RoomDashboardViewController.h
//  LCKiller
//
//  Created by gnu on 01/02/2015.
//  Copyright (c) 2015 gnu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "gnuSwitchButton.h"

@protocol OpenRoomListDelegate <NSObject>
-(void) openRoomListByDashboard;
@end
@interface RoomDashboardViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *roomNameLabel;

@property (strong, nonatomic) IBOutlet UILabel *statusLabelWhere;
@property (strong, nonatomic) IBOutlet UILabel *statusLabelSpeaker;

-(void) updateDashboard:(NSDictionary*) roomDict;
@property (nonatomic, retain) id <OpenRoomListDelegate> openRoomListDelegate;

@end
