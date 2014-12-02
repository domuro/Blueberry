//
//  TBPerson.h
//  Blueberry
//
//  Created by Derek Omuro on 5/16/14.
//  Copyright (c) 2014 TeamBlueberry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBAddress.h"

@interface TBPerson : NSObject

@property UIImage *profileImage;
@property NSString *name, *company, *title, *email, *industry;
@property NSString *talkToMe;
@property NSString *work, *cell, *fax;
@property NSString *linkedInID, *twitterID;
@property NSString *website;
@property TBAddress *address;

- (void)exportTo:(NSString *)file;
- (void)importFrom:(NSString *)file;

@end
