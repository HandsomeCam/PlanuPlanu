//
//  StarMapView.h
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/24/11.
//  Copyright 2012 Roboboogie Studios. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import <Cocoa/Cocoa.h>
#import <PlanuKit/PlanuKit.h>
#import "PlanetPopoverController.h" 
#import "ScanRangeVisibilityView.h"
#import "NuColorScheme.h"
#import "NuShipLayer.h"
#import "NuPlanetLayer.h"
#import "MapMuxPopoverController.h"
#import "ShipPopoverController.h"

@protocol StarMapViewDelegate <NSObject>

- (void)showMultiplexPopover:(NSArray*)entities at:(NSRect)popFrame;

@end

@interface StarMapView : NSView <MapMuxDelegate>
{
//    NSArray *planets;
    CGPoint startOrigin;
    CGPoint startPt;
//    NuPlayer* player;
    PlanetPopoverController *popover;
    MapMuxPopoverController *muxover;
    ShipPopoverController *shipover;
    
    NuTurn* turn;
    
//    NSArray *ionStorms;
//    NSArray *ships;
    
    NSArray* planetLayers;
    NSArray* shipLayers;
    NSArray* stormLayers;
    NSArray* connectionLayers;
    NSArray* mineLayers;
    
    NSMutableDictionary* viewsByLocation;
    
    NuColorScheme* colorScheme;
    
    ScanRangeVisibilityView* scanRangeView;
    
    id<StarMapViewDelegate> delegate;
}

//@property (nonatomic, retain) NSArray* planets;
//@property (nonatomic, retain) NuPlayer* player;
//@property (nonatomic, retain) NSArray* ionStorms;
//@property (nonatomic, retain) NSArray* ships;
@property (nonatomic, retain) NuTurn* turn;

@property (nonatomic, retain) NSArray* planetLayers;
@property (nonatomic, retain) NSArray* shipLayers;
@property (nonatomic, retain) NSArray* stormLayers;
@property (nonatomic, retain) NSArray* connectionLayers;
@property (nonatomic, retain) NSArray* mineLayers;

@property (nonatomic, retain) ScanRangeVisibilityView* scanRangeView;
@property (nonatomic, retain) NuColorScheme* colorScheme;

@property (nonatomic, assign) id<StarMapViewDelegate> delegate;

- (id)initWithTurn:(NuTurn*)turn;

- (void)showPlanetPopover:(NuPlanet*)planet;
- (void)showShipPopover:(NuShip*)ship;
- (void)showMultiplexPopover:(NSArray*)entities at:(NSRect)popFrame;

- (void)scrollToHomeWorld;

- (void)addIonStorms;
- (void)addPlanets;
- (void)addShips;
- (void)addPlanetaryConnections;
- (void)addMinefields;

- (void)setPlanetsHidden:(BOOL)visibility;
- (void)setShipsHidden:(BOOL)visibility;
- (void)setStormsHidden:(BOOL)visibility;
- (void)setConnectionsHidden:(BOOL)visibility;
- (void)setScanRangeHidden:(BOOL)visibility;
- (void)setMinefieldsHidden:(BOOL)visibility;

- (void)setColorScheme:(NuColorScheme*)colorScheme;
- (void)addObservers;

@end
