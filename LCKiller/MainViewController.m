//
//  MainViewController.m
//  LCKiller
//
//  Created by gnu on 25/01/2015.
//  Copyright (c) 2015 gnu. All rights reserved.
//

#import "MainViewController.h"
#import "PlaylistViewController.h"
#import "ExamRoomTableViewController.h"
#import "RoomDashboardViewController.h"
#import "AppDelegate.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface MainViewController ()
@property PlaylistViewController* playlistViewController;
@property ExamRoomTableViewController* examRoomTableViewController;
@property RoomDashboardViewController* roomDashboardViewController;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.playlistViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"PlaylistViewControllerStoryboardID"];
    self.playlistViewController.setPlstDelegate = self;
    
    self.examRoomTableViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ExamRoomViewControllerStoryboardID"];
    self.examRoomTableViewController.setExamRoomDelegate = self;

    self.roomDashboardViewController.openRoomListDelegate = self;
    
    
    //navigation title setting
    [[self navigationController] setNavigationBarHidden:NO];
//    self.navigationItem.title = @"Listening Test";
    NSDictionary *titleSize = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"HelveticaNeue" size:18.0],NSFontAttributeName,[UIColor colorWithRed:249.0/255 green:228.0/255 blue:173.0/255 alpha:1.0],NSForegroundColorAttributeName, nil];
    self.navigationController.navigationBar.titleTextAttributes = titleSize;
    //nav button
    UIImage* temp = [UIImage imageNamed:@"img_icons/iconOpenPlst.png"];
    UIBarButtonItem *openPlstButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"img_icons/iconOpenPlst.png"] style:UIBarButtonItemStylePlain target:self action:@selector(openPlstListByButton)];
    self.navigationItem.rightBarButtonItem = openPlstButton;
    // back button color
    self.navigationController.navigationBar.barTintColor = UIColorFromRGB(0xcebc87);
//    [self.tabBarController.tabBar setFrame:CGRectZero];
    
    //self.hidesBottomBarWhenPushed = YES;
    
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"roomDashboardSegue_id"])
    {
        // Get reference to the destination view controller
//        RoomDashboardViewController* rdvc = (RoomDashboardViewController*)[segue destinationViewController];
        self.roomDashboardViewController = (RoomDashboardViewController*)[segue destinationViewController];
        
    }
    else if([[segue identifier] isEqualToString:@"songsTableViewSegue_id"]){
        self.songsTableViewController = (SongsTableViewController*)[segue destinationViewController];
    }
}
-(void) viewWillAppear:(BOOL)animated{
//    NSLog(@"main's view will appear is called.");
//    [[self navigationController] setNavigationBarHidden:NO];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
    

}

-(void) viewDidAppear:(BOOL)animated{
 //   NSLog(@" in viewdidappear of main vc, load songs table vc.");
 
//    [self.songsTableViewController.view setFrame:self.containerViewForSongs.frame];
 //   [self.view addSubview:self.songsTableViewController.view];
    /*
    NSLog(@"Done: in viewdidappear of main vc, load songs table vc.");
    NSLog(@"Frame of Main view: %f, %f, %f, %f", self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
    NSLog(@"Frame of song table v: %f, %f, %f, %f", self.songsTableViewController.view.frame.origin.x, self.songsTableViewController.view.frame.origin.y, self.songsTableViewController.view.frame.size.width, self.songsTableViewController.view.frame.size.height);
    NSLog(@"Frame of song container view: %f, %f, %f, %f", self.containerViewForSongs.frame.origin.x, self.containerViewForSongs.frame.origin.y, self.containerViewForSongs.frame.size.width, self.containerViewForSongs.frame.size.height);
     */
    
    //turn off the preview player

    AppDelegate *thisApp = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    if ([thisApp.previewPlayer isPlaying]){
        [thisApp.previewPlayer stop];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setPlst:(NSString*) plstID{
    //
//    NSLog(@"mainvc: plstID : %@", plstID);
    // update songsTableVC's list

    [self.songsTableViewController updatePlaylist:plstID];
    [self.songsTableViewController.headerVC.afpController stopAnyway];
    [self.songsTableViewController hideFloatingView];

}

-(void) setRoom:(NSDictionary*)roomInfo{
    
    NSString *roomID =[roomInfo valueForKey:@"ID"];
//    NSLog(@"mainvc: exam room id : %@", roomID);
    
    [RoomSetting sharedInstance].roomID = roomID;
//    NSLog(@"roomid in shared var is %@", [RoomSetting sharedInstance].roomID);
//    self.navigationItem.title = [roomInfo valueForKey:@"Name"];
    
    [[SharedStore globals].audioFilePlayer stop];
    [SharedStore globals].isPlaying = NO;
    
    [self.roomDashboardViewController updateDashboard:roomInfo];
    [self.songsTableViewController.headerVC.afpController stopAnyway];
    [self.songsTableViewController hideFloatingView];
    

}


- (IBAction)openPlstList:(id)sender {
//    NSLog(@"mainvc: open plstlist");
    [self.navigationController showViewController:self.playlistViewController sender:self];
//    [self presentViewController:playlistViewController animated:YES completion:^{}];
}
-(void) openPlstListByButton{
    [self.navigationController showViewController:self.playlistViewController sender:self];
}

-(void) openRoomListByDashboard{
    [self.navigationController showViewController:self.examRoomTableViewController sender:self];
}

/*
- (IBAction)openRoomList:(id)sender {
    NSLog(@"mainvc: open room list");
    [self.navigationController showViewController:self.examRoomTableViewController sender:self];
}*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(BOOL) prefersStatusBarHidden{
    return NO;
}

@end
