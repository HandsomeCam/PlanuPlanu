//
//  PlanetPopoverController.h
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/24/11.
//  Copyright 2011 Roboboogie Studios. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <PlanuKit/PlanuKit.h>

@interface PlanetPopoverController : NSViewController <NSPopoverDelegate>
{
    NSTextField* planetName;
    NuPlanet* planet;
    NSPopover *child;
    NSTextField* clanQuantity;
}

@property (nonatomic, assign) IBOutlet NSTextField* planetName;
@property (nonatomic, assign) IBOutlet NSTextField* clanQuantity;

@property (nonatomic, retain) NuPlanet* planet;
@property (nonatomic, assign) NSPopover* child;

@end
