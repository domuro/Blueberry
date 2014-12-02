//
//  TBEncounterManager.h
//  Blueberry
//
//  Created by Derek Omuro on 5/17/14.
//  Copyright (c) 2014 TeamBlueberry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBEncounterManager : NSObject {
    //Map NSNumber userID to TBPriority
    NSMutableDictionary *interactions;
}

@property (nonatomic, retain) NSMutableDictionary *interactions;
+ (id)sharedManager;

@end
