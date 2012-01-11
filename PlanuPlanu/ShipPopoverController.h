//
//  ShipPopoverController.h
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 1/10/12.
//  Copyright (c) 2012 Roboboogie Studios. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <PlanuKit/PlanuKit.h>

@interface ShipPopoverController : NSViewController <NSPopoverDelegate>
{
    NSTextField* shipName;
    NSTextField* hullClass;
    NuShip* ship;
    NSPopover* child;
}

@property (nonatomic, assign) IBOutlet NSTextField* shipName;
@property (nonatomic, assign) IBOutlet NSTextField* hullClass;
@property (nonatomic, retain) NuShip* ship;
@property (nonatomic, retain) NSPopover* child; 

@end
