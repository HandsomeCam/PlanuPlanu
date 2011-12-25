//
//  NuPlanet.m
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/23/11.
//  Copyright 2011 Roboboogie Studios. All rights reserved.
//

#import "NuPlanet.h"

@implementation NuPlanet

@synthesize isBuildingStarbase;
@synthesize defenseBuilt, factoriesBuilt, minesBuilt;
@synthesize x,y, name, ownerId, planetId;
@synthesize starbase, clans;


- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}


- (BOOL)loadFromDict:(NSDictionary*)input
{
    NSNumber* buf;
    
    buf = [input objectForKey:@"x"];
    self.x = [buf intValue];
    buf = [input objectForKey:@"y"];
    self.y = [buf intValue];
    
    buf = [input objectForKey:@"ownerid"];
    self.ownerId = [buf intValue];
    
    self.name = [input objectForKey:@"name"];
    
    buf = [input objectForKey:@"id"];
    self.planetId = [buf intValue];
    
    buf = [input objectForKey:@"clans"];
    self.clans = [buf intValue];
    
    return YES;
}

@end
