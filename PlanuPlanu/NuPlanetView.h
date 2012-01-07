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

@class NuPlanetView;

@protocol NuPlanetViewDelegate <NSObject>

- (void)planetSelected:(NuPlanetView*)sender atLocation:(CGPoint)point;

@end

@interface NuPlanetView : NuMappableEntityLayer
{
    NuPlanet* planet;
    NuPlayer* player;
    NuColorScheme* colors;
    id<NuPlanetViewDelegate> delegate;
    
}

@property (nonatomic, retain) NuPlanet* planet;
@property (nonatomic, retain) NuPlayer* player;
@property (nonatomic, retain) NuColorScheme* colors;
@property (assign) id<NuPlanetViewDelegate> delegate;

- (id)initWithPlanet:(NuPlanet*)planet;

@end
