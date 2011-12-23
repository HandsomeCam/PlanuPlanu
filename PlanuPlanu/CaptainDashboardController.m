//
//  CaptainDashboardController.m
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/22/11.
//  Copyright 2011 Roboboogie Studios. All rights reserved.
//

#import "CaptainDashboardController.h"
#import "Preferences.h"
#import "GameListRequest.h"

@implementation CaptainDashboardController

@synthesize loginMessage;

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
    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    
    if ([defaults boolForKey:kPrefAutoLogin] == YES)
    {
        loginMessage.stringValue = [defaults stringForKey:kPrefApiKey];
    }
    
    GameListRequest* glr = [[GameListRequest alloc] init];
    
    NSString* username = [defaults stringForKey:kPrefUsername];
    
    if (username != nil)
    {
        [glr requestGamesFor:username withDelegate:self];
    }
}

@end
