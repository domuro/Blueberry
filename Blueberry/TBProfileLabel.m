//
//  TBProfileLabel.m
//  Blueberry
//
//  Created by Derek Omuro on 5/18/14.
//  Copyright (c) 2014 TeamBlueberry. All rights reserved.
//

#import "TBProfileLabel.h"

@implementation TBProfileLabel

@synthesize title, text;

- (id)initWithFrame:(CGRect)frame withTitle:(NSString*)theTitle withText:(NSString*)theText
{
    self = [super initWithFrame:frame];
    if (self) {
        title = theTitle;
        text = theText;
        // Initialization code
        UIFont *font = [UIFont systemFontOfSize:18];
        int split = 4;
        int splitPadding = 10;
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width/split, self.bounds.size.height)];
        [titleLabel setText:title];
        [titleLabel setTextColor:[UIColor colorWithRed:21/255. green:122/255. blue:251/255. alpha:1]];
        [titleLabel setFont:[UIFont systemFontOfSize:14]];
        [titleLabel setTextAlignment:NSTextAlignmentRight];
        [titleLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [titleLabel setNumberOfLines:0];
        
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width/split + splitPadding, 0, self.bounds.size.width-self.bounds.size.width/split - splitPadding, self.bounds.size.height)];
        [textLabel setText:text];
        [textLabel setFont:font];
        [textLabel setTextAlignment:NSTextAlignmentLeft];
        [textLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [textLabel setNumberOfLines:0];
        
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [textLabel addGestureRecognizer:recognizer];
        [textLabel setUserInteractionEnabled:YES];

        UIView *bottomBorder = [[UIView alloc] initWithFrame:CGRectMake(splitPadding, self.bounds.size.height, self.bounds.size.width-splitPadding*2, 0.5)];
        [bottomBorder setBackgroundColor:[UIColor lightGrayColor]];
        
        UIView *splitBorder = [[UIView alloc] initWithFrame:CGRectMake(self.bounds.size.width/split + splitPadding/2, 0, 0.5, self.bounds.size.height)];
        [splitBorder setBackgroundColor:[UIColor lightGrayColor]];
        
        [self addSubview:titleLabel];
        [self addSubview:textLabel];
        [self addSubview:bottomBorder];
        [self addSubview:splitBorder];
        
    }
    return self;
}

- (void)tap
{
    NSArray *nunmbers = @[@"Work", @"Cell"];
    if ([nunmbers containsObject:[self title]]) {
//        NSLog(@"%@, %@", [self title], [NSString stringWithFormat:@"tel://%@", [self text]]);
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", [self text]]]];
    }
    
    if ([[self title] isEqual:@"Email"]) {
        if ([MFMailComposeViewController canSendMail])
        {
            [self displayMailComposerSheet];
        }
    }
    if ([[self title] isEqual:@"Website"]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@", [self text]]]];
    }

}

- (void)displayMailComposerSheet
{
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    
    // Set up email
    //Todo set this
    NSArray *toRecipients = @[[self text]];
    [picker setToRecipients:toRecipients];
    
    [self.sourceViewController presentViewController:picker animated:YES completion:NULL];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	[self.sourceViewController dismissViewControllerAnimated:YES completion:NULL];
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller
                 didFinishWithResult:(MessageComposeResult)result
{
	[self.sourceViewController dismissViewControllerAnimated:YES completion:NULL];
}

@end
