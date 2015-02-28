//
//  MainViewController.h
//  LCKiller
//
//  Created by gnu on 25/01/2015.
//  Copyright (c) 2015 gnu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaylistViewController.h"
#import "ExamRoomTableViewController.h"
#import "SongsTableViewController.h"
#import "SharedStore.h"
#import "RoomSetting.h"
#import "RoomDashboardViewController.h"

@interface MainViewController : UIViewController <SetPlstDelegate, SetExamRoomDelegate, OpenRoomListDelegate>


-(void) setPlst:(NSString*) plstID;
-(void) setRoom:(NSDictionary*)roomInfo;
- (IBAction)openPlstList:(id)sender;
//- (IBAction)openRoomList:(id)sender;
-(void) openRoomListByDashboard;
@property (strong, nonatomic) IBOutlet UIView *containerViewForRoom;

@property (strong, nonatomic) IBOutlet UIView *containerViewForSongs;
@property (strong, nonatomic) SongsTableViewController* songsTableViewController;

@end


