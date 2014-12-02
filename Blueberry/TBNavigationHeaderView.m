//
//  TBNavigationView.m
//  Blueberry
//
//  Created by Derek Omuro on 5/14/14.
//  Copyright (c) 2014 TeamBlueberry. All rights reserved.
//

#import "TBNavigationHeaderView.h"
#import "TBNavigationController.h"

@implementation TBNavigationHeaderView
@synthesize control;
//Todo low quality image segment image???
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        control = [[UISegmentedControl alloc] initWithItems:@[@"a", @"a", @"a"]]; //To initialize with three items.
        [control setFrame:self.bounds];
        [control setSelectedSegmentIndex:0];
        
        UIImage *encounter = [UIImage imageNamed:@"encounter.png"];
        encounter = [self imageWithImage:encounter scaledToSize:CGSizeMake(frame.size.height, frame.size.height)];
        
        UIImage *toFollow = [UIImage imageNamed:@"bolt4barbutton.png"];
        toFollow = [self imageWithImage:toFollow scaledToSize:CGSizeMake(frame.size.height, frame.size.height)];
        
        UIImage *contacts = [UIImage imageNamed:@"contact.png"];
        contacts = [self imageWithImage:contacts scaledToSize:CGSizeMake(frame.size.height, frame.size.height)];
        [control setImage:encounter forSegmentAtIndex:0];
        [control setImage:toFollow forSegmentAtIndex:1];
        [control setImage:contacts forSegmentAtIndex:2];
        
        [control addTarget:self action:@selector(controlChanged) forControlEvents:UIControlEventValueChanged];

        [self addSubview:control];
        [control setExclusiveTouch:YES];
    }
    return self;
}

- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, [[UIScreen mainScreen] scale]);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void) controlChanged
{
    [((TBNavigationController *)self.sourceViewController) updateViewController:[control selectedSegmentIndex]];
}

@end
