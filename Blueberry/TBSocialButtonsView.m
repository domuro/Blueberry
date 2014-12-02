//
//  TBSocialButtonsView.m
//  Blueberry
//
//  Created by Derek Omuro on 5/19/14.
//  Copyright (c) 2014 TeamBlueberry. All rights reserved.
//

#import "TBSocialButtonsView.h"

@implementation TBSocialButtonsView

- (id)initWithFrame:(CGRect)frame withEmail: (NSString*) email withLinkedInID: (NSString*) linkedInID withTwitterID: (NSString*) twitterID
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        int buttonWidth = frame.size.width/6;
        int xPos = 0;
        
        //Todo social media buttons asdftai
        //Set "contact.png" to the correct image
        UIImageView *mailIcon = [[UIImageView alloc] initWithFrame:CGRectMake(xPos, 0, buttonWidth, frame.size.height)];
        xPos += buttonWidth;
        [mailIcon setImage:[UIImage imageNamed:@"contact.png"]];
        [mailIcon setContentMode:UIViewContentModeScaleAspectFit];
        [self addSubview:mailIcon];
        
        if(linkedInID != nil){
            UIImageView *linkedInButton = [[UIImageView alloc] initWithFrame:CGRectMake(xPos, 0, buttonWidth, frame.size.height)];
            xPos += buttonWidth;
            [linkedInButton setImage:[UIImage imageNamed:@"contact.png"]];
            [linkedInButton setContentMode:UIViewContentModeScaleAspectFit];
            [self addSubview:linkedInButton];
        }
        
        if(twitterID != nil){
            UIImageView *twitterButton = [[UIImageView alloc] initWithFrame:CGRectMake(xPos, 0, buttonWidth, frame.size.height)];
            xPos += buttonWidth;
            [twitterButton setImage:[UIImage imageNamed:@"contact.png"]];
            [twitterButton setContentMode:UIViewContentModeScaleAspectFit];
            [self addSubview:twitterButton];
        }
        [self setFrame:CGRectMake(frame.size.width/2 - xPos/2, frame.origin.y, xPos, frame.size.height)];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
