//
//  TBProfileViewController.m
//  Blueberry
//
//  Created by Derek Omuro on 5/16/14.
//  Copyright (c) 2014 TeamBlueberry. All rights reserved.
//

#import "TBProfileViewController.h"
#import "TBNavigationController.h"
#import "TBProfileLabel.h"
#import "TBAddressLabel.h"
#import "TBSocialButtonsView.h"
#import "TBTalkToMeView.h"

@interface TBProfileViewController ()

@end

@implementation TBProfileViewController
- (id)initWithPerson: (TBPerson *) person
{
    self = [super init];
    if (self) {
        self.person = person;
        [self.navigationItem setTitle:[person name]];
    }
    return self;
}

UIScrollView *mainView;
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    mainView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self setupScrollView];

    [self.view addSubview:mainView];
}

- (void) setupScrollView
{
    int width = self.view.bounds.size.width;
    int labelHeight = 40;
    int separationMargin = 20;
    int labelMargin = 4;
    int yPos = 0;
    
    //Profile image
    UIImageView *profile = [[UIImageView alloc] initWithFrame:CGRectMake(width/2 - width*5/16/2, width*2/32, width*5/16, width*5/16)];

    [self setRoundedView:profile toDiameter:profile.bounds.size.width];
    [profile setImage:[self.person profileImage]];
    [profile setClipsToBounds:YES];
    yPos = profile.frame.origin.y + profile.frame.size.height + profile.frame.size.height/32;
    
    CGRect ringRect = profile.frame;
    float ringSize = 0.5;
    ringRect.origin.x -= ringSize;
    ringRect.origin.y -= ringSize;
    ringRect.size.width += ringSize*2;
    ringRect.size.height += ringSize*2;
    UIView *grayRing = [[UIView alloc] initWithFrame:ringRect];
    [grayRing setBackgroundColor:[UIColor lightGrayColor]];
    [self setRoundedView:grayRing toDiameter:ringRect.size.width];
    
    //Name
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(0, yPos, 0, 0)];
    [name setTextAlignment:NSTextAlignmentCenter];
    [name setText:[self.person name]];
    [name setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:24]];
    [name setTextColor:[UIColor blackColor]];
    [name sizeToFit];
    [name setFrame:CGRectMake(width/2 - name.frame.size.width/2, name.frame.origin.y, name.frame.size.width, name.frame.size.height)];
    yPos = name.frame.origin.y + name.frame.size.height;
    
    //Company and Position
    UILabel *job = [[UILabel alloc] initWithFrame:CGRectMake(0, yPos, 0, 0)];
    [job setTextAlignment:NSTextAlignmentCenter];
    [job setText:[NSString stringWithFormat:@"%@ at %@", [self.person title], [self.person company]]];
    [job setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:13]];
    [job setTextColor:[UIColor lightGrayColor]];
    [job sizeToFit];
    [job setFrame:CGRectMake(width/2 - job.frame.size.width/2, job.frame.origin.y, job.frame.size.width, job.frame.size.height)];
    yPos = job.frame.origin.y + job.frame.size.height + width*2/32;// +labelMargin;
    
    //add underline
    UIView *leftUnderline = [[UIView alloc] initWithFrame:CGRectMake(width*3/32-width/64-2, yPos, (width-5*(width/16))/2+3, 1)];
    [leftUnderline setBackgroundColor:[UIColor lightGrayColor]];
    
    UIView *rightUnderline = [[UIView alloc] initWithFrame:CGRectMake((width-5*(width/16))/2+width/16*4-width/32+width/64-1, yPos, (width-5*(width/16))/2+3, 1)];
    [rightUnderline setBackgroundColor:[UIColor lightGrayColor]];
    
    UILabel *emoji = [[UILabel alloc] initWithFrame:CGRectMake(0, yPos-32, width, 64)];
    [emoji setTextAlignment:NSTextAlignmentCenter];
    [emoji setText:@"⚡️"];
    [emoji setFont:[UIFont systemFontOfSize:27]];
    
    yPos += width*2/32;
    
    [mainView addSubview:emoji];
    [mainView addSubview:leftUnderline];
    [mainView addSubview:rightUnderline];
    
    //Add social buttons
