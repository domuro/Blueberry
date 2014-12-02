//
//  TBContactListViewController.m
//  Blueberry
//
//  Created by Derek Omuro on 5/14/14.
//  Copyright (c) 2014 TeamBlueberry. All rights reserved.
//

#import "TBContactTableViewController.h"
#import "TBPerson.h"

@interface TBContactTableViewController ()

@end

@implementation TBContactTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(emailReport)]];
    //asdftai set this.
    self.tint = [UIColor colorWithRed:74/255. green:209/255. blue:149/255. alpha:1];
    
//    UISearchBar *testbar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
//    [testbar setBackgroundColor:[UIColor whiteColor]];
//    [[self tableView] setTableHeaderView:testbar];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.dataSource sortUsingComparator:^NSComparisonResult(id a, id b){
        NSString *first = [(TBPerson*)a name];
        NSString *second = [(TBPerson*)b name];
        
        return [first compare:second];
    }];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource
- (void)configureCell:(MCSwipeTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIView *checkView = [self viewWithImageName:@"check"];
    UIColor *greenColor = [UIColor colorWithRed:85.0 / 255.0 green:213.0 / 255.0 blue:80.0 / 255.0 alpha:1.0];
    
    UIView *crossView = [self viewWithImageName:@"cross"];
    UIColor *redColor = [UIColor colorWithRed:255/255. green:95/255. blue:92/255. alpha:1];
    
//    UIView *clockView = [self viewWithImageName:@"clock"];
//    UIColor *yellowColor = [UIColor colorWithRed:254.0 / 255.0 green:217.0 / 255.0 blue:56.0 / 255.0 alpha:1.0];
    
    UIView *listView = [self viewWithImageName:@"list"];
    UIColor *brownColor = [UIColor colorWithRed:206.0 / 255.0 green:149.0 / 255.0 blue:98.0 / 255.0 alpha:1.0];
    
    // Setting the default inactive state color to the tableView background color
    [cell setDefaultColor:self.tableView.backgroundView.backgroundColor];
    
    [cell setDelegate:self];
    
    [cell.textLabel setText:[[self.dataSource objectAtIndex:indexPath.row] name]];
    [cell.detailTextLabel setText:[[self.dataSource objectAtIndex:indexPath.row] company]];
    [cell.imageView setImage:[[self.dataSource objectAtIndex:indexPath.row] profileImage]];
    
    [cell setSwipeGestureWithView:checkView color:greenColor mode:MCSwipeTableViewCellModeNone state:MCSwipeTableViewCellState1 completionBlock:^(MCSwipeTableViewCell *cell, MCSwipeTableViewCellState state, MCSwipeTableViewCellMode mode) {
        NSLog(@"Did swipe \"Checkmark\" cell");
    }];
    
    [cell setSwipeGestureWithView:crossView color:redColor mode:MCSwipeTableViewCellModeNone state:MCSwipeTableViewCellState2 completionBlock:^(MCSwipeTableViewCell *cell, MCSwipeTableViewCellState state, MCSwipeTableViewCellMode mode) {
        NSLog(@"Did swipe \"Cross\" cell");
    }];
    
    __strong TBContactTableViewController *weakSelf = self;
    [cell setSwipeGestureWithView:crossView color:redColor mode:MCSwipeTableViewCellModeExit state:MCSwipeTableViewCellState3 completionBlock:^(MCSwipeTableViewCell *cell, MCSwipeTableViewCellState state, MCSwipeTableViewCellMode mode) {
    NSLog(@"Did swipe \"Clock\" cell");
        __strong TBContactTableViewController *strongSelf = weakSelf;
        strongSelf.cellToDelete = cell;
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Delete"
                                                            message:@"Are you sure your want to remove this contact?"
                                                           delegate:self
                                                  cancelButtonTitle:@"No"
                                                  otherButtonTitles:@"Yes", nil];
        [alertView show];
    }];
    
    [cell setSwipeGestureWithView:listView color:brownColor mode:MCSwipeTableViewCellModeNone state:MCSwipeTableViewCellState4 completionBlock:^(MCSwipeTableViewCell *cell, MCSwipeTableViewCellState state, MCSwipeTableViewCellMode mode) {
        NSLog(@"Did swipe \"List\" cell");
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    // No
    if (buttonIndex == 0) {
        [_cellToDelete swipeToOriginWithCompletion:^{
            NSLog(@"Swiped back");
        }];
        _cellToDelete = nil;
    }
    
    // Yes
    else {
        // Code to delete your cell.
        id data = [self deleteCell:self.cellToDelete];
        [self.sourceViewController.encounterDataSource addObject:data];
    }
}

@end
