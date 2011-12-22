//
//  CaptainDashboardController.h
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/22/11.
//  Copyright 2011 Roboboogie Studios. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CaptainDashboardController : NSWindowController
{
    @private
    NSTextField* loginMessage;
}

@property (assign) IBOutlet NSTextField* loginMessage;

@end
