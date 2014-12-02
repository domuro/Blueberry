//
//  TBProfilePreviewView.m
//  Blueberry
//
//  Created by Derek Omuro on 5/16/14.
//  Copyright (c) 2014 TeamBlueberry. All rights reserved.
//

#import "TBProfilePreviewView.h"
#import "TBAppDelegate.h"

@implementation TBProfilePreviewView

- (id)initWithFrame:(CGRect)frame
{
    TBPerson *myProfile;
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        //Todo fetch from disk... or not
        myProfile = [(TBAppDelegate*)[[UIApplication sharedApplication] delegate] myProfile];
//        [myProfile setProfileImage:[UIImage imageNamed:@"sampleprofile.jpg"]];
//        [myProfile setName:@"Derek Omuro"];
//        [myProfile setCompany:@"Apple, Inc."];
//        [myProfile setTitle:@"Web Development Intern"];
//        [myProfile setEmail:@"derek.omuro@gmail.com"];
//        [myProfile setIndustry:@"Mobile Applications"];
//        [myProfile setTalkToMe:@"rapid prototyping and design of mobile applications"];
//        [myProfile setWork:@"408-718-8401"];
//        [myProfile setCell:@"408-123-1234"];
//        [myProfile setFax:@"408-234-5555"];
//        [myProfile setLinkedInID:@"LinkedIn ID"];
//        [myProfile setTwitterID:@"Twitter ID"];
//        [myProfile setWebsite:@"domuro.com"];
//        [myProfile setAddress:[TBAddress sampleAddress]];

        int height = [self bounds].size.height;
        int width = [self bounds].size.width;
        
        //Profile image
        UIImageView *profilePic = [[UIImageView alloc] initWithFrame:CGRectMake(width/32, width/32, height-width*2/32, height-width*2/32)];
        [self setRoundedView:profilePic toDiameter:profilePic.bounds.size.width];
        [profilePic setClipsToBounds:YES];
        [profilePic setImage:[myProfile profileImage]];
        
        int labelTopMargin = height*3/32;
        int labelHeight = (profilePic.bounds.size.height-labelTopMargin*2)/3;
        int yPos = profilePic.frame.origin.y + labelTopMargin;
        int xPos = profilePic.frame.origin.x + profilePic.frame.size.width + width/32;
        
        UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(xPos, yPos, width-xPos, labelHeight)];
        [name setText:[myProfile name]];
        [name setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:20]];
        [name setTextColor:[UIColor whiteColor]];
        yPos += labelHeight;
        
        UILabel *position = [[UILabel alloc] initWithFrame:CGRectMake(xPos, yPos, width-xPos, labelHeight)];
        [position setText:[myProfile title]];
        [position setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:14]];
        [position setTextColor:[UIColor whiteColor]];
        yPos += labelHeight;
        
        UILabel *company = [[UILabel alloc] initWithFrame:CGRectMake(xPos, yPos, width-xPos, labelHeight)];
        [company setText:[myProfile company]];
        [company setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:14]];
        [company setTextColor:[UIColor whiteColor]];
        yPos += labelHeight + width*2/32;
            
        [self addSubview:profilePic];
        [self addSubview:name];
        [self addSubview:position];
        [self addSubview:company];
        
//        [name sizeToFit];
//        [position sizeToFit];
//        [company sizeToFit];
//        
//        int x = profilePic.frame.origin.x;
//        int y = profilePic.frame.origin.y;
//        int w = name.bounds.size.width;
//        if(position.bounds.size.width > w)
//            w = position.bounds.size.width;
//        else if(company.bounds.size.width > w)
//            w = company.bounds.size.width;
//        width += profilePic.bounds.size.width;// + profilePic.frame.origin.x*2; //for spacing between and right padding.
//        int h = profilePic.frame.origin.y*2 + profilePic.frame.size.height;
//        
//        [self setFrame:CGRectMake(x, y, w, h)];
    }
    return self;
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
