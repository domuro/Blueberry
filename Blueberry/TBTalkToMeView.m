//
//  TBTalkToMeView.m
//  Blueberry
//
//  Created by Derek Omuro on 5/19/14.
//  Copyright (c) 2014 TeamBlueberry. All rights reserved.
//

#import "TBTalkToMeView.h"

@implementation TBTalkToMeView

- (id)initWithFrame:(CGRect)frame withText:(NSString*)text
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        int padding = 10;
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(padding, 0, frame.size.width-padding*2, 10)];
        [title setText:@"Talk to me about..."];
        [title setFont:[UIFont systemFontOfSize:12]];
        [title setTextColor:[UIColor lightGrayColor]];
        [title setTextAlignment:NSTextAlignmentCenter];
        [title sizeToFit];
        UILabel *content = [[UILabel alloc] initWithFrame:CGRectMake(padding, title.bounds.size.height, frame.size.width-padding*2, 0)];
        [content setText:text];
        [content setFont:[UIFont systemFontOfSize:18]];
        [content setTextColor:[UIColor blackColor]];
        [content setLineBreakMode:NSLineBreakByWordWrapping];
        [content setNumberOfLines:0];
        [content setTextAlignment:NSTextAlignmentCenter];
        [content sizeToFit];
        
        UIView *bottom = [[UIView alloc] initWithFrame:CGRectMake(padding, content.frame.origin.y+content.frame.size.height, frame.size.width-padding*2, 0.5)];
        [bottom setBackgroundColor:[UIColor lightGrayColor]];
        
        [self addSubview:title];
        [self addSubview:content];
        [self addSubview:bottom];
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
