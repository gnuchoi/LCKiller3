//
//  SongsTableViewController.m
//  LCKiller
//
//  Created by gnu on 01/02/2015.
//  Copyright (c) 2015 gnu. All rights reserved.
//

#import "SongsTableViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "SongCell.h"
#import "AKFoundation.h"
#import "SharedStore.h"
#import "AudioFilePlayer.h"
#import "AppDelegate.h"
#import "RoomSetting.h"
#define ROW_HEIGHT 50.0
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface SongsTableViewController (){
    NSString *exportPath;
    SharedStore *global;
    int selectedRow;
    AudioFilePlayerController* audioFilePlayerController;
    BOOL hasSelection;
    RoomSetting* roomSetting;
}
@end

@implementation SongsTableViewController

-(id)init{
    return [self initWithStyle:UITableViewStylePlain];
}
#pragma mark default methods
- (void)viewDidLoad {
    [super viewDidLoad];

    selectedRow = 0;
    // TABLE SOURCE DELEGATE
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    // TEMP: just to see the edge of view
   // [self.view setBackgroundColor:[UIColor blueColor]]; //이걸 켜면 맨 아래 bottom bar에만 이상한게 생기는데 이해 안됨.
    [self.view setBackgroundColor:[UIColor clearColor]];
    
    // Prepare some relavent vars.
    global = [SharedStore globals];
    roomSetting = [RoomSetting sharedInstance];
    // HEADER VIEW : "top cell", fixed view, for player controller
    
    self.headerVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HeaderViewControllerStoryboard_id"];
    [self addChildViewController:self.headerVC];
    self.headerVC.view.frame = CGRectMake(0., 0., self.view.frame.size.width, ROW_HEIGHT);

    self.floatingStatusCellVC =[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"FloatingStatusCellVCStoryboard_id"];
    self.floatingStatusCellVC.view.frame = CGRectMake(0., 0., self.view.frame.size.width, ROW_HEIGHT+1);
    self.floatingStatusCellVC.view.backgroundColor = UIColorFromRGB(0x593d4b); //temporary
//    self.floatingStatusCellVC.view.backgroundColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:0.4];
    
    //header view background image
    NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
    UIImageView* bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.headerVC.view.frame.size.width, self.headerVC.view.frame.size.height)];
    NSString* bgImgURL = [bundlePath stringByAppendingString:@"/img_bgs/bgTopCell.png"];
    [bgImageView setImage:[UIImage imageWithContentsOfFile:bgImgURL]];
    [bgImageView setContentMode:UIViewContentModeScaleAspectFit];
    [bgImageView setContentMode:UIViewContentModeTop];
    [self.headerVC.view insertSubview:bgImageView atIndex:0];//temp
    //
    [self hideFloatingView];
    //
    audioFilePlayerController = self.headerVC.afpController;
    audioFilePlayerController.afpControllerDelegate = self;


    
}
-(void) viewDidAppear:(BOOL)animated{

    NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
    NSString* bgImgURL = [bundlePath stringByAppendingString:@"/img_bgs/bgTopCell.png"];

    UIImageView* fakeHeader = [[UIImageView alloc] initWithFrame:self.headerVC.view.frame]; //add blank view as a header
    [self.tableView setTableHeaderView:fakeHeader];

    
    [self.view addSubview:self.headerVC.view];
    [self.view addSubview:self.floatingStatusCellVC.view];
    //set table's background
    bgImgURL = [bundlePath stringByAppendingString:@"/img_bgs/bgTable.png"];
    UIImageView* bgImageView = [[UIImageView alloc] initWithFrame:self.tableView.bounds];
    bgImageView.image = [UIImage imageWithContentsOfFile:bgImgURL];
    [bgImageView setContentMode:UIViewContentModeTop];
    self.tableView.backgroundView = bgImageView;
    
}
-(void) viewWillDisappear:(BOOL)animated{
    AppDelegate *thisApp = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [thisApp.previewPlayer stop];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark custom functions for table

-(void) updateHeader:(MPMediaItem*) song forTrackNumber:(NSString*) trackNumber{
    if(self.headerVC == nil){
        self.headerVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HeaderViewControllerStoryboard_id"];
    }

    [self.floatingStatusCellVC updateTitleLabel:[song valueForProperty:MPMediaItemPropertyTitle]];
    [self.floatingStatusCellVC updateArtistLabel:[song valueForProperty:MPMediaItemPropertyArtist]];
    [self.floatingStatusCellVC updateTrackNumberLabel:trackNumber];

}
-(void) hideFloatingView{
    hasSelection = NO;
    self.floatingStatusCellVC.view.hidden = YES;
}
-(void) showFloatingView{
    hasSelection = YES;
    self.floatingStatusCellVC.view.hidden = NO;
}

-(void) updatePlaylist:(NSString*) plstID{
    MPMediaPropertyPredicate *predicate = [MPMediaPropertyPredicate predicateWithValue:plstID forProperty:MPMediaPlaylistPropertyPersistentID];
    MPMediaQuery *query = [MPMediaQuery playlistsQuery];
    [query addFilterPredicate:predicate];

    //query.items : playlist items
    //[query collections]; array of items
    self.songs = [query items];
    [self.songs count];
    [self.tableView reloadData];
    [self hideFloatingView];
}
-(void) updateFloatingViewFrame{
    CGRect controllerFrame2 = self.floatingStatusCellVC.view.frame;
    
    if ((selectedRow+2)*ROW_HEIGHT >  CGRectGetMaxY(self.tableView.bounds)){ // fixing for bottom
//        NSLog(@"Case 1. bottom");
        controllerFrame2.origin.y = CGRectGetMaxY(self.tableView.bounds) - ROW_HEIGHT - 1;
        
    }else if ( (selectedRow)*ROW_HEIGHT <CGRectGetMaxY(self.tableView.bounds) - self.view.frame.size.height ){ // fix at the top
        controllerFrame2.origin.y = CGRectGetMaxY(self.tableView.bounds) - self.view.frame.size.height + ROW_HEIGHT - 1;
  //      NSLog(@"Case 2. top.");
    }else{
        controllerFrame2.origin.y = (selectedRow+1)*ROW_HEIGHT - 1;
    //    NSLog(@"Case 3. middle");
    }
    
    self.floatingStatusCellVC.view.frame = controllerFrame2;
}


#pragma mark scroll view delegate
-(void) scrollViewDidScroll:(UIScrollView *)scrollView{

//    CGFloat offsetY = scrollView.contentOffset.y;

  //  self.headerVC.view.transform = CGAffineTransformMakeTranslation(0, MIN(offsetY, 0));
    //// 1
    CGRect controllerFrame = self.headerVC.view.frame;
    // to fix it as a head
//    NSLog(@"%3.2f %3.2f", CGRectGetMinY(scrollView.bounds), CGRectGetMaxY(scrollView.bounds));
    
    /*
    if (CGRectGetMinY(scrollView.bounds) > 0 ){ // scrolling in the content
        controllerFrame.origin.y = CGRectGetMaxY(scrollView.bounds) - self.view.frame.size.height;
    } else{ // when pulling of the top of content.
        controllerFrame.origin.y = CGRectGetMinY(scrollView.bounds);
    }
     */
    controllerFrame.origin.y = CGRectGetMinY(scrollView.bounds);
    self.headerVC.view.frame = controllerFrame;
    
    
    //// 2
    CGRect controllerFrame2 = self.floatingStatusCellVC.view.frame;
    
    if ((selectedRow+2)*ROW_HEIGHT >  CGRectGetMaxY(scrollView.bounds)){ //
    //    NSLog(@"Case 1. bottom");
        controllerFrame2.origin.y = CGRectGetMaxY(scrollView.bounds) - ROW_HEIGHT - 1;

    }else if ( (selectedRow)*ROW_HEIGHT <CGRectGetMaxY(scrollView.bounds) - self.view.frame.size.height ){ // fix at the top
        controllerFrame2.origin.y = CGRectGetMaxY(scrollView.bounds) - self.view.frame.size.height + ROW_HEIGHT - 1;
//                NSLog(@"Case 2. top.");
    }else{
        controllerFrame2.origin.y = (selectedRow+1)*ROW_HEIGHT - 1;
  //              NSLog(@"Case 3. middle");
    }
    
    self.floatingStatusCellVC.view.frame = controllerFrame2;

    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.songs count];
}
-(UITableViewStyle) getTableStyle{
    return UITableViewStylePlain;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* CellIdentifier = @"SongsCell_id";
    SongCell *cell = (SongCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    //label for song information
    MPMediaItem* song = [self.songs objectAtIndex:indexPath.row];
    cell.titleLabel.text = [song valueForProperty:MPMediaItemPropertyTitle];
    cell.artistLabel.text= [song valueForProperty:MPMediaItemPropertyArtist];
    cell.trackNumberLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row+1];
    
    //selected cell color and views.
    UIView* bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:0.2];
    [cell setSelectedBackgroundView:bgColorView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //check if it's on iCloud or on Device
    MPMediaItem* selectedSong =[self.songs objectAtIndex:indexPath.row];
    if ([selectedSong valueForProperty:MPMediaItemPropertyAssetURL] != nil){
        [cell hideCloudButton];
    }else{
        [cell showCloudButton];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    selectedRow = (int)indexPath.row;
    NSLog(@"SongTableView selected new row:%d", selectedRow);
    self.songNow =[self.songs objectAtIndex:indexPath.row];
    SongCell *selectedCell=(SongCell*)[tableView cellForRowAtIndexPath:indexPath];
    //stop if it was playing
    [global.audioFilePlayer stop];
    //then set new.
    if ([self.songNow valueForProperty:MPMediaItemPropertyAssetURL] != nil){
        [self setSong:self.songNow];
        [self updateHeader:self.songNow forTrackNumber:[NSString stringWithFormat:@"%ld", indexPath.row+1]];
        [self updateFloatingViewFrame];
        [self showFloatingView];
    }
    else{
        [selectedCell cloudButtonPressed:nil];
    }
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ROW_HEIGHT;
}
#pragma mark AudioFilePlayerController delegate methods
-(void) fastRewind{
    if (global.audioFilePlayer.filePosition.value < 2.0){
        if (selectedRow != 0){

            [audioFilePlayerController pauseGlobalPlayer];
            [self selectRowManually:-1];
        }
    }else{
        roomSetting.startTime = 0.0;
  //      [audioFilePlayerController pauseGlobalPlayer];
//        [audioFilePlayerController loadExportedFile];
    //    [audioFilePlayerController resetAfterLoadAK];
     //   [audioFilePlayerController playGlobalPlayer];
//        [self selectRowManually:0]; //this cell again.
        //not work well - doesn't start from 0:00  //25 feb 2015.
    }
}
-(void) fastRewindForTen{
    
}
-(void) fastForwardForTen{
    
}
-(void) fastForward{
    NSLog(@"will do Fast forward: songsTableViewController");
    if (selectedRow == [self.songs count]-1){ // the last cell.
        //do nothing.
        NSLog(@"..this is the last cell.");
    }else{
        NSLog(@"..this is not the last cell.");
        [audioFilePlayerController pauseGlobalPlayer];
        [self selectRowManually:1];
    }
    
}
-(void) selectRowManually:(int)offsetForNewRow{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:selectedRow+offsetForNewRow inSection:0];
    [self.tableView selectRowAtIndexPath:indexPath
                                animated:NO
                          scrollPosition:UITableViewScrollPositionNone];
    [self.tableView.delegate tableView:self.tableView didSelectRowAtIndexPath:indexPath];

    
}

