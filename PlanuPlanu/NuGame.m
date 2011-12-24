//
//  NuGame.m
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/23/11.
//  Copyright 2011 Roboboogie Studios. All rights reserved.
//

#import "NuGame.h"

@implementation NuGame

@synthesize name;
@synthesize gameId;

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
    self.name = [input objectForKey:@"name"];
    NSNumber* gid = [input objectForKey:@"id"];

    self.gameId = [gid intValue];
    
    return YES;
}

@end
