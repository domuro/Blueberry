//
//  TBNavigationViewController.m
//  Blueberry
//
//  Created by Derek Omuro on 5/14/14.
//  Copyright (c) 2014 TeamBlueberry. All rights reserved.
//

#import "TBNavigationController.h"
#import "UIViewController+MHSemiModal.h"
#import "TBEventFooterView.h"
#import "TBNavigationHeaderView.h"

#import "TBEncounterTableViewController.h"
#import "TBToFollowTableViewController.h"
#import "TBContactTableViewController.h"
#import "TBEventSettingsViewController.h"

#import "TBEncounterManager.h"
#import "TBPriority.h"
#import "TBUserInformationCache.h"
#import "TBPerson.h"
#import "TBAddress.h"

#import "SemiModalAnimatedTransition.h"


@interface TBNavigationController ()

@end

@implementation TBNavigationController
@synthesize eventName;
static const int footerHeight = 64;
bool eventDisplayed;
TBEncounterTableViewController *encounterTableVC;
TBToFollowTableViewController *toFollowTableVC;
TBContactTableViewController *contactTableVC;
TBEventSettingsViewController *eventSettingsVC;
TBEventFooterView *eventFooter;
- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        //CGRect excluding footer
        CGRect rect = [self.view bounds];
        rect.size.height -= footerHeight;
        
        navHeader = [[TBNavigationHeaderView alloc] initWithFrame:CGRectMake(0, 0, 160, 30)];
        navHeader.sourceViewController = self;
        
        encounterTableVC =  [[TBEncounterTableViewController alloc] initWithStyle:UITableViewStylePlain];
        encounterTableVC.sourceViewController = self;
        encounterTableVC.dataSource = self.encounterDataSource;
        encounterTableVC.navigationHeader = navHeader;
        
        toFollowTableVC =  [[TBToFollowTableViewController alloc] initWithStyle:UITableViewStylePlain];
        toFollowTableVC.sourceViewController = self;
        toFollowTableVC.dataSource = self.toFollowDataSource;
        toFollowTableVC.navigationHeader = navHeader;
        
        contactTableVC =  [[TBContactTableViewController alloc] initWithStyle:UITableViewStylePlain];
        contactTableVC.sourceViewController = self;
        contactTableVC.dataSource = self.contactDataSource;
        contactTableVC.navigationHeader = navHeader;
        
        eventSettingsVC = [[TBEventSettingsViewController alloc] init];
        eventSettingsVC.sourceViewController = self;
        
        [self setViewControllers:@[encounterTableVC] animated:NO];
    }
    return self;
}

TBNavigationHeaderView *navHeader;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.

    
    self.encounterDataSource = [[NSMutableArray alloc] init];
    self.toFollowDataSource = [[NSMutableArray alloc] init];
    self.contactDataSource = [[NSMutableArray alloc] init];
    
    [self.view setBackgroundColor:[UIColor colorWithRed:227/255. green:225/255. blue:227/255. alpha:1]];
    
    //Todo populate from somewhere???
    eventName = @"";
    
    CGSize size = self.view.bounds.size;
    
    UIView *border = [[UIView alloc] initWithFrame:CGRectMake(0, size.height-footerHeight-0.5, size.width, 0.5)];
    [border setBackgroundColor:[UIColor lightGrayColor]];
    
    eventFooter = [[TBEventFooterView alloc] initWithFrame:CGRectMake(0, size.height - footerHeight, size.width, footerHeight)];
    [eventFooter setSourceViewController:self];
    UITapGestureRecognizer *footerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(footerTapped:)];
    [eventFooter addGestureRecognizer:footerTap];
    
