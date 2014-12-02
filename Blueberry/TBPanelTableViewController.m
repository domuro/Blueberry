//
//  TBPanelTableViewController.m
//  Blueberry
//
//  Created by Derek Omuro on 5/16/14.
//  Copyright (c) 2014 TeamBlueberry. All rights reserved.
//

#import "TBPanelTableViewController.h"
#import "TBPerson.h"
#import "TBProfileViewController.h"
#import "TBNavigationController.h"
#import "TBAppDelegate.h"

@interface TBPanelTableViewController ()

@end

@implementation TBPanelTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.dataSource = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    CGRect rect = [self.view frame];
    rect.size.height -= 64; //for bottom bar.
    
    [self.tableView setFrame:rect];
}

//todo bug: start swiping back, cancelling, then swiping back doesnt animate deselect
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSIndexPath *tableSelection = [self.tableView indexPathForSelectedRow];
    //todo swipe back row should be animated.
    [self.tableView deselectRowAtIndexPath:tableSelection animated:NO];
    
    [self.navigationItem.rightBarButtonItem setTintColor:self.tint];
    [self.navigationItem.leftBarButtonItem setTintColor:self.tint];
    [self.sourceViewController setTint:self.tint];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationItem setTitleView:self.navigationHeader];
    [self.tableView setMultipleTouchEnabled:NO];
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:[self.view bounds]];
    UIColor *backgroundColor = [UIColor colorWithRed:227.0 / 255.0 green:227.0 / 255.0 blue:227.0 / 255.0 alpha:1.0];
    [backgroundView setBackgroundColor:backgroundColor];
    [self.tableView setBackgroundView:backgroundView];
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
//    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"contact.png"]  style:UIBarButtonItemStylePlain target:self action:@selector(hamburger)]];
//    UIImageView *hamburgerButton = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
//    [hamburgerButton setImage:[UIImage imageNamed:@"contact.png"]];
//    [hamburgerButton setContentMode:UIViewContentModeScaleAspectFit];
    
//    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:hamburgerButton]];
//    UIImage *hamburgerImage = [UIImage imageNamed:@"check.png"];
//    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithImage:hamburgerImage style:UIBarButtonItemStylePlain target:self action:@selector(hamburger)]];
}

//Todo
- (void)hamburger{
    NSLog(@"asdf");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    MCSwipeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[MCSwipeTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
        // iOS 7 separator
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            cell.separatorInset = UIEdgeInsetsZero;
        }
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }
    cell.secondTrigger = 0.60;
    [self configureCell:cell forRowAtIndexPath:indexPath];
    return cell;
}

#pragma mark - UITableViewDataSource
- (void)configureCell:(MCSwipeTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //implemented in 3 panels.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70.0;
}


#pragma mark - MCSwipeTableViewCellDelegate
//NSMutableArray *originalData;
// When the user starts swiping the cell this method is called
//Todo (bug) disable changing view while swiping
- (void)swipeTableViewCellDidStartSwiping:(MCSwipeTableViewCell *)cell {
    // NSLog(@"Did start swiping the cell!");
    self.isCellSliding = 1;
}

// When the user ends swiping the cell this method is called
- (void)swipeTableViewCellDidEndSwiping:(MCSwipeTableViewCell *)cell {
    // NSLog(@"Did end swiping the cell!");
    self.isCellSliding = 0;
}

// When the user is dragging, this method is called and return the dragged percentage from the border
- (void)swipeTableViewCell:(MCSwipeTableViewCell *)cell didSwipeWithPercentage:(CGFloat)percentage {
    // NSLog(@"Did swipe with percentage : %f", percentage);
}
#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TBProfileViewController *profileViewController = [[TBProfileViewController alloc] initWithPerson:[_dataSource objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:profileViewController animated:YES];
}

#pragma mark - Utils
- (void)reload:(id)sender {
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
}

- (id)deleteCell:(MCSwipeTableViewCell *)cell {
    NSParameterAssert(cell);
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    id data = [_dataSource objectAtIndex:indexPath.row];
    [_dataSource removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    return data;
}

- (UIView *)viewWithImageName:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.contentMode = UIViewContentModeCenter;
    return imageView;
}

- (void)emailReport {
    if ([MFMailComposeViewController canSendMail])
    {
        [self displayMailComposerSheet];
    }
}

//Email report
- (void)displayMailComposerSheet
{
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    
    // Set up email
    //Todo set this
    
    NSArray *toRecipients = @[[[(TBAppDelegate*)[[UIApplication sharedApplication] delegate] myProfile] email]];
    [picker setToRecipients:toRecipients];
    [picker setSubject:[NSString stringWithFormat:@"Sparks at %@", [self.sourceViewController eventName]]];
    
    
    NSString *email = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"emailTemplate" ofType:@"html"] encoding:NSUTF8StringEncoding error:nil];
    NSString *card = [[NSMutableString alloc] init];
    card = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cardTest" ofType:@"html"] encoding:NSUTF8StringEncoding error:nil];

    [picker setMessageBody:[NSString stringWithFormat:email, card] isHTML:YES];
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	[self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller
                 didFinishWithResult:(MessageComposeResult)result
{
	[self dismissViewControllerAnimated:YES completion:NULL];
}

@end
