//
//  NuMinefieldLayer.h
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 1/11/12.
//  Copyright (c) 2012 Roboboogie Studios. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <PlanuKit/PlanuKit.h>
#import "NuColorScheme.h"

@interface NuMinefieldLayer : CALayer
{
    NuMinefield* minefield;
    NuColorScheme* colors;
    NuPlayer* player;
}

@property (nonatomic, retain) NuMinefield* minefield;
@property (nonatomic, retain) NuPlayer* player;
@property (nonatomic, retain) NuColorScheme* colors;


- (id)initWithMinefield:(NuMinefield*)minefield;

@end
