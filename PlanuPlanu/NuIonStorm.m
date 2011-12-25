//
//  NuIonStorm.m
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/24/11.
//  Copyright 2011 Roboboogie Studios. All rights reserved.
//

#import "NuIonStorm.h"

@implementation NuIonStorm

@synthesize heading, ionStormId, isGrowing, radius;
@synthesize voltage, warp, x, y;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)loadFromDict:(NSDictionary*)input
{
    NSNumber* buf;
    
    buf = [input objectForKey:@"heading"];
    self.heading = [buf intValue];
    
    buf = [input objectForKey:@"id"];
    self.ionStormId = [buf intValue];
    
    buf = [input objectForKey:@"isgrowing"];
    self.isGrowing = [buf boolValue];
    
    buf = [input objectForKey:@"radius"];
    self.radius = [buf intValue];
    
    buf = [input objectForKey:@"voltage"];
    self.voltage = [buf intValue];
    
    buf = [input objectForKey:@"warp"];
    self.warp = [buf intValue];
    
    buf = [input objectForKey:@"x"];
    self.x = [buf intValue];
    
    buf = [input objectForKey:@"y"];
    self.y = [buf intValue];
}

@end
