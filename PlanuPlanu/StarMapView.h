//
//  StarMapView.h
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/24/11.
//  Copyright 2011 Roboboogie Studios. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NuPlayer.h"
#import "NuPlanet.h"
#import "PlanetPopoverController.h"
#import "NuIonStorm.h"

@interface StarMapView : NSView
{
    NSArray *planets;
    CGPoint startOrigin;
    CGPoint startPt;
    NuPlayer* player;
    PlanetPopoverController *popover;
    NSArray *ionStorms;
}

@property (nonatomic, retain) NSArray* planets;
@property (nonatomic, retain) NuPlayer* player;
@property (nonatomic, retain) NSArray* ionStorms;

- (void)drawPlanets:(CGContextRef)context;
- (void)drawIonStorms:(CGContextRef)context;
- (void)showPlanetPopover:(NuPlanet*)planet;
- (void)scrollToHomeWorld;

@end
