//
//  TBEventFooterView.h
//  Blueberry
//
//  Created by Derek Omuro on 5/14/14.
//  Copyright (c) 2014 TeamBlueberry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBNavigationController.h"

@interface TBEventFooterView : UIView
@property TBNavigationController *sourceViewController;
@property NSString *eventName;

-(void)playTapped;
-(void)handleTap:(UITapGestureRecognizer*)recognizer;
-(void)refreshLabelsWithEventName:(NSString*)eventName;

@end
