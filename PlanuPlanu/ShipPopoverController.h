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
    
    NSTextField* isCloaked;
    NSTextField* crewLabel;
    
    NSTextField* durLabel;
    NSTextField* molLabel;
    NSTextField* triLabel;
    
    NSTextField* clanLabel;
    NSTextField* suppLabel;
    NSTextField* mcLabel;
    
    NSTextField* crewAmount;
    
    NSTextField* durAmount;
    NSTextField* molAmount;
    NSTextField* triAmount;
    
    NSTextField* clanAmount;
    NSTextField* suppAmount;
    NSTextField* mcAmount;
}

@property (nonatomic, assign) IBOutlet NSTextField* shipName;
@property (nonatomic, assign) IBOutlet NSTextField* hullClass;
@property (nonatomic, retain) NuShip* ship;
@property (nonatomic, retain) NSPopover* child; 
@property (nonatomic, readonly) NSString* fuelOfFuel;
@property (nonatomic, readonly) NSString* xy;
@property (nonatomic, readonly) NSString* shipCrew;

@property (nonatomic, assign) IBOutlet NSTextField* isCloaked;

@property (nonatomic, assign) IBOutlet NSTextField* crewLabel;

@property (nonatomic, assign) IBOutlet NSTextField* durLabel;
@property (nonatomic, assign) IBOutlet NSTextField* molLabel;
@property (nonatomic, assign) IBOutlet NSTextField* triLabel;

@property (nonatomic, assign) IBOutlet NSTextField* clanLabel;
@property (nonatomic, assign) IBOutlet NSTextField* suppLabel;
@property (nonatomic, assign) IBOutlet NSTextField* mcLabel;

@property (nonatomic, assign) IBOutlet NSTextField* crewAmount;

@property (nonatomic, assign) IBOutlet NSTextField* durAmount;
@property (nonatomic, assign) IBOutlet NSTextField* molAmount;
@property (nonatomic, assign) IBOutlet NSTextField* triAmount;

@property (nonatomic, assign) IBOutlet NSTextField* clanAmount;
@property (nonatomic, assign) IBOutlet NSTextField* suppAmount;
@property (nonatomic, assign) IBOutlet NSTextField* mcAmount;

@property (nonatomic, readonly) NSString* displayHeading;

@end
