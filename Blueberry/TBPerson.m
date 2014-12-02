//
//  TBPerson.m
//  Blueberry
//
//  Created by Derek Omuro on 5/16/14.
//  Copyright (c) 2014 TeamBlueberry. All rights reserved.
//

#import "TBPerson.h"

@implementation TBPerson

@synthesize name, company, title, email, industry, talkToMe, work, cell, fax, linkedInID, twitterID, website, address, profileImage;

- (void)exportTo:(NSString *)file
{
    NSDictionary *addressDict;
    if (address != nil) {
        addressDict = @{};
    } else {
        addressDict = @{
                        @"street": address.street,
                        @"city": address.city,
                        @"state": address.state,
                        @"zip": address.zip,
                        @"country": address.country
                        };

    }
    NSDictionary *dict = @{
      @"profileImage": [UIImagePNGRepresentation(profileImage) base64EncodedStringWithOptions:0],
      @"name": name,
      @"company": company,
      @"title": title,
      @"email": email,
      @"industry": industry,
      @"work": work,
      @"cell": cell,
      @"fax": fax,
      @"linkedInID": linkedInID,
      @"twitterID": twitterID,
      @"website": website,
      @"address": addressDict
      };
    [dict writeToFile:file atomically:YES];
}

- (void)importFrom:(NSString *)file
{
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:file];
    for (NSString *key in dict) {
        if ([key isEqualToString:@"address"]) {
            address = [[TBAddress alloc] init];
            NSDictionary *addressData = (NSDictionary *)[dict objectForKey:@"address"];
            if ([[addressData allKeys] count] != 0) {
                for (NSString *addressKey in addressData) {
                    [address setValue:[addressData objectForKey:addressKey] forKey:addressKey];
                }
            }
        } else if ([key isEqualToString:@"profileImage"]) {
            profileImage = [[UIImage alloc] initWithData:[[NSData alloc] initWithBase64EncodedString:(NSString *)[dict objectForKey:key] options:0] scale:0] ;
        } else {
            [self setValue:[dict objectForKey:key] forKeyPath:key];
        }
    }
}

@end
