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

@interface NuShipView : NSView
{
    NuShip* ship;
    NuPlayer* player;
    NSInteger shipRadius;
    NuColorScheme* colors;
}

@property (nonatomic, retain) NuShip* ship;
@property (nonatomic, retain) NuPlayer* player;
@property (nonatomic, retain) NuColorScheme* colors;

- (id)initWithShip:(NuShip*)ship;

@end
