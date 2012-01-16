//
//  Fleet Manifest.h
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 1/15/12.
//  Copyright (c) 2012 Roboboogie Studios. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface FleetManifestWindowController : NSWindowController
{
    NSArray* fleetManifest;
    NSArrayController* fleetManifestController;
}

@property (nonatomic, retain) NSArray* fleetManifest;
@property (nonatomic, assign) NSArrayController* fleetManifestController;           

@end
