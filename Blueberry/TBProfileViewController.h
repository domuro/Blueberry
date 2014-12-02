//
//  TBProfileViewController.h
//  Blueberry
//
//  Created by Derek Omuro on 5/16/14.
//  Copyright (c) 2014 TeamBlueberry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBPerson.h"

@interface TBProfileViewController : UIViewController
@property TBPerson* person;
- (id)initWithPerson: (TBPerson *) person;
@end
