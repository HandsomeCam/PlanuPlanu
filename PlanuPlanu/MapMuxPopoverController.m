//
//  MapMuxPopoverController.m
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 1/9/12.
//  Copyright (c) 2012 Roboboogie Studios. All rights reserved.
//

#import "MapMuxPopoverController.h"
#import <PlanuKit/PlanuKit.h>

@implementation MapMuxPopoverController

@synthesize entities;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)loadView
{
    [super loadView];
    
}

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
{
    if ([[entities objectAtIndex:rowIndex] isKindOfClass:[NuShip class]])
    {
        NuShip* ship = [entities objectAtIndex:rowIndex];
        
        if ([aTableColumn.identifier isEqualToString:@"id"])
        {
            return [NSString stringWithFormat:@"%d", ship.shipId];
        }
        else
        {
            return ship.name;
        }
    }
    else if ([[entities objectAtIndex:rowIndex] isKindOfClass:[NuPlanet class]])
    {
        NuPlanet* planet = [entities objectAtIndex:rowIndex];
        
        if ([aTableColumn.identifier isEqualToString:@"id"])
        {
            return [NSString stringWithFormat:@"%d", planet.planetId];
        }
        else
        {
            return planet.name;
        }
    }
    else
    {
        return @"poop";
    }
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView
{
    if (entities == nil)
    {
        return 0;
    }
    
    return [entities count];
}

@end
