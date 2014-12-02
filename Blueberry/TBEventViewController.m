//
//  TBEventViewController.m
//  Blueberry
//
//  Created by Derek Omuro on 5/14/14.
//  Copyright (c) 2014 TeamBlueberry. All rights reserved.
//

#import "TBEventViewController.h"
#import "TBProfilePreviewView.h"
#import "TBEventTextField.h"

@interface TBEventViewController ()

@end

@implementation TBEventViewController

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
    [self.view setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]];

    int height = [self.view bounds].size.height;
    int width = [self.view bounds].size.width;
    
    TBProfilePreviewView *ppv = [[TBProfilePreviewView alloc] initWithFrame:CGRectMake(0, height/8, width, height*2/8)];
    
    //Todo create view
    UILabel *eventHeader = [[UILabel alloc] initWithFrame:CGRectMake(16, height*4/8-21, width, 14)];
    [eventHeader setText:@"EVENT NAME"];
    [eventHeader setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:12]];
    [eventHeader setTextColor:[UIColor lightGrayColor]];
    
    TBEventTextField *eventName = [[TBEventTextField alloc] initWithFrame:CGRectMake(0, height*4/8, width, height/8)];
    [eventName setText:@"Butterworth"];
    //Todo add x image
    UIImageView *closeButton = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, height/8/2, height/8/2)];
    [closeButton setBackgroundColor:[UIColor orangeColor]];
    
    UITapGestureRecognizer *closeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close)];
    [closeButton addGestureRecognizer:closeTap];
    [closeButton setUserInteractionEnabled:YES];
    
    [self.view addSubview:closeButton];
    [self.view addSubview:ppv];
    [self.view addSubview:eventName];
    [self.view addSubview:eventHeader];
}

- (void)close{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}
@end
