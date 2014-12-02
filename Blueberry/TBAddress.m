//
//  TBAddress.m
//  Blueberry
//
//  Created by Derek Omuro on 5/18/14.
//  Copyright (c) 2014 TeamBlueberry. All rights reserved.
//

#import "TBAddress.h"

@implementation TBAddress

+(TBAddress*)sampleAddress{
    TBAddress *sample = [[TBAddress alloc] init];
    [sample setStreet:@"1673 Wright Ave."];
    [sample setCity:@"Sunnyvale"];
    [sample setState:@"CA"];
    [sample setZip:@"94087"];
    [sample setCountry:@"United States"];
    return sample;
}

@end
