//
//  PlanuPlanuAppDelegate.m
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/21/11.
//  Copyright 2011 Roboboogie Studios. All rights reserved.
//

#import "PlanuPlanuAppDelegate.h"
#import "CaptainDashboardController.h"

@implementation PlanuPlanuAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults registerDefaults:[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Preferences" ofType:@"plist"]]];
    
    CaptainDashboardController* cdc = [[CaptainDashboardController alloc] initWithWindowNibName:@"CaptainDashboard"];
    [cdc showWindow:self];
    
    self.window = cdc.window;

}

@end
