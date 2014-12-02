//
//  TBNavigationViewController.h
//  Blueberry
//
//  Created by Derek Omuro on 5/14/14.
//  Copyright (c) 2014 TeamBlueberry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>
//#import "TBEventFooterView.h"

@interface TBNavigationController : UINavigationController <UIViewControllerTransitioningDelegate>

@property NSMutableArray *encounterDataSource;
@property NSMutableArray *toFollowDataSource;
@property NSMutableArray *contactDataSource;

@property NSString *eventName;


- (void)presentEventViewController:(BOOL)isPlaying;
- (void)updateViewController:(NSInteger) selectedSegment;
- (void)playTapped;
- (void)eventSettingsViewDismissed;
- (void)updateDataSource;
- (void)setTint:(UIColor *)color;
- (void)updateName;

- (void)panicUpdate;

@end
