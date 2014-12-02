//
//  TBEventViewController.m
//  Blueberry
//
//  Created by Derek Omuro on 5/14/14.
//  Copyright (c) 2014 TeamBlueberry. All rights reserved.
//

#import "TBEventSettingsViewController.h"
#import "UIViewController+MHSemiModal.h"
#import "TBProfilePreviewView.h"
#import "TBEventTextField.h"
#import "TBAppDelegate.h"
#import "INBeaconService.h"

@interface TBEventSettingsViewController ()

@end

@implementation TBEventSettingsViewController

int panicCount = 0;

TBEventTextField *eventName;
UIImageView *playButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.    
    int height = [self.view bounds].size.height;
    int width = [self.view bounds].size.width;

    //Todo segmented control to select full vs limited
    TBProfilePreviewView *ppv = [[TBProfilePreviewView alloc] initWithFrame:CGRectMake(0, height/8, width, height*3/16)];
    UITapGestureRecognizer *panicTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(panic)];
    [ppv setUserInteractionEnabled:YES];
    [ppv addGestureRecognizer:panicTap];
    
    UISegmentedControl *control = [[UISegmentedControl alloc] initWithItems:@[@"Full Profile", @"Limited Profile"]];
    [control setFrame:CGRectMake(width*3/32, ppv.frame.origin.y + ppv.frame.size.height+width/32, width*26/32, 25)];
    [control setTintColor:[UIColor whiteColor]];
    [control setSelectedSegmentIndex:0];
    [self.view addSubview:control];
    
    UILabel *eventHeader = [[UILabel alloc] initWithFrame:CGRectMake(16, height*15/32-21, width, 14)];
    [eventHeader setText:@"EVENT NAME"];
    [eventHeader setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:12]];
    [eventHeader setTextColor:[UIColor lightGrayColor]];
    
    eventName = [[TBEventTextField alloc] initWithFrame:CGRectMake(0, height*15/32, width, height/8)];
    [eventName setText:self.eventName];
    
    CGRect textRect = eventName.frame;
    textRect.origin.y += textRect.size.height;
    textRect.origin.x = width/32;
    textRect.size.height = 0.5;
    textRect.size.width = width*15/16;
    UIView *textUnderline = [[UIView alloc] initWithFrame:textRect];
    [textUnderline setBackgroundColor:[UIColor whiteColor]];
    
    //Todo add x image asdftai
    UIImageView *closeButton = [[UIImageView alloc] initWithFrame:CGRectMake(width/32, 20+width/32, 44, 44)];
    [closeButton setImage:[UIImage imageNamed:@"x.png"]];
    
    //Todo change back to closeButton
    UITapGestureRecognizer *closeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close)];
    [closeButton addGestureRecognizer:closeTap];
    [closeButton setUserInteractionEnabled:YES];

//    playButton = [[UIImageView alloc] initWithFrame:CGRectMake(width/2 - height*7/24/2, height*5/8+height/24, height*7/24, height*7/24)];
    int playWidth = height*8/24;
    int yCenter = textUnderline.frame.origin.y+(self.view.bounds.size.height - textUnderline.frame.origin.y)/2;
    playButton = [[UIImageView alloc] initWithFrame:CGRectMake(width/2 - playWidth/2, yCenter - playWidth/2, playWidth, playWidth)];
    //asdftai
    if([[INBeaconService singleton] isBroadcasting]){
//        [playButton setBackgroundColor:[UIColor redColor]];
        [playButton setImage:[UIImage imageNamed:@"stop-512-circle.png"]];
    }
    else{
//        [playButton setBackgroundColor:[UIColor greenColor]];
        [playButton setImage:[UIImage imageNamed:@"play-512-circle.png"]];
    }
    [self setRoundedView:playButton toDiameter:playButton.bounds.size.width];
    
    UITapGestureRecognizer *playTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeAndStartBluetooth)];
    [playButton addGestureRecognizer:playTap];
    [playButton setUserInteractionEnabled:YES];
    
    //For translucent blurry background
    self.view.opaque = NO;
    self.view.backgroundColor = [UIColor clearColor];
    UIToolbar *fakeToolbar = [[UIToolbar alloc] initWithFrame:self.view.bounds];
    fakeToolbar.autoresizingMask = self.view.autoresizingMask;
    fakeToolbar.barTintColor = [UIColor blackColor];
    [self.view insertSubview:fakeToolbar atIndex:0];
    
    //Add views to subview
    [self.view addSubview:closeButton];
    [self.view addSubview:ppv];
    [self.view addSubview:eventName];
    [self.view addSubview:eventHeader];
    [self.view addSubview:playButton];
    [self.view addSubview:textUnderline];
    
    //Keyboard resign first responder
    UITapGestureRecognizer *tapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dropKeyboard)];
    [self.view addGestureRecognizer:tapped];
}

-(void)setPlayButton:(BOOL)isPlaying{
    //asdftai analogous to above.
    if(isPlaying){
        //        [playButton setBackgroundColor:[UIColor redColor]];
        [playButton setImage:[UIImage imageNamed:@"stop-512-circle.png"]];
    }
    else{
        //        [playButton setBackgroundColor:[UIColor greenColor]];
        [playButton setImage:[UIImage imageNamed:@"play-512-circle.png"]];
    }
}

- (void)dropKeyboard
{
    [eventName resignFirstResponder];
}

- (void)close{
    panicCount = 0;
    [self setPlayButton:self.isPlaying];
    [self.sourceViewController.navigationBar setBarStyle:UIBarStyleDefault];
    [self.sourceViewController setEventName:eventName.text];
    [self.sourceViewController eventSettingsViewDismissed];
    //[self mh_dismissSemiModalViewController:self animated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)closeAndStartBluetooth{
    //Todo start bluetooth
    self.isPlaying = ![[INBeaconService singleton] isBroadcasting];
    [self.sourceViewController playTapped];
    [self close];
}

- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, [[UIScreen mainScreen] scale]);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

-(void)setRoundedView:(UIView *)roundedView toDiameter:(float)newSize;
{
    CGPoint saveCenter = roundedView.center;
    CGRect newFrame = CGRectMake(roundedView.frame.origin.x, roundedView.frame.origin.y, newSize, newSize);
    roundedView.frame = newFrame;
    roundedView.layer.cornerRadius = newSize / 2.0;
    roundedView.center = saveCenter;
}

-(void)panic
{
    panicCount++;
    if(panicCount >= 4){
        [(TBAppDelegate*)[[UIApplication sharedApplication] delegate] refreshTestData];
    }
}

@end
