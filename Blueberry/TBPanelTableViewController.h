//
//  TBPanelTableViewController.h
//  Blueberry
//
//  Created by Derek Omuro on 5/16/14.
//  Copyright (c) 2014 TeamBlueberry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

#import "MCSwipeTableViewCell.h"
#import "TBNavigationController.h"
#import "TBNavigationHeaderView.h"

@interface TBPanelTableViewController : UITableViewController <MCSwipeTableViewCellDelegate, MFMailComposeViewControllerDelegate>

@property NSMutableArray *dataSource;
@property TBNavigationController *sourceViewController;
@property TBNavigationHeaderView *navigationHeader;
@property UIColor *tint;
@property BOOL isCellSliding;

- (UIView *)viewWithImageName:(NSString *)imageName;
- (id)deleteCell:(MCSwipeTableViewCell *)cell;
- (void)emailReport;

@end
