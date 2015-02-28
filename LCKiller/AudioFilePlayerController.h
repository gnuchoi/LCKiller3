//
//  AudioFilePlayerController.h
//  LCKiller
//
//  Created by gnu on 07/02/2015.
//  Copyright (c) 2015 gnu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "RoomSetting.h"

@protocol AFPControllerDelegate <NSObject>
-(void) fastRewind;
-(void) fastRewindForTen;
-(void) fastForwardForTen;
-(void) fastForward;

@end

@interface AudioFilePlayerController : NSObject
@property (nonatomic, retain) id <AFPControllerDelegate> afpControllerDelegate;

//-(void) playAnyway;
-(void) stopAnyway;
-(void) playGlobalPlayer;
-(void) pauseGlobalPlayer;

-(void) loadExportedFile;
-(void) resetAfterLoadAK;

-(void) playPausePressed;

-(void) fastRewindPressed;
-(void) fastRewindForTenPressed;
-(void) fastForwardForTenPressed;
-(void) fastForwardPressed;
@end
