//
//  NuShipView.h
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/29/11.
//  Copyright 2011 Roboboogie Studios. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <PlanuKit/PlanuKit.h>

#import "NuColorScheme.h"
#import "NuMappableEntityLayer.h"

@class NuShipView;
 

@interface NuShipLayer : NuMappableEntityLayer
{
    NSMutableArray* ships;
    NuPlayer* player;
    NSInteger shipRadius;
    NuColorScheme* colors; 
     
}

@property (nonatomic, retain) NSMutableArray* ships;
@property (nonatomic, retain) NuPlayer* player;
@property (nonatomic, retain) NuColorScheme* colors; 

- (id)initWithShip:(NuShip*)ship;
- (NSRect)calculateLayerBounds;
- (void)addShip:(NuShip*)ship;

@end