//    //Todo pull this server and store in memory? TESTING
//    TBEncounterManager *encounterManager = [TBEncounterManager sharedManager];
//    TBPriority *priority;
//    for (int i = 1; i < 26; i++){
//        priority = [encounterManager.interactions objectForKey:[NSNumber numberWithInt:i]];
//        if(priority == nil){
//            priority = [[TBPriority alloc] init];
//        }
//        [encounterManager.interactions setObject:priority forKey:[NSNumber numberWithInt:i]];
//        
//        //Bluetooth pulse received.  for testing purposes.
//        for (int j = 0; j <= i; j++){
//            [priority ping];
//        }
//    }
//    
//    //Descending sort on priority.
//    NSArray *prioritizedIDs;
//    prioritizedIDs = [encounterManager.interactions keysSortedByValueUsingComparator: ^(id obj1, id obj2) {
//        
//        if ([(TBPriority*)obj1 priority] < [(TBPriority*)obj2 priority]) {
//            
//            return (NSComparisonResult)NSOrderedDescending;
//        }
//        if ([(TBPriority*)obj1 priority] > [(TBPriority*)obj2 priority]) {
//            
//            return (NSComparisonResult)NSOrderedAscending;
//        }
//        
//        return (NSComparisonResult)NSOrderedSame;
//    }];
//    
//    //Todo fetch this from server.
//    //    NSNumber *selectedEventID =
//    TBUserInformationCache *userCache = [TBUserInformationCache sharedManager];
//    TBPerson *person;
//    for (int i = 1; i < 26; i++){
//        person = [userCache.cache objectForKey:[NSNumber numberWithInt:i]];
//        if(person == nil){
//            person = [[TBPerson alloc] init];
//            [person importFrom:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"person-%d", i] ofType:@"plist"]];
//
//        }
//        [userCache.cache setObject:person forKey:[NSNumber numberWithInt:i]];
//    }
//    
//    for(NSNumber *userID in prioritizedIDs)
//    {
//        //        NSLog(@"%@", [[[userCache cache] objectForKey:userID] name]);
//        [self.encounterDataSource addObject:[[userCache cache] objectForKey:userID]];
//    }
//    
//    //Todo select event, and query for user ids associated with this event.
//    //Todo get user information for each user id associated with this event.m
    [eventFooter setEventName:eventName];
    
//    [self.view addSubview:navHeader];
    [self.view addSubview:eventFooter];
    [self.view addSubview:border];
}

- (void)footerTapped:(UITapGestureRecognizer *)recognizer
{
    //Todo (bug) can tap status bar from footerView, causing tableView to scroll.
    [eventFooter handleTap:recognizer];
}

//Todo animation left.
int currentVC = 0;
bool encounterTableIsActive = 1;
- (void)updateViewController:(NSInteger) selectedSegment
{
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    
    // get the view that's currently showing
	UIView *currentView = [[self.viewControllers lastObject] view];
	// get the the underlying UIWindow, or the view containing the current view view
	UIView *theWindow = [currentView superview];
    
	// remove the current view and replace with myView1
	[currentView removeFromSuperview];
    encounterTableIsActive = 0;
    switch (selectedSegment) {
        case 0:
            [self setViewControllers:@[encounterTableVC] animated:NO];
            [theWindow addSubview:[[self.viewControllers lastObject] view]];
            [encounterTableVC.tableView reloadData];
            encounterTableIsActive = 1;
            break;
        case 1:
            [self setViewControllers:@[toFollowTableVC] animated:NO];
            [theWindow addSubview:[[self.viewControllers lastObject] view]];
            [toFollowTableVC.tableView reloadData];
            break;
        case 2:
            [self setViewControllers:@[contactTableVC] animated:NO];
            [theWindow addSubview:[[self.viewControllers lastObject] view]];
            [contactTableVC.tableView reloadData];
            break;
        default:
            break;
    }
    // set up an animation for the transition between the views
	CATransition *animation = [CATransition animation];
	[animation setDuration:0.35];
	[animation setType:kCATransitionPush];
    (selectedSegment < currentVC)?[animation setSubtype:kCATransitionFromLeft]:[animation setSubtype:kCATransitionFromRight];
	[animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
	[[theWindow layer] addAnimation:animation forKey:nil];
    
    currentVC = (int)selectedSegment;
}

- (void) pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
}

