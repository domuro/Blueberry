//
//  TBNavigationViewController.m
//  Blueberry
//
//  Created by Derek Omuro on 5/14/14.
//  Copyright (c) 2014 TeamBlueberry. All rights reserved.
//

#import "TBNavigationViewController.h"
#import "TBEventFooterView.h"
#import "TBNavigationView.h"
#import "TBEncounterListViewController.h"
#import "TBToFollowListViewController.h"
#import "TBContactListViewController.h"

@interface TBNavigationViewController ()

@end

@implementation TBNavigationViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGSize size = self.view.bounds.size;
    int footerHeight = 64;
    
    UIView *border = [[UIView alloc] initWithFrame:CGRectMake(0, size.height-footerHeight, size.width, 0.5)];
    [border setBackgroundColor:[UIColor lightGrayColor]];
    
    TBEventFooterView *efv = [[TBEventFooterView alloc] initWithFrame:CGRectMake(0, size.height - footerHeight, size.width, footerHeight)];
    efv.sourceViewController = self;
    
    //Todo move nav control up with modal
    TBNavigationView *nv = [[TBNavigationView alloc] initWithFrame:CGRectMake(size.width/3, 20+8, size.width/3, 44-16)];
    nv.sourceViewController = self;
    
    [self.view addSubview:nv];
    [self.view addSubview:efv];
    [self.view addSubview:border];
}

- (void)updateViewController:(NSInteger) selectedSegment
{
    TBEncounterListViewController *elvc =  [[TBEncounterListViewController alloc] init];
    TBToFollowListViewController *tflvc =  [[TBToFollowListViewController alloc] init];
    TBContactListViewController *clvc =  [[TBContactListViewController alloc] init];

    switch (selectedSegment) {
        case 0:
            [self setViewControllers:@[elvc] animated:NO];
            break;
        case 1:
            [self setViewControllers:@[tflvc] animated:NO];
            break;
        case 2:
            [self setViewControllers:@[clvc] animated:NO];
            break;
        default:
            break;
    }
}

@end
