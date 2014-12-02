//
//  TBAddressLabel.m
//  Blueberry
//
//  Created by Derek Omuro on 5/19/14.
//  Copyright (c) 2014 TeamBlueberry. All rights reserved.
//

#import "TBAddressLabel.h"

@implementation TBAddressLabel

- (id)initWithFrame:(CGRect)frame withAddress:(TBAddress*) address
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIFont *font = [UIFont systemFontOfSize:18];
        int padding = 10;
        int width = self.bounds.size.width;
        int height = self.bounds.size.height;
        
        UILabel *street = [[UILabel alloc] initWithFrame:CGRectMake(padding, 0, width - padding*2, height/3)];
        [street setText:[address street]];
        [street setFont:font];
        [street setTextAlignment:NSTextAlignmentLeft];
        
        UILabel *city = [[UILabel alloc] initWithFrame:CGRectMake(padding, height/3, (width - padding*2)/2 - padding/2, height/3)];
        [city setText:[address city]];
        [city setFont:font];
        [city setTextAlignment:NSTextAlignmentLeft];
        
        UILabel *state = [[UILabel alloc] initWithFrame:CGRectMake(padding+padding + (width - padding*2)/2, height/3, (width - padding*2)/2-padding/2, height/3)];
        [state setText:[address state]];
        [state setFont:font];
        [state setTextAlignment:NSTextAlignmentLeft];
        
        UILabel *zip = [[UILabel alloc] initWithFrame:CGRectMake(padding, height*2/3, (width - padding*2)/2 - padding/2, height/3)];
        [zip setText:[address zip]];
        [zip setFont:font];
        [zip setTextAlignment:NSTextAlignmentLeft];
        
        UILabel *country = [[UILabel alloc] initWithFrame:CGRectMake(padding+padding + (width - padding*2)/2, height*2/3, (width - padding*2)/2-padding/2, height/3)];
        [country setText:[address country]];
        [country setFont:font];
        [country setTextAlignment:NSTextAlignmentLeft];
        
        UIView *border1 = [[UIView alloc] initWithFrame:CGRectMake(padding, height/3, width-padding*2, 0.5)];
        [border1 setBackgroundColor:[UIColor lightGrayColor]];
        
        UIView *border2 = [[UIView alloc] initWithFrame:CGRectMake(padding, height*2/3, width-padding*2, 0.5)];
        [border2 setBackgroundColor:[UIColor lightGrayColor]];
        
        UIView *border3 = [[UIView alloc] initWithFrame:CGRectMake(padding, height*3/3, width-padding*2, 0.5)];
        [border3 setBackgroundColor:[UIColor lightGrayColor]];
        
        UIView *verticalBorder = [[UIView alloc] initWithFrame:CGRectMake(padding + (width - padding*2)/2 + padding/2, height/3, 0.5, height*2/3)];
        [verticalBorder setBackgroundColor:[UIColor lightGrayColor]];
        
        [self addSubview:street];
        [self addSubview:city];
        [self addSubview:state];
        [self addSubview:zip];
        [self addSubview:country];
        [self addSubview:border1];
        [self addSubview:border2];
        [self addSubview:border3];
        [self addSubview:verticalBorder];

    }
    return self;
}

@end
