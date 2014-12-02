//
//  TBEventViewController.h
//  Blueberry
//
//  Created by Derek Omuro on 5/14/14.
//  Copyright (c) 2014 TeamBlueberry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBNavigationController.h"

@interface TBEventSettingsViewController : UIViewController
@property TBNavigationController *sourceViewController;
@property BOOL isPlaying;
@property NSString *eventName;

-(void)setPlayButton:(BOOL)isPlaying;

@end
