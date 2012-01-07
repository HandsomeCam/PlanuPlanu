//
//  NuIonStormView.h
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/29/11.
//  Copyright 2011 Roboboogie Studios. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <PlanuKit/PlanuKit.h>

#import "NuMappableEntityLayer.h"

@interface NuIonStormView : NuMappableEntityLayer
{
    NuIonStorm* storm;
    NSArray* lightning;
}

@property (nonatomic, retain) NuIonStorm* storm;

- (id)initWithIonStorm:(NuIonStorm*)ionStorm;
- (NSArray*)drawLightningFrom:(CGPoint)start to:(CGPoint)finish displacedBy:(NSInteger)displacement;

@end
