//
//  NuShip+WeaponDisplay.m
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 1/16/12.
//  Copyright (c) 2012 Roboboogie Studios. All rights reserved.
//

#import "NuShip+WeaponDisplay.h"

@implementation NuShip (WeaponDisplay)

- (NSString*)displayBeams
{
    if (self.beam == nil)
    {
        return @"none";
    }
    
    return [NSString stringWithFormat:@"%ld %@", self.beams, self.beam.name];;
}

- (NSString*)displayLaunchers
{
    if (self.launcher == nil)
    {
        return @"none";
    }
    
    return [NSString stringWithFormat:@"%ld %@", self.torps, self.launcher.name];
}

@end
