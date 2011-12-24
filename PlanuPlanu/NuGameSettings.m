//
//  NuGameSettings.m
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/23/11.
//  Copyright 2011 Roboboogie Studios. All rights reserved.
//

#import "NuGameSettings.h"

@implementation NuGameSettings

@synthesize mapHeight, mapWidth;

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
    NSNumber* mw;
    NSNumber* mh;
    
    mw = [input objectForKey:@"mapwidth"];
    mh = [input objectForKey:@"mapheight"];
    
    self.mapHeight = [mh intValue];
    self.mapWidth = [mw intValue];
    
    return YES;
}

@end
