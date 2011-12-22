//
//  AccountWindowController.h
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/21/11.
//  Copyright 2011 Roboboogie Studios. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LoginRequest.h"

@interface AccountWindowController : NSWindowController <LoginRequestDelegate>
{
    NSTextField* username;
    NSTextField* password;
    NSTextField* signupLabel;
    
}

@property (assign) IBOutlet NSTextField* username;
@property (assign) IBOutlet NSTextField* password;
@property (assign) IBOutlet NSTextField* signupLabel;

- (IBAction)loginClicked:(id)sender;

@end
