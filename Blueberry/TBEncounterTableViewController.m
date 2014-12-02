//
//  TBEncounterListViewController.m
//  Blueberry
//
//  Created by Derek Omuro on 5/14/14.
//  Copyright (c) 2014 TeamBlueberry. All rights reserved.
//

#import "TBEncounterTableViewController.h"
#import "TBToFollowTableViewController.h"
#import "TBPerson.h"
#import "TBAppDelegate.h"

@interface TBEncounterTableViewController ()

@end

@implementation TBEncounterTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //asdftai set this.
    self.tint = [UIColor colorWithRed:255/255. green:95/255. blue:92/255. alpha:1];
//    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(panic)]];
}

//- (void)panic
//{
//    [(TBAppDelegate*)[[UIApplication sharedApplication] delegate] refreshTestData];
//}

#pragma mark - UITableViewDataSource
- (void)configureCell:(MCSwipeTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIView *checkView = [self viewWithImageName:@"bolt4"];
//    UIColor *greenColor = [UIColor colorWithRed:85.0 / 255.0 green:213.0 / 255.0 blue:80.0 / 255.0 alpha:1.0];
    UIColor *greenColor = [UIColor colorWithRed:255/255. green:210/255. blue:76/255. alpha:1];

    
    UIView *crossView = [self viewWithImageName:@"cross"];
    UIColor *redColor = [UIColor colorWithRed:232.0 / 255.0 green:61.0 / 255.0 blue:14.0 / 255.0 alpha:1.0];
    
    UIView *clockView = [self viewWithImageName:@"clock"];
    UIColor *yellowColor = [UIColor colorWithRed:254.0 / 255.0 green:217.0 / 255.0 blue:56.0 / 255.0 alpha:1.0];
    
    UIView *listView = [self viewWithImageName:@"list"];
    UIColor *brownColor = [UIColor colorWithRed:206.0 / 255.0 green:149.0 / 255.0 blue:98.0 / 255.0 alpha:1.0];
    
    // Setting the default inactive state color to the tableView background color
    [cell setDefaultColor:self.tableView.backgroundView.backgroundColor];
    
    [cell setDelegate:self];
    
    [cell.textLabel setText:[[self.dataSource objectAtIndex:indexPath.row] name]];
    [cell.detailTextLabel setText:[[self.dataSource objectAtIndex:indexPath.row] company]];
    [cell.imageView setImage:[[self.dataSource objectAtIndex:indexPath.row] profileImage]];
    
    [cell setSwipeGestureWithView:checkView color:greenColor mode:MCSwipeTableViewCellModeExit state:MCSwipeTableViewCellState1 completionBlock:^(MCSwipeTableViewCell *cell, MCSwipeTableViewCellState state, MCSwipeTableViewCellMode mode) {
        NSLog(@"Did swipe \"Checkmark\" cell");
        id pushData = [self deleteCell:cell];
        [self.sourceViewController.toFollowDataSource addObject:pushData];
    }];
    
    [cell setSwipeGestureWithView:crossView color:redColor mode:MCSwipeTableViewCellModeNone state:MCSwipeTableViewCellState2 completionBlock:^(MCSwipeTableViewCell *cell, MCSwipeTableViewCellState state, MCSwipeTableViewCellMode mode) {
        NSLog(@"Did swipe \"Cross\" cell");
        
        [self deleteCell:cell];
    }];
    
    [cell setSwipeGestureWithView:clockView color:yellowColor mode:MCSwipeTableViewCellModeNone state:MCSwipeTableViewCellState3 completionBlock:^(MCSwipeTableViewCell *cell, MCSwipeTableViewCellState state, MCSwipeTableViewCellMode mode) {
        NSLog(@"Did swipe \"Clock\" cell");
    }];
    
    [cell setSwipeGestureWithView:listView color:brownColor mode:MCSwipeTableViewCellModeNone state:MCSwipeTableViewCellState4 completionBlock:^(MCSwipeTableViewCell *cell, MCSwipeTableViewCellState state, MCSwipeTableViewCellMode mode) {
        NSLog(@"Did swipe \"List\" cell");
    }];
}

@end
