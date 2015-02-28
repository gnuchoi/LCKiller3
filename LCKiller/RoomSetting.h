//
//  RoomSetting.h
//  LCKiller
//
//  Created by gnu on 07/02/2015.
//  Copyright (c) 2015 gnu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RoomSetting : NSObject
{
    NSString* roomID;
    float startTime;
}

@property float startTime;
@property (nonatomic, strong, readwrite) NSString* roomID;
@property (nonatomic) float durationOfFile;

+(RoomSetting *) sharedInstance;
@end
