//
//  TBPriority.m
//  Blueberry
//
//  Created by Derek Omuro on 5/17/14.
//  Copyright (c) 2014 TeamBlueberry. All rights reserved.
//

#import "TBPriority.h"

@implementation TBPriority
- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code
        self.priority = 0;
    }
    return self;
}

//Todo magic GeniusRank
- (void)ping
{
    self.priority += 1;
}

@end