- (void)presentEventViewController:(BOOL)isPlaying
{
    if(!((TBPanelTableViewController*)self.viewControllers[0]).isCellSliding)
    {
        eventDisplayed = 1;
        [eventSettingsVC setPlayButton:isPlaying];
        [eventSettingsVC setIsPlaying:isPlaying];
        [eventSettingsVC setEventName:eventName];
        eventSettingsVC.modalPresentationStyle = UIModalPresentationCustom;
        eventSettingsVC.transitioningDelegate = self;
        [[self topViewController] presentViewController:eventSettingsVC animated:YES completion:nil];
        //[self mh_presentSemiModalViewController:eventSettingsVC animated:YES];
    }
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    SemiModalAnimatedTransition *semiModalAnimatedTransition = [[SemiModalAnimatedTransition alloc] init];
    semiModalAnimatedTransition.presenting = YES;
    return semiModalAnimatedTransition;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    SemiModalAnimatedTransition *semiModalAnimatedTransition = [[SemiModalAnimatedTransition alloc] init];
    return semiModalAnimatedTransition;
}

-(void)playTapped
{
    [eventFooter playTapped];
}
- (void)eventSettingsViewDismissed
{
    eventDisplayed = 0;
    [eventFooter setEventName:eventName];
    [eventFooter refreshLabelsWithEventName:eventName];
}

- (void)updateDataSource
{
    if(encounterTableIsActive && !([encounterTableVC.tableView isTracking] || [encounterTableVC isCellSliding])){
        TBEncounterManager *encounterManager = [TBEncounterManager sharedManager];
        TBUserInformationCache *userCache = [TBUserInformationCache sharedManager];
        
        [self.encounterDataSource removeAllObjects];
        
        NSArray *prioritizedIDs;
        prioritizedIDs = [encounterManager.interactions keysSortedByValueUsingComparator: ^(id obj1, id obj2) {
            if ([(TBPriority*)obj1 priority] < [(TBPriority*)obj2 priority]) {
                return (NSComparisonResult)NSOrderedDescending;
            }
            if ([(TBPriority*)obj1 priority] > [(TBPriority*)obj2 priority]) {
                return (NSComparisonResult)NSOrderedAscending;
            }
            return (NSComparisonResult)NSOrderedSame;
        }];
        
        for(NSNumber *userID in prioritizedIDs)
        {
            TBPerson *user = [[userCache cache] objectForKey:userID];
            
            //dont update user if user is in a different panel
            if(!([self.toFollowDataSource containsObject:user] || [self.contactDataSource containsObject:user])){
                [self.encounterDataSource addObject:[[userCache cache] objectForKey:userID]];
            }
        }
        [encounterTableVC.tableView reloadData];
    }
}

//todo
- (void) setTint:(UIColor *)color
{
    [navHeader.control setTintColor:color];
}

- (void) updateName
{
    [eventFooter setEventName:eventName];
}

- (void)panicUpdate
{
    TBEncounterManager *encounterManager = [TBEncounterManager sharedManager];
    TBUserInformationCache *userCache = [TBUserInformationCache sharedManager];
    
    [self.encounterDataSource removeAllObjects];
    
    NSArray *prioritizedIDs;
    prioritizedIDs = [encounterManager.interactions keysSortedByValueUsingComparator: ^(id obj1, id obj2) {
        if ([(TBPriority*)obj1 priority] < [(TBPriority*)obj2 priority]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        if ([(TBPriority*)obj1 priority] > [(TBPriority*)obj2 priority]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
    
    for(NSNumber *userID in prioritizedIDs)
    {
        TBPerson *user = [[userCache cache] objectForKey:userID];
        
        //dont update user if user is in a different panel
        if(!([self.toFollowDataSource containsObject:user] || [self.contactDataSource containsObject:user])){
            [self.encounterDataSource addObject:[[userCache cache] objectForKey:userID]];
        }
    }
    
    [encounterTableVC.tableView reloadData];
    [toFollowTableVC.tableView reloadData];
    [contactTableVC.tableView reloadData];
}

@end
