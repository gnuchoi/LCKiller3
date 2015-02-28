//
//  ExamRoomTableViewController.m
//  LCKiller
//
//  Created by gnu on 01/02/2015.
//  Copyright (c) 2015 gnu. All rights reserved.
//

#import "ExamRoomTableViewController.h"
#import "RoomCell.h"

@interface ExamRoomTableViewController (){
    NSDictionary* locationDict;
    NSDictionary* speakerDict;

}
@property (strong, nonatomic) NSArray *roomList;
@property (strong, nonatomic) UIImageView *bgImageView;

@end

@implementation ExamRoomTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[self navigationController] setNavigationBarHidden:NO];
    self.clearsSelectionOnViewWillAppear = NO;
    
    NSString* roomPlist = [[NSBundle mainBundle] pathForResource:@"RoomIAP" ofType:@"plist"];
    self.roomList = [NSArray arrayWithContentsOfFile:roomPlist];
    [self.tableView reloadData];
    //
    NSString* compPlist = [[NSBundle mainBundle] pathForResource:@"Components" ofType:@"plist"];
    NSDictionary* componentDict = [NSDictionary dictionaryWithContentsOfFile:compPlist];
    locationDict = [componentDict valueForKey:@"Location"];
    speakerDict  = [componentDict valueForKey:@"Speaker"];


    
    [self.view setBackgroundColor:[UIColor clearColor]];
        //back button
    
    UIBarButtonItem* tempButtonItem = [[UIBarButtonItem alloc] init];
    tempButtonItem.title = @"";
    self.navigationController.navigationBar.topItem.backBarButtonItem = tempButtonItem;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //bg image
    self.bgImageView = [[UIImageView alloc] init];
    [self.bgImageView setImage:[UIImage imageNamed:@"img_bgs/bgRoomList.png"]];
    
    [self.bgImageView setContentMode:UIViewContentModeTop];
    
    [self.tableView setBackgroundView:self.bgImageView];
    //separator
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    //header view
    UIView* blankHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0., 0., self.view.frame.size.width, 7.)];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.roomList count];
}
-(void)tableView:(UITableView*) tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // change room IR, etc...
    
    NSDictionary* roomDict = [self.roomList objectAtIndex:indexPath.row];
    
    [self.setExamRoomDelegate setRoom:roomDict];
    [self.navigationController popViewControllerAnimated:YES];
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RoomCell *cell = (RoomCell*) [tableView dequeueReusableCellWithIdentifier:@"RoomCell_id" forIndexPath:indexPath];

    NSDictionary* roomDict = [self.roomList objectAtIndex:indexPath.row];
    //id
    [cell updateRoomnameLabel:[roomDict valueForKey:@"ID"]];
    cell.roomId = [roomDict valueForKey:@"ID"];
    //room
    [cell updateRoomDescriptionLabel:[roomDict valueForKey:@"LocationDescription"]];
    
    //spk
    [cell updateSpeakerDescriptionLabel:[roomDict valueForKey:@"SpeakerDescription"]];
    //backbround setting-->> is it applying??
    cell.backgroundColor = [UIColor clearColor];
    UIView* selectedBgView = [[UIView alloc] initWithFrame:cell.frame];
    [selectedBgView setBackgroundColor:[UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.3]];
    cell.selectedBackgroundView = selectedBgView;
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
