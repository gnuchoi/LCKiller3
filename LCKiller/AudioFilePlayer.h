//
//  AudioFilePlayer.h
//  Song Library Player Example
//
//  Created by Aurelius Prochazka on 6/16/12.
//  Copyright (c) 2014 Aurelius Prochazka. All rights reserved.
//

#import "AKFoundation.h"
#import "RoomSetting.h"

@interface AudioFilePlayer : AKInstrument

@property (readonly) AKInstrumentProperty *filePosition;
@property (readonly) AKStereoAudio *auxilliaryOutput;
@property float duration;
@end

//learned from effectsprocessor demo, https://groups.google.com/forum/#!topic/audiokit/3yZrxdj937E
@interface Playback : AKNote

@property AKNoteProperty *startTime;

- (instancetype)initWithStartTime:(float)startTime;

@end