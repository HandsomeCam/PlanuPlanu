//
//  AccountWindowController.m
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/21/11.
//  Copyright 2011 Roboboogie Studios. All rights reserved.
//

#import "AccountWindowController.h"
#import "NSAttributedString+Hyperlink.h"
#import "LoginRequest.h"

@interface AccountWindowController (private)
 
    -(void)setHyperlinkWithTextField:(NSTextField*)inTextField;
 
@end

@implementation AccountWindowController
 
@synthesize username, password, signupLabel;

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
    LoginRequest* lr = [[LoginRequest alloc] init];
    [lr performLoginWithUsername:username.stringValue withPassword:password.stringValue withDelegate:self];
}

// For LoginRequestDelegate
- (void)loginSucceededWith:(NSString*) ApiKey
{

}

// For LoginRequestDelegate
- (void)loginFailedWith:(NSString*) Reason
{
    
}

@end
