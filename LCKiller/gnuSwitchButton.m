//
//  mySwitchButton.m
//
//  Created by gnu on 21/11/2014.
//  Copyright (c) 2014 gnu. All rights reserved.
//

#import "gnuSwitchButton.h"

@interface gnuSwitchButton()

@property BOOL on;
@property UIImage* onImage;
@property UIImage* offImage;
@property UIImage* defaultImage;

@end


@implementation gnuSwitchButton{

}

@synthesize on;

-(id) init{
    if(self = [super init]){
        on = nil;
    }
    return self;
}
-(id) initWithImagesURL:(NSString*) onImageURL forOffImage:(NSString*) offImageURL forInitState:(BOOL)initState{
    if(self = [super init]){
        //set images
        [self setImagesWithURL:onImageURL forOffImage:offImageURL];
        //init state of the switch
        if(initState){
            [self turnOn];
        }else{
            [self turnOff];
        }
    }
    return self;
}

-(void) setImagesWithURL:(NSString*) onImageURL forOffImage:(NSString*) offImageURL{
    
    self.onImage = [UIImage imageWithContentsOfFile:onImageURL];
    self.offImage = [UIImage imageWithContentsOfFile:offImageURL];
    self.defaultImage = [UIImage imageWithContentsOfFile:onImageURL];
    
    if(self.on == nil){
        [self turnOn];
    }
    
    [self setTitle:nil forState:UIControlStateNormal];
}

-(BOOL) isOn{
    return self.on;
}

-(void) turnOn{
    [self setImage:self.onImage forState:UIControlStateNormal];
    [self setContentMode:UIViewContentModeScaleAspectFit];

    on = YES;
    [self setAlpha:0.75];
}

-(void) turnOff{
    [self setImage:self.offImage forState:UIControlStateNormal];
    [self setContentMode:UIViewContentModeScaleAspectFit];

    on = NO;
    [self setAlpha:0.35];
}

-(void) toggle{
    if (self.isOn){
        [self turnOff];
        
    }else{
        [self turnOn];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



@end
