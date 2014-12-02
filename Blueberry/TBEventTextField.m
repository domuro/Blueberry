//
//  TBEventTextField.m
//  Blueberry
//
//  Created by Derek Omuro on 5/16/14.
//  Copyright (c) 2014 TeamBlueberry. All rights reserved.
//

#import "TBEventTextField.h"

@implementation TBEventTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
//        [self setBackgroundColor:[UIColor whiteColor]];
        [self setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:48]];
        [self setTextColor:[UIColor whiteColor]];
        [self setReturnKeyType:UIReturnKeyDone];
        [self addTarget:self
                           action:@selector(dropKB)
                 forControlEvents:UIControlEventEditingDidEndOnExit];
    }
    return self;
}

- (void)dropKB{
    [self resignFirstResponder];
}

- (CGRect)editingRectForBounds:(CGRect)bounds{
    return CGRectInset(bounds, 20, 0);
}

- (CGRect)textRectForBounds:(CGRect)bounds{
    return CGRectInset(bounds, 20, 0);
}

@end
