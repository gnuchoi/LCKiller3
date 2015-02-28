//
//  RoomSetting.m
//  LCKiller
//
//  Created by gnu on 07/02/2015.
//  Copyright (c) 2015 gnu. All rights reserved.
//

#import "RoomSetting.h"

@implementation RoomSetting
@synthesize roomID = _roomID;

+(RoomSetting*) sharedInstance{
    static dispatch_once_t onceToken;
    static RoomSetting *instance = nil;
    
    dispatch_once(&onceToken, ^{
        instance = [[RoomSetting alloc] init];
    });

    return instance;
}
-(id)init{
    self = [super init];
    if(self){
        _roomID = [[NSString alloc] init];
        startTime = 0.0;
        self.durationOfFile = 9999.;
        NSLog(@"# # # # # # # Room setting is initiated.");
    }
    return self;
}
@end
