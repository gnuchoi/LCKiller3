//
//  AudioFilePlayer.m
//  Song Library Player Example
//
//  Created by Aurelius Prochazka on 6/16/12.
//  Copyright (c) 2014 Aurelius Prochazka. All rights reserved.
#import "AudioFilePlayer.h"

@interface AudioFilePlayer ()
@property NSString* roomID;
@end

@implementation AudioFilePlayer

- (instancetype)init {
    self = [super init];
    if (self) {
        NSLog(@"AudioFilePlauyer is initted.");
        self.roomID = [RoomSetting sharedInstance].roomID;
        if (self.roomID == nil | [self.roomID isEqualToString:@""]){
            self.roomID = @"101";
            NSLog(@"room setting global var's room id was nil.");
        }
        NSLog(@"Anyway, room id in audiofileplay is now %@", self.roomID);
        
        // INSTRUMENT DEFINITION ===============================================
        NSArray *docDirs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docDir = [docDirs objectAtIndex:0];
        NSString *file = [[docDir stringByAppendingPathComponent:@"exported"]
                          stringByAppendingPathExtension:@"wav"];
        NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
        
        //duration of the wav
        NSError *attributesError = nil;
        NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:file error:&attributesError];
        NSNumber *filesizeNumber = [fileAttributes objectForKey:NSFileSize];
        self.duration = [filesizeNumber floatValue] / 96000.;
        RoomSetting* roomSetting= [RoomSetting sharedInstance];
        roomSetting.durationOfFile = self.duration;
        
        //file input
        NSString* irLeft = [NSString stringWithFormat:@"%@/IRs/%@_left.wav",  bundlePath, self.roomID];
        NSString* irRight= [NSString stringWithFormat:@"%@/IRs/%@_right.wav", bundlePath, self.roomID];
    
        AKMonoFileInput* fileIn = [[AKMonoFileInput alloc] initWithFilename:file];

        _filePosition = [[AKInstrumentProperty alloc] initWithValue:0];
        [self addProperty:_filePosition];
        
        //start time setting.
        Playback* note = [[Playback alloc] init];//no effect
        [self addNoteProperty:note.startTime];
        
        fileIn.startTime = note.startTime;
        
        //connect file
        [self connect:fileIn];
        
        //connect convolution ir's for left/right
        AKConvolution* irLeftConv = [[AKConvolution alloc] initWithInput:fileIn impulseResponseFilename:irLeft];
        [self connect:irLeftConv];
        
        AKConvolution* irRightConv= [[AKConvolution alloc] initWithInput:fileIn impulseResponseFilename:irRight];
        [self connect:irRightConv];
        //connect output
        AKAudioOutput *audio;
        audio = [[AKAudioOutput alloc] initWithLeftAudio:irLeftConv
                                              rightAudio:irRightConv]; // were irLeftConv, irRightConv

        [self connect:audio];
        [self assignOutput:_filePosition to:akp((68.775+0.01-0.0085+1)/48000.0)];
        
     //   [self enableParameterLog:@"filePosition" parameter:_filePosition timeInterval:1.];
    }
    return self;
}
@end

@implementation Playback

-(instancetype) init{
    self = [super init];
    if (self){
        _startTime = [[AKNoteProperty alloc] initWithValue:0 minimum:0 maximum:100000000];
        [self addProperty:_startTime];
    }
    return self;
}

-(instancetype) initWithStartTime:(float)startTime{
    self = [self init];
    if (self){
        _startTime.value = startTime;
    }
    return self;
}

@end
