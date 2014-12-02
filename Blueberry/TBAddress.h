//
//  TBAddress.h
//  Blueberry
//
//  Created by Derek Omuro on 5/18/14.
//  Copyright (c) 2014 TeamBlueberry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBAddress : NSObject

@property NSString *street, *city, *state, *zip, *country;
+(TBAddress*)sampleAddress;

@end
