//
//  TBUserInformationCache.m
//  Blueberry
//
//  Created by Derek Omuro on 5/17/14.
//  Copyright (c) 2014 TeamBlueberry. All rights reserved.
//

#import "TBUserInformationCache.h"

@implementation TBUserInformationCache
@synthesize cache;

#pragma mark Singleton Methods

+ (id)sharedManager {
    static TBUserInformationCache *manager = nil;
    @synchronized(self) {
        if (manager == nil)
            manager = [[self alloc] init];
    }
    return manager;
}

- (id)init {
    if (self = [super init]) {
        cache = [[NSMutableDictionary alloc] init];
    }
    return self;
}

@end
