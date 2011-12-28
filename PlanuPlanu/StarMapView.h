//
//  StarMapView.h
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/24/11.
//  Copyright 2011 Roboboogie Studios. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <PlanuKit/PlanuKit.h>
#import "PlanetPopoverController.h" 

@interface StarMapView : NSView
{
    NSArray *planets;
    CGPoint startOrigin;
    CGPoint startPt;
    NuPlayer* player;
    PlanetPopoverController *popover;
    NSArray *ionStorms;
    NSArray *ships;
}

@property (nonatomic, retain) NSArray* planets;
@property (nonatomic, retain) NuPlayer* player;
@property (nonatomic, retain) NSArray* ionStorms;
@property (nonatomic, retain) NSArray* ships;

- (void)drawPlanets:(CGContextRef)context;
- (void)drawIonStorms:(CGContextRef)context;
- (void)drawPlanetaryConnections:(CGContextRef)context;
- (void)drawShips:(CGContextRef)context;

- (void)showPlanetPopover:(NuPlanet*)planet;
- (void)scrollToHomeWorld;

@end
