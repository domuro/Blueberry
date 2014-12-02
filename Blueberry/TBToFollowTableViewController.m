//
//  TBToFollowListViewController.m
//  Blueberry
//
//  Created by Derek Omuro on 5/14/14.
//  Copyright (c) 2014 TeamBlueberry. All rights reserved.
//

#import "TBToFollowTableViewController.h"
#import "TBPerson.h"

@interface TBToFollowTableViewController ()

@end

@implementation TBToFollowTableViewController

UIImageView *sparky;
bool emailFromSwipe;
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(emailReport)]];
    //asdftai set this.
    self.tint = [UIColor colorWithRed:255/255. green:210/255. blue:76/255. alpha:1];
    int imageWidth = 168;
    int topInset = 100;
    sparky = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width / 2 - imageWidth / 2, self.view.bounds.size.height / 2 - imageWidth / 2 - topInset, imageWidth, imageWidth)];
//    [sparky setBackgroundColor:[UIColor orangeColor]];
    [sparky setImage:[UIImage imageNamed:@"sparky-success-circle.png"]];
    [sparky setAlpha:0];
    
    [self.view addSubview:sparky];
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if(!emailFromSwipe)
        [sparky setAlpha:0];
    emailFromSwipe = 0;
}

#pragma mark - UITableViewDataSource
- (void)configureCell:(MCSwipeTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [sparky setAlpha:0];

    UIView *checkView = [self viewWithImageName:@"linkedin"];
//    UIColor *greenColor = [UIColor colorWithRed:85.0 / 255.0 green:213.0 / 255.0 blue:80.0 / 255.0 alpha:1.0];
    UIColor *greenColor = [UIColor colorWithRed:156/255. green:230/255. blue:197/255. alpha:1];
//    UIColor *greenColor = [UIColor colorWithRed:159/255. green:231/255. blue:199/255. alpha:1];
//    UIColor *greenColor = [UIColor colorWithRed:163/255. green:232/255. blue:201/255. alpha:1];
//    UIColor *greenColor = [UIColor colorWithRed:111/255. green:219/255. blue:171/255. alpha:1];
//    UIColor *greenColor = [UIColor colorWithRed:132/255. green:224/255. blue:183/255. alpha:1];

    UIView *clockView = [self viewWithImageName:@"mail"];
    CGRect clockFrame = clockView.frame;
    clockFrame.origin.x -= 31;
    [clockView setFrame:clockFrame];


    UIView *crossView = [self viewWithImageName:@"cross"];
//    UIColor *redColor = [UIColor colorWithRed:232.0 / 255.0 green:61.0 / 255.0 blue:14.0 / 255.0 alpha:1.0];
    UIColor *redColor = [UIColor colorWithRed:74/255. green:209/255. blue:149/255. alpha:1];

    
//    UIColor *yellowColor = [UIColor colorWithRed:254.0 / 255.0 green:217.0 / 255.0 blue:56.0 / 255.0 alpha:1.0];
    UIColor *yellowColor = [UIColor colorWithRed:255/255. green:95/255. blue:92/255. alpha:1];
    
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
        [self.sourceViewController.contactDataSource addObject:pushData];
    }];
    
    [cell setSwipeGestureWithView:clockView color:redColor mode:MCSwipeTableViewCellModeExit state:MCSwipeTableViewCellState2 completionBlock:^(MCSwipeTableViewCell *cell, MCSwipeTableViewCellState state, MCSwipeTableViewCellMode mode) {
        NSLog(@"Did swipe \"Cross\" cell");
        
        [self deleteCellLong:cell];
    }];
    
    [cell setSwipeGestureWithView:crossView color:yellowColor mode:MCSwipeTableViewCellModeExit state:MCSwipeTableViewCellState3 completionBlock:^(MCSwipeTableViewCell *cell, MCSwipeTableViewCellState state, MCSwipeTableViewCellMode mode) {
        NSLog(@"Did swipe \"Clock\" cell");
        
        id pushData = [self deleteCell:cell];
        [self.sourceViewController.encounterDataSource addObject:pushData];
    }];
    
    [cell setSwipeGestureWithView:listView color:brownColor mode:MCSwipeTableViewCellModeNone state:MCSwipeTableViewCellState4 completionBlock:^(MCSwipeTableViewCell *cell, MCSwipeTableViewCellState state, MCSwipeTableViewCellMode mode) {
        NSLog(@"Did swipe \"List\" cell");
    }];
}

//left swipe (No image)
- (id)deleteCellLeft:(MCSwipeTableViewCell *)cell {
    NSParameterAssert(cell);
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    id data = [self.dataSource objectAtIndex:indexPath.row];
    [self.dataSource removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    return data;
}

//short swipe
- (id)deleteCell:(MCSwipeTableViewCell *)cell {
    NSParameterAssert(cell);
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    id data = [self.dataSource objectAtIndex:indexPath.row];
    [self.dataSource removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    if([self.dataSource count] == 0){
        [self sparkyAnimation];
    }
    return data;
}

//long swipe
MCSwipeTableViewCell *longSwipeCell;
- (id)deleteCellLong:(MCSwipeTableViewCell *)cell {
    NSParameterAssert(cell);
    longSwipeCell = cell;
    if ([MFMailComposeViewController canSendMail])
    {
        emailFromSwipe = 1;
        [self presentSingleEmailFollowup];
    }
    else{
        [self deleteCell:cell];
    }
    return nil;
}

- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    if(result == MFMailComposeResultSent){
        if (emailFromSwipe) {
            id pushData = [self deleteCell:longSwipeCell];
            [self.sourceViewController.contactDataSource addObject:pushData];
        }
    }
    else{
        if (emailFromSwipe){
            [self.tableView reloadData];
        }
    }
	[self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)sparkyAnimation{
    sparky.alpha = 0;
    [sparky setFrame:CGRectMake(self.view.bounds.size.width / 2 - 100 / 2, self.view.bounds.size.height / 2 - 100 / 2 - 100, 100, 100)];
    [UIView animateWithDuration:0.5 animations:^{
        sparky.alpha = 1;
        CGRect theFrame = sparky.frame;
        theFrame.size.height += 68;
        theFrame.size.width += 68;
        theFrame.origin.x -= 34;
        theFrame.origin.y -= 34;
        [sparky setFrame:theFrame];
    }];
}

- (void)emailReport {
    emailFromSwipe = 0;
    [super emailReport];
}

- (void)presentSingleEmailFollowup
{
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    
    // Set up email
    //Todo set this
    NSArray *toRecipients = @[[[self.dataSource objectAtIndex:[self.tableView indexPathForCell:longSwipeCell].row] email]];
    
    [picker setToRecipients:toRecipients];
    
    [self presentViewController:picker animated:YES completion:NULL];
}


@end
