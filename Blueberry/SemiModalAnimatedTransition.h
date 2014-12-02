//
//  SemiModalAnimatedTransition.h
//  Blueberry
//
//  Created by 夏目夏樹 on 5/21/14.
//  Copyright (c) 2014 TeamBlueberry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SemiModalAnimatedTransition : NSObject <UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign) BOOL presenting;
@end