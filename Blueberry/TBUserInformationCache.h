//
//  TBUserInformationCache.h
//  Blueberry
//
//  Created by Derek Omuro on 5/17/14.
//  Copyright (c) 2014 TeamBlueberry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBUserInformationCache : NSObject {
    //Map NSNumber to Person
    NSMutableDictionary *cache;
}

@property (nonatomic, retain) NSMutableDictionary *cache;
+ (id)sharedManager;

@end
