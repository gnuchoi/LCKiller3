//
//  mySwitchButton.h
//
//  Created by gnu on 21/11/2014.
//  Copyright (c) 2014 gnu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface gnuSwitchButton : UIButton 


-(BOOL) isOn;
-(id) initWithImagesURL:(NSString*) onImageURL forOffImage:(NSString*) offImageURL forInitState:(BOOL)initState;
-(void) setImagesWithURL:(NSString*) onImageURL forOffImage:(NSString*) offImageURL;
-(void) turnOn;
-(void) turnOff;
-(void) toggle;

@end
