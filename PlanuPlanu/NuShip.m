//
//  NuShip.m
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/26/11.
//  Copyright 2011 Roboboogie Studios. All rights reserved.
//

#import "NuShip.h"

@implementation NuShip

@synthesize x, y;

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
    buf = [input objectForKey:@"x"];
    self.x = [buf intValue];
    
    buf = [input objectForKey:@"y"];
    self.y = [buf intValue];
}

@end
