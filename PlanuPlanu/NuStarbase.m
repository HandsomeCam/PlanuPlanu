//
//  NuStarbase.m
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/24/11.
//  Copyright 2011 Roboboogie Studios. All rights reserved.
//

#import "NuStarbase.h"

@implementation NuStarbase

@synthesize planetId;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)loadFromDict:(NSDictionary *)input
{
    NSNumber* buf = nil;
    
    buf = [input objectForKey:@"planetid"];
    self.planetId = [buf intValue];
}

@end
