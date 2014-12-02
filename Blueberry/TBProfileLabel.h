//
//  TBProfileLabel.h
//  Blueberry
//
//  Created by Derek Omuro on 5/18/14.
//  Copyright (c) 2014 TeamBlueberry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface TBProfileLabel : UIView <MFMailComposeViewControllerDelegate>

@property NSString *title;
@property NSString *text;
@property UIViewController *sourceViewController;

- (id)initWithFrame:(CGRect)frame withTitle:(NSString*)title withText:(NSString*)text;

@end