//    yPos += labelMargin*2;
//    TBSocialButtonsView *socialButtons = [[TBSocialButtonsView alloc] initWithFrame:CGRectMake(0, yPos, width, labelHeight) withEmail:[self.person email] withLinkedInID:[self.person linkedInID] withTwitterID:[self.person twitterID]];
//    [socialButtons setFrame:CGRectMake(width/2-socialButtons.bounds.size.width/2, yPos, socialButtons.bounds.size.width, socialButtons.bounds.size.height)];
//    yPos = socialButtons.frame.origin.y + socialButtons.frame.size.height +labelMargin*4;
    
    //Email
    TBProfileLabel *email = [[TBProfileLabel alloc] initWithFrame:CGRectMake(0, yPos, width, labelHeight) withTitle:@"Email" withText:[self.person email]];
    yPos = email.frame.origin.y + email.frame.size.height + labelMargin;
    email.sourceViewController = self;
    
    //Website
    if([self.person website] != nil && ![self.person.website isEqualToString:@""]){
        TBProfileLabel *website = [[TBProfileLabel alloc] initWithFrame:CGRectMake(0, yPos, width, labelHeight) withTitle:@"Website" withText:[self.person website]];
        [mainView addSubview:website];
        yPos = website.frame.origin.y + website.frame.size.height + labelMargin;
    }
    yPos += separationMargin - labelMargin;
    
    bool phoneFlag = 0;
    //Work phone
    if ([self.person work] != nil && ![self.person.work isEqualToString:@""]) {
        TBProfileLabel *work = [[TBProfileLabel alloc] initWithFrame:CGRectMake(0, yPos, width, labelHeight) withTitle:@"Work" withText:[self.person work]];
        [mainView addSubview:work];
        yPos = work.frame.origin.y + work.frame.size.height + labelMargin;
        phoneFlag = 1;
    }
    
    //Cell phone
    if ([self.person cell] != nil && ![self.person.cell isEqualToString:@""]) {
        TBProfileLabel *cell = [[TBProfileLabel alloc] initWithFrame:CGRectMake(0, yPos, width, labelHeight) withTitle:@"Cell" withText:[self.person cell]];
        [mainView addSubview:cell];
        yPos = cell.frame.origin.y + cell.frame.size.height + labelMargin;
        phoneFlag = 1;
    }
    
    //Fax
    if ([self.person fax] != nil && ![self.person.fax isEqualToString:@""]) {
        TBProfileLabel *fax = [[TBProfileLabel alloc] initWithFrame:CGRectMake(0, yPos, width, labelHeight) withTitle:@"Fax" withText:[self.person fax]];
        [mainView addSubview:fax];
        yPos = fax.frame.origin.y + fax.frame.size.height + labelMargin;
        phoneFlag = 1;
    }
    if(phoneFlag)
        yPos += separationMargin - labelMargin;
    
    bool addrFlag = 0;
    //Address
    if ([self.person address] != nil) {
//        TBAddressLabel *addr = [[TBAddressLabel alloc] initWithFrame:CGRectMake(0, yPos, width, labelHeight*3) withAddress:[self.person address]];
        TBAddress *a = [self.person address];
        NSString *text = [NSString stringWithFormat:@"%@\n%@ %@ %@\n%@", [a street], [a city], [a state], [a zip], [a country]];
        TBProfileLabel *addr = [[TBProfileLabel alloc] initWithFrame:CGRectMake(0, yPos, width, labelHeight*2) withTitle:@"Work\nAddress" withText:text];
        [mainView addSubview:addr];
        yPos = addr.frame.origin.y + addr.frame.size.height + labelMargin;
        addrFlag = 1;
    }
    
    if(addrFlag)
        yPos += separationMargin - labelMargin;
    
    [mainView addSubview:grayRing];
    [mainView addSubview:profile];
    [mainView addSubview:name];
    [mainView addSubview:job];
//    [mainView addSubview:socialButtons];
    [mainView addSubview:email];
    
    [mainView setContentSize:CGSizeMake(self.view.bounds.size.width, 64+yPos)];
}

-(void)setRoundedView:(UIView *)roundedView toDiameter:(float)newSize;
{
    CGPoint saveCenter = roundedView.center;
    CGRect newFrame = CGRectMake(roundedView.frame.origin.x, roundedView.frame.origin.y, newSize, newSize);
    roundedView.frame = newFrame;
    roundedView.layer.cornerRadius = newSize / 2.0;
    roundedView.center = saveCenter;
}

@end
