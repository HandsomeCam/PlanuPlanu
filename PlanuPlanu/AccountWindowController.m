//
//  AccountWindowController.m
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/21/11.
//  Copyright 2012 Roboboogie Studios. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import "AccountWindowController.h"
#import "NSAttributedString+Hyperlink.h"
#import <PlanuKit/PlanuKit.h>
#import "Preferences.h"

@interface AccountWindowController (private)
 
    -(void)setHyperlinkWithTextField:(NSTextField*)inTextField;
    -(void)initControls;

@end

@implementation AccountWindowController
 
@synthesize username, password, signupLabel;
@synthesize autoLogin, saveLogin;

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.

    [self setHyperlinkWithTextField:signupLabel];
    
    [self initControls];
}


-(void)initControls
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    autoLogin.state = [defaults boolForKey:kPrefAutoLogin];
    saveLogin.state = [defaults boolForKey:kPrefSaveLogin];
    
    username.stringValue = [defaults stringForKey:kPrefUsername];
    password.stringValue = [defaults stringForKey:kPrefPassword];
}

-(void)setHyperlinkWithTextField:(NSTextField*)inTextField
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    // both are needed, otherwise hyperlink won't accept mousedown
    [inTextField setAllowsEditingTextAttributes: YES];
    [inTextField setSelectable: YES];
    
    NSURL* url = [NSURL URLWithString:@"http://www.planets.nu"];
    
    NSMutableAttributedString* string = [[NSMutableAttributedString alloc] initWithString:@"Need an account? Sign up at:\n"];

    [string autorelease];
    
    [string appendAttributedString: [NSAttributedString hyperlinkFromString:@"http://planets.nu" withURL:url]];
    
    //center the text
    NSMutableParagraphStyle *mutParaStyle=[[NSMutableParagraphStyle alloc] init];
    [mutParaStyle setAlignment:NSCenterTextAlignment];
    [string addAttributes:[NSDictionary dictionaryWithObject:mutParaStyle forKey:NSParagraphStyleAttributeName] range:NSMakeRange(0,[string length])];
    [mutParaStyle release];
    
    // set the attributed string to the NSTextField
    [inTextField setAttributedStringValue: string];
    
    [pool drain];
}

- (void)loginClicked:(id)sender
{
    NuLoginRequest* lr = [[NuLoginRequest alloc] init];
    [lr performLoginWithUsername:username.stringValue withPassword:password.stringValue withDelegate:self];
}


- (void)saveLoginChanged:(id)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSInteger state = ((NSButton*)sender).state;
    
    [defaults setBool:state forKey:kPrefSaveLogin];
    [defaults synchronize];
}

- (void)autoLoginChanged:(id)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSInteger state = ((NSButton*)sender).state;
    
    [defaults setBool:state forKey:kPrefAutoLogin];
    [defaults synchronize];
}

// For LoginRequestDelegate
- (void)loginSucceededWith:(NSString*) ApiKey
{
    if (saveLogin.state == YES)
    {
        // Since we know the login was successful it's ok to save
        NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
        
        [defaults setValue:username.stringValue forKey:kPrefUsername];
        [defaults setValue:password.stringValue forKey:kPrefPassword];
        [defaults setValue:ApiKey forKey:kPrefApiKey];
        [defaults synchronize];
    }
    
    NSAlert* alert = [[NSAlert alloc] init];
    alert.messageText = @"Login Successful";
    [alert runModal];
    [alert release];
    
    [self close];
}

// For LoginRequestDelegate
- (void)loginFailedWith:(NSString*) Reason
{
    
}

@end
