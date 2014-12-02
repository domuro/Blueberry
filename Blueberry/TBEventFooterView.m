//
//  TBEventFooterView.m
//  Blueberry
//
//  Created by Derek Omuro on 5/14/14.
//  Copyright (c) 2014 TeamBlueberry. All rights reserved.
//

#import "TBEventFooterView.h"
#import "INBeaconService.h"

@interface TBEventFooterView ()

@end

@implementation TBEventFooterView

bool playFlag = 0;
UIImageView *play;
UILabel *title, *content;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setExclusiveTouch:YES];

        [self setBackgroundColor:[UIColor colorWithRed:245/255. green:245/255. blue:245/255. alpha:1]];
        
        play = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width/32, frame.size.height/16, frame.size.height*28/32, frame.size.height*28/32)];
//        [play setBackgroundColor:[UIColor greenColor]];
        [play setImage:[UIImage imageNamed:@"play-512.png"]];
        [self setRoundedView:play toDiameter:play.frame.size.width];
        
        title = [[UILabel alloc] initWithFrame:CGRectZero];
        if(self.eventName == nil || [self.eventName isEqualToString:@""]){
            [title setText:@"Tap to add event"];
        }
        else{
            [title setText:@"Currently attending"];
        }
        [title setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:16]];
        [title sizeToFit];
        [title setTextColor:[UIColor darkGrayColor]];
        
        content = [[UILabel alloc] initWithFrame:CGRectZero];
        [content setText:self.eventName];
        [content setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:24]];
        [content sizeToFit];
        
        int topMargin = (frame.size.height - title.frame.size.height - content.frame.size.height)/2;
//        int leftMargin = frame.size.width/32;
//        int leftInset = leftMargin + play.frame.size.width;
//        int remainingWidth = frame.size.width - leftInset;
        
//        [title setFrame:CGRectMake(leftInset + remainingWidth/2 - title.frame.size.width/2, topMargin, title.frame.size.width, title.frame.size.height)];
//        [content setFrame:CGRectMake(leftInset + remainingWidth/2 - content.frame.size.width/2, topMargin+title.frame.size.height, content.frame.size.width, content.frame.size.height)];
        [title setFrame:CGRectMake(0, topMargin, self.frame.size.width, title.frame.size.height)];
        [content setFrame:CGRectMake(0, topMargin+title.frame.size.height, self.frame.size.width, content.frame.size.height)];
        [title setTextAlignment:NSTextAlignmentCenter];
        [content setTextAlignment:NSTextAlignmentCenter];
        
        [self addSubview:title];
        [self addSubview:content];
        [self addSubview:play];
        
        UIGestureRecognizer *playTap = [[UIGestureRecognizer alloc] initWithTarget:self action:@selector(playTapped)];
        [self setUserInteractionEnabled:YES];
        [play setUserInteractionEnabled:YES];
        [play addGestureRecognizer:playTap];
    }
    return self;
}

-(void)refreshLabelsWithEventName:(NSString*)eventName
{
    if(self.eventName == nil || [self.eventName isEqualToString:@""]){
        [title setText:@"Tap to add event"];
    }
    else{
        [title setText:@"Currently attending"];
    }
    [title setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:16]];
    [title sizeToFit];
    [title setTextColor:[UIColor darkGrayColor]];
    
    [content setText:self.eventName];
    [content setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:24]];
    [content sizeToFit];
    
    CGRect frame = [self frame];
    int topMargin = (frame.size.height - title.frame.size.height - content.frame.size.height)/2;
//    int leftMargin = frame.size.width/32;
//    int leftInset = leftMargin + play.frame.size.width;
//    int remainingWidth = frame.size.width - leftInset;
    
//    [title setFrame:CGRectMake(leftInset + remainingWidth/2 - title.frame.size.width/2, topMargin, title.frame.size.width, title.frame.size.height)];
//    [content setFrame:CGRectMake(leftInset + remainingWidth/2 - content.frame.size.width/2, topMargin+title.frame.size.height, content.frame.size.width, content.frame.size.height)];
    
    [title setFrame:CGRectMake(0, topMargin, self.frame.size.width, title.frame.size.height)];
    [content setFrame:CGRectMake(0, topMargin+title.frame.size.height, self.frame.size.width, content.frame.size.height)];
    [title setTextAlignment:NSTextAlignmentCenter];
    [content setTextAlignment:NSTextAlignmentCenter];
    
    [title removeFromSuperview];
    [content removeFromSuperview];
    
    [self addSubview:title];
    [self addSubview:content];
}

-(void)playTapped
{
    //Start playing
    if(!playFlag){
//        [play setBackgroundColor:[UIColor redColor]];
        [play setImage:[UIImage imageNamed:@"stop-512.png"]];
        [[INBeaconService singleton] startDetecting];
        [[INBeaconService singleton] startBroadcasting];
        playFlag = 1;
    }
    
    //Stop playing
    else{
//        [play setBackgroundColor:[UIColor greenColor]];
        [play setImage:[UIImage imageNamed:@"play-512.png"]];
        [[INBeaconService singleton] stopBroadcasting];
        [[INBeaconService singleton] stopDetecting];
        playFlag = 0;
    }
}

-(void)setRoundedView:(UIView *)roundedView toDiameter:(float)newSize;
{
    CGPoint saveCenter = roundedView.center;
    CGRect newFrame = CGRectMake(roundedView.frame.origin.x, roundedView.frame.origin.y, newSize, newSize);
    roundedView.frame = newFrame;
    roundedView.layer.cornerRadius = newSize / 2.0;
    roundedView.center = saveCenter;
}

-(void) handleTap:(UITapGestureRecognizer *)recognizer
{
    CGPoint loc = [recognizer locationInView:self];
    if(CGRectContainsPoint(play.frame, loc)){
        [self playTapped];
    }
    else{
        [self.sourceViewController.navigationBar setBarStyle:UIBarStyleBlack];
        [self.sourceViewController.navigationBar setBarTintColor:[UIColor colorWithRed:245/255. green:245/255. blue:245/255. alpha:1]];
        [self.sourceViewController presentEventViewController:playFlag];
    }
}

@end
