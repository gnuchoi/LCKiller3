//
//  ExamRoomTableViewController.h
//  LCKiller
//
//  Created by gnu on 01/02/2015.
//  Copyright (c) 2015 gnu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SetExamRoomDelegate <NSObject>
- (void) setRoom:(NSDictionary*) roomInfo;
@end

@interface ExamRoomTableViewController : UITableViewController

@property (nonatomic, retain) id <SetExamRoomDelegate> setExamRoomDelegate;

@end