#pragma mark audiokit things
-(void) setSong:(MPMediaItem*) song{

    NSLog(@"set song");
    if ([[song  valueForProperty:MPMediaItemPropertyPersistentID] integerValue] !=
        [[global.currentSong valueForProperty:MPMediaItemPropertyPersistentID] integerValue]) {//new song,
        NSLog(@"set song - let's stop the sharedManager");
        [[AKManager sharedManager] stop];
        NSLog(@"set song - ok it's stopped, now time to export.");
        global.isPlaying = NO;
        global.currentSong = song;
        [self exportSong:song]; // after export, it starts to play.
        NSLog(@"set song - exported.");
        roomSetting.startTime = 0.0;
    }
    else{ // the same song again.
        global.isReadyToPlay = YES;
        [audioFilePlayerController playGlobalPlayer];
    }
}

-(void) exportSong:(MPMediaItem *)song {
    global.isReadyToPlay = NO;
    NSLog(@"export song - 1 ");
    NSURL *url = [song valueForProperty:MPMediaItemPropertyAssetURL];
    NSLog(@"export song - 2 ");
    AVURLAsset *songAsset = [AVURLAsset URLAssetWithURL:url options:nil];
    NSLog(@"export song - 3 ");
    NSError *assetError = nil;
    AVAssetReader *assetReader = nil;
    @try {
        assetReader = [AVAssetReader assetReaderWithAsset:songAsset error:&assetError];
        if (assetError) NSLog(@"Error: %@", assetError);
    }
    @catch (NSException *exception) {
        NSLog(@"Error");
    }
    NSLog(@"export song - 4 ");
    
    // Create an asset reader ouput and add it to the reader.
    AVAssetReaderOutput *assetReaderOutput = [AVAssetReaderAudioMixOutput
                                              assetReaderAudioMixOutputWithAudioTracks:songAsset.tracks
                                              audioSettings:nil];
    if (![assetReader canAddOutput:assetReaderOutput])
        NSLog(@"cant add reader output...die!");
    [assetReader addOutput:assetReaderOutput];
    
    // If a file already exists at the export path, remove it.
    if ([[NSFileManager defaultManager] fileExistsAtPath:global.exportPath]){
        NSLog(@"Deleting said file.");
        [[NSFileManager defaultManager] removeItemAtPath:global.exportPath error:nil];
    }
    // Create an asset writer with the export path.
    NSURL *exportURL = [NSURL fileURLWithPath:global.exportPath];
    AVAssetWriter *assetWriter = [AVAssetWriter assetWriterWithURL:exportURL
                                                          fileType:AVFileTypeCoreAudioFormat
                                                             error:&assetError];
    if (assetError) { NSLog(@"Error: %@", assetError); return; }
    
    // Define the format settings for the asset writer.  Defined in AVAudioSettings.h
    AudioChannelLayout channelLayout;
    memset(&channelLayout, 0, sizeof(AudioChannelLayout));
    channelLayout.mChannelLayoutTag = kAudioChannelLayoutTag_Mono;
    NSDictionary *outputSettings = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [NSNumber numberWithInt:kAudioFormatLinearPCM], AVFormatIDKey,
                                    [NSNumber numberWithFloat:48000.0], AVSampleRateKey,
                                    [NSNumber numberWithInt:1], AVNumberOfChannelsKey,
                                    [NSData dataWithBytes:&channelLayout length:sizeof(AudioChannelLayout)], AVChannelLayoutKey,
                                    [NSNumber numberWithInt:16], AVLinearPCMBitDepthKey,
                                    [NSNumber numberWithBool:NO], AVLinearPCMIsNonInterleaved,
                                    [NSNumber numberWithBool:NO], AVLinearPCMIsFloatKey,
                                    [NSNumber numberWithBool:NO], AVLinearPCMIsBigEndianKey, nil];
    
    // Create a writer input to encode and write samples in this format.
    AVAssetWriterInput *assetWriterInput = [AVAssetWriterInput
                                            assetWriterInputWithMediaType:AVMediaTypeAudio outputSettings:outputSettings];
    
    // Add the input to the writer.
    if ([assetWriter canAddInput:assetWriterInput])
        [assetWriter addInput:assetWriterInput];
    else { NSLog(@"cant add asset writer input...die!"); return; }
    
    // Change this property to YES if you want to start using
    // the data immediately.
    assetWriterInput.expectsMediaDataInRealTime = NO;
    
    // Start reading from the reader and writing to the writer.
    [assetWriter startWriting];
    [assetReader startReading];
    
    // Set the session start time.
    AVAssetTrack *soundTrack = [songAsset.tracks objectAtIndex:0];
    CMTime startTime = CMTimeMake(0, soundTrack.naturalTimeScale);
    [assetWriter startSessionAtSourceTime:startTime];
    
    // Variable to store the converted bytes.
    __block UInt64 convertedByteCount = 0;
    __block float buffers = 0;
    
    // Create a queue to which the writing block with be submitted.
    dispatch_queue_t mediaInputQueue = dispatch_queue_create("mediaInputQueue", NULL);
    
    // Instruct the writer input to invoke a block repeatedly, at its convenience, in
    // order to gather media data for writing to the output.
    [assetWriterInput requestMediaDataWhenReadyOnQueue:mediaInputQueue usingBlock:^
     {
         // While the writer input can accept more samples, keep appending its buffers
         // with buffers read from the reader output.
         while (assetWriterInput.readyForMoreMediaData) {
             CMSampleBufferRef nextBuffer = [assetReaderOutput copyNextSampleBuffer];
             if (nextBuffer) {
                 [assetWriterInput appendSampleBuffer:nextBuffer]; // append buffer
                 // Increment byte count.
                 
                 convertedByteCount += CMSampleBufferGetTotalSampleSize(nextBuffer);
                 buffers += .0002;
//                 convertedByteCount += CMSampleBufferGetTotalSampleSize (nextBuffer);
                 
             } else {
                 // All done
                 [assetWriterInput markAsFinished];
                 [assetWriter finishWritingWithCompletionHandler:^{

                     [audioFilePlayerController playGlobalPlayer];

                     global.isReadyToPlay = YES;
                 }];
                 [assetReader cancelReading];
                 break;
             }
             CFRelease(nextBuffer);
         }
     }];
    
}



@end
