//
//  TBAppDelegate.h
//  Blueberry
//
//  Created by Derek Omuro on 5/14/14.
//  Copyright (c) 2014 TeamBlueberry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBEncounterTableViewController.h"
#import "INBeaconService.h"
#import "TBPerson.h"

@interface TBAppDelegate : UIResponder <UIApplicationDelegate, INBeaconServiceDelegate>

@property (strong, nonatomic) UIWindow *window;
@property CMMotionManager *motionManager;
@property TBPerson *myProfile;

-(void)refreshTestData;

@end
