//
//  Fleet Manifest.m
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 1/15/12.
//  Copyright (c) 2012 Roboboogie Studios. All rights reserved.
//

#import "FleetManifestWindowController.h"


@implementation FleetManifestWindowController

@synthesize fleetManifest, fleetManifestController;

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
}

@end
