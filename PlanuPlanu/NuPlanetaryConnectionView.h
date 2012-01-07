//
//  NuPlanetaryConnectionView.h
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/31/11.
//  Copyright 2011 Roboboogie Studios. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <PlanuKit/PlanuKit.h>
#import "NuMappableEntityLayer.h"

@interface NuPlanetaryConnectionView : NuMappableEntityLayer
{
    NuPlanet* first;
    NuPlanet* second;
}

@property (nonatomic, retain) NuPlanet* first;
@property (nonatomic, retain) NuPlanet* second;

- (id)initWithPlanet:(NuPlanet*)first andPlanet:(NuPlanet*)second;

@end
