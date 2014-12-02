//
//  TBEncounterManager.m
//  Blueberry
//
//  Created by Derek Omuro on 5/17/14.
//  Copyright (c) 2014 TeamBlueberry. All rights reserved.
//

#import "TBEncounterManager.h"
#import "TBPriority.h"

@implementation TBEncounterManager
@synthesize interactions;

#pragma mark Singleton Methods

+ (id)sharedManager {
    static TBEncounterManager *encounterManager = nil;
    @synchronized(self) {
        if (encounterManager == nil)
            encounterManager = [[self alloc] init];
    }
    return encounterManager;
}

- (id)init {
    if (self = [super init]) {
        interactions = [[NSMutableDictionary alloc] init];
    }
    return self;
}

@end
