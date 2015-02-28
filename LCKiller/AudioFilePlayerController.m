//
//  AudioFilePlayerController.m
//  LCKiller
//
//  Created by gnu on 07/02/2015.
//  Copyright (c) 2015 gnu. All rights reserved.
//

#import "AudioFilePlayerController.h"
#import "SharedStore.h"

@interface AudioFilePlayerController(){
    SharedStore *global;
    RoomSetting *roomSetting;
    float currentTime;
    NSTimer* currentTimer;
}
@end
@implementation AudioFilePlayerController

-(id) init{
    self = [super init];
    if (self){
        global = [SharedStore globals];
        roomSetting = [RoomSetting sharedInstance];
        currentTime = 0;
        currentTimer = nil;[currentTimer invalidate];
    }
    return self;
}

-(void) playAnyway{
    [self playGlobalPlayer];
}

#pragma mark this will call delegate methods
-(void) fastRewindPressed{
    NSLog(@"going to rewind! the position is %f", global.audioFilePlayer.filePosition.value);
    [self.afpControllerDelegate fastRewind];
}
-(void) fastRewindForTenPressed{
    [self.afpControllerDelegate fastRewindForTen];
}
-(void) fastForwardForTenPressed{
    [self.afpControllerDelegate fastForwardForTen];
}
-(void) fastForwardPressed{
    NSLog(@"fast forward pressed: from afp controller.");
    [self.afpControllerDelegate fastForward];
}
///////
-(void) fastForwardAutomatically{
    NSLog(@"fast forward: automatically");
    [self.afpControllerDelegate fastForward];
}
-(void) stopAnyway{
    [global.audioFilePlayer stop];
    global.isPlaying = NO;
    [self stopGettingCurrentPosition];
}

-(void) playPausePressed{
    if (!global.isReadyToPlay) {
        NSLog(@"Not Ready");
        return;
    }
    if (!global.isPlaying){

        [self playGlobalPlayer];        
    } else {
        [self pauseGlobalPlayer];
    }
}

- (void)loadExportedFile {
    if ([[NSFileManager defaultManager] fileExistsAtPath:global.exportPath] == NO) {
        NSLog(@"File does not exist.");
        return;
    }
    // Create the orchestra and instruments
    global.audioFilePlayer = [[AudioFilePlayer alloc] init];
}

-(void) resetAfterLoadAK{
    [[AKManager sharedManager] stop];
    [AKOrchestra reset];
    [AKOrchestra addInstrument:global.audioFilePlayer];
    [[AKManager sharedManager] setIsLogging:YES];
    [AKOrchestra start];
    
}

-(void) playGlobalPlayer{
    //prepare
    [self loadExportedFile];
    [self resetAfterLoadAK];
    
    global.isPlaying = YES;
    float startTime = roomSetting.startTime; //[sec]
    NSLog(@"start time is set ti : %f", startTime);
    Playback* playback = [[Playback alloc] initWithStartTime:startTime];
    
    [global.audioFilePlayer playNote:playback];

    NSLog(@"before play, file position value is : %f", global.audioFilePlayer.filePosition.value);
  //  [self startGettingCurrentPosition];
    [self setupAutoFF];
    
}

-(void) pauseGlobalPlayer{
    NSLog(@"before pause, file position value is : %f", global.audioFilePlayer.filePosition.value);
    roomSetting.startTime += global.audioFilePlayer.filePosition.value; // [sec]
    NSLog(@"after pause,  file position value is : %f", global.audioFilePlayer.filePosition.value);
    NSLog(@"after pause, room.setting start time is %f", roomSetting.startTime);
    [global.audioFilePlayer stop];

  //  [self stopGettingCurrentPosition];
    global.isPlaying = NO;
    
    [self clearAutoFF];
    
}
#pragma mark 
-(void) setupAutoFF{
    float timeToGo = global.audioFilePlayer.duration - roomSetting.startTime;
    NSLog(@"set up auto ff! time to go is %f", timeToGo);
    dispatch_async(dispatch_get_main_queue(),^{
    currentTimer = [NSTimer scheduledTimerWithTimeInterval:timeToGo target:self selector:@selector(fastForwardAutomatically) userInfo:nil repeats:NO];
    });
    
}
-(void) clearAutoFF{
    [currentTimer invalidate];
    
}

-(void) getCurrentPosition{
    currentTime = roomSetting.startTime + global.audioFilePlayer.filePosition.value;
    NSLog(@"%f, %f of %f", roomSetting.startTime, global.audioFilePlayer.filePosition.value, global.audioFilePlayer.duration);
    if(global.audioFilePlayer.duration < currentTime){
        [self.afpControllerDelegate fastForward]; // go to next track when it's done.
        NSLog(@"Fast Forward as it's the end of the file!");
    }
}
-(void) startGettingCurrentPosition{
    if(currentTimer == nil | !currentTimer.valid){
        NSLog(@"afpcontroller; start getting current position");
        [self getCurrentPosition];
        /*
        dispatch_async(dispatch_get_main_queue(), ^{
            currentTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(getCurrentPosition) userInfo:nil repeats:YES];
            NSLog(@"timer was seted.");
        });
         */
    }

}
-(void) stopGettingCurrentPosition{
    [currentTimer invalidate];
  //  currentTimer = nil;
    NSLog(@"afpcontroller; stop timer==stop getting current position");
}
@end
