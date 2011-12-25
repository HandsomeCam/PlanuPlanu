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

@interface StarMapView : NSView
{
    NSArray *planets;
    CGPoint startOrigin;
    CGPoint startPt;
    NuPlayer* player;
    PlanetPopoverController *popover;
}

@property (nonatomic, retain) NSArray* planets;
@property (nonatomic, retain) NuPlayer* player;

- (void)drawPlanets:(CGContextRef)context;
- (void)showPlanetPopover:(NuPlanet*)planet;
- (void)scrollToHomeWorld;

@end
