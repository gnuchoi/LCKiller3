//
//  PlaylistViewController.m
//  LCKiller
//
//  Created by gnu on 31/01/2015.
//  Copyright (c) 2015 gnu. All rights reserved.
//

#import "PlaylistViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#define ROW_HEIGHT 50.
#import "PlaylistCell.h"

@interface PlaylistViewController ()
@property (strong, nonatomic) NSMutableArray *plstList;
@property (strong, nonatomic) UIImageView *bgImageView;
@end

@implementation PlaylistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[self navigationController] setNavigationBarHidden:NO];

    //preserve selection between presentations
    self.clearsSelectionOnViewWillAppear =NO;
    NSLog(@"PlaylistViewController viewDidLoad is called");
    //init and load playlists
    self.plstList = [NSMutableArray arrayWithArray:[[MPMediaQuery playlistsQuery] collections]];
    [self.tableView reloadData];
    //back button
    UIBarButtonItem* tempButtonItem = [[UIBarButtonItem alloc] init];
    tempButtonItem.title = @"";
    self.navigationController.navigationBar.topItem.backBarButtonItem = tempButtonItem;
    //table header
    
    self.bgImageView = [[UIImageView alloc] init];
    [self.bgImageView setImage:[UIImage imageNamed:@"img_bgs/bgRoomList.png"]];
    
    [self.bgImageView setContentMode:UIViewContentModeTop];
    
    [self.tableView setBackgroundView:self.bgImageView];
    //header view
    UIView* blankHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0., 0., self.view.frame.size.width, 3.)];
    [self.tableView setTableHeaderView:blankHeaderView];

}
-(void) viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
    
}

-(void) viewDidAppear:(BOOL)animated{

    self.bgImageView.frame = self.view.frame;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) initHeader{
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, ROW_HEIGHT)];
    [self.tableView setTableHeaderView:self.headerView];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger) tableView:(UITableView *) tableView numberOfRowsInSection:(NSInteger)section{
    return self.plstList.count;
}
- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"PlstCell_id";
    PlaylistCell* cell = (PlaylistCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    //name label
    NSString* plstName = [[self.plstList objectAtIndex:indexPath.row] valueForProperty:MPMediaPlaylistPropertyName];
    [cell updatePlstNameLabel:plstName];
    //info label
    MPMediaQuery* plstQuery = [self.plstList objectAtIndex:indexPath.row];
    
    int numSong = (int)[plstQuery.items count];
    int durationPlst = 0;
    for(int i=0; i<numSong; i++){
        durationPlst += [[plstQuery.items[i] valueForProperty:MPMediaItemPropertyPlaybackDuration] intValue];
    }
    int duraSongs = (int)round((double)(durationPlst/60.));
    
    NSString* numSongStr = [NSString stringWithFormat:@"%d", numSong];
    NSString* duraSongsStr=[NSString stringWithFormat:@"%d", duraSongs];
    
    int lenStr1 = (int)[numSongStr length];
    int lenStr2 = (int)[duraSongsStr length];
    
    NSString* infoStr = [NSString stringWithFormat:@"%@ songs, %@ min", numSongStr, duraSongsStr];
    UIColor* foreColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.8];
    UIColor* subColor  = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.6];
    UIFont* foreFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
    NSDictionary* attrs = [NSDictionary dictionaryWithObjectsAndKeys:
                           foreFont, NSFontAttributeName,
                           foreColor, NSForegroundColorAttributeName, nil];
    NSDictionary* subAttrs = [NSDictionary dictionaryWithObjectsAndKeys:
                              foreFont, NSFontAttributeName,
                              subColor, NSForegroundColorAttributeName, nil];

    NSMutableAttributedString* infoAttrStr = [[NSMutableAttributedString alloc] initWithString:infoStr attributes:attrs];
    [infoAttrStr setAttributes:subAttrs range:NSMakeRange(lenStr1,7)];
    [infoAttrStr setAttributes:subAttrs range:NSMakeRange(lenStr1+lenStr2+8, 4)];

    [cell updatePlstInfoLabel:infoAttrStr];
    //etc
    cell.backgroundColor = [UIColor clearColor];
    UIView* selectedBgView = [[UIView alloc] initWithFrame:cell.frame];
    [selectedBgView setBackgroundColor:[UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.3]];
    cell.selectedBackgroundView = selectedBgView;

    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //set with delegate

    MPMediaPlaylist *playlist = self.plstList[indexPath.row];
    [self.setPlstDelegate setPlst:[playlist valueForProperty:MPMediaPlaylistPropertyPersistentID]];
//    [self dismissViewControllerAnimated:YES completion:^{}];
    [self.navigationController popViewControllerAnimated:YES];
    
    
    
}


@end
