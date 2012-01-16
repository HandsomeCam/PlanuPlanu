//
//  NuPlanetView.h
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/29/11.
//  Copyright 2011 Roboboogie Studios. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <PlanuKit/PlanuKit.h>
#import "NuColorScheme.h"
#import "NuMappableEntityLayer.h"

@class NuPlanetLayer;

@protocol NuPlanetLayerDelegate <NSObject>

- (void)planetSelected:(NuPlanetLayer*)sender atLocation:(CGPoint)point;

@end

@interface NuPlanetLayer : NuMappableEntityLayer
{
    NuPlanet* planet;
    NuPlayer* player;
    NuColorScheme* colors;
    id<NuPlanetLayerDelegate> delegate;
    
}

@property (nonatomic, retain) NuPlanet* planet;
@property (nonatomic, retain) NuPlayer* player;
@property (nonatomic, retain) NuColorScheme* colors;
@property (assign) id<NuPlanetLayerDelegate> delegate;

- (id)initWithPlanet:(NuPlanet*)planet;

@end
