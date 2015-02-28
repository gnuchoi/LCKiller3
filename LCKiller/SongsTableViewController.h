//
//  SongsTableViewController.h
//  LCKiller
//
//  Created by gnu on 01/02/2015.
//  Copyright (c) 2015 gnu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "AudioFilePlayerController.h"
#import "HeaderViewController.h"
#import "FloatingStatusCellViewController.h"
@interface SongsTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, AFPControllerDelegate>

//afp controller delegate method
-(void) fastRewind;
-(void) fastRewindForTen;
-(void) fastForwardForTen;
-(void) fastForward;


//usual things
@property NSArray* songs;
@property MPMediaItem* songBefore;
@property MPMediaItem* songNow;
@property MPMediaItem* songAfter;

@property HeaderViewController* headerVC;
-(void) updatePlaylist:(NSString*) plstID;
@property FloatingStatusCellViewController* floatingStatusCellVC;

-(void) hideFloatingView;
-(void) showFloatingView;
@end
