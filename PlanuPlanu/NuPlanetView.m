//
//  NuPlanetView.m
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/29/11.
//  Copyright 2011 Roboboogie Studios. All rights reserved.
//

#import "NuPlanetView.h"

@implementation NuPlanetView

@synthesize planet, player, colors;

- (id)initWithPlanet:(NuPlanet*)pln
{
    self.planet = pln;
    NSInteger planetRadius = 5;
    CGRect rectangle = CGRectMake(planet.x - planetRadius,
                                  planet.y - planetRadius,
                                  planetRadius*2, planetRadius*2);
    
    return [self initWithFrame:rectangle];
    
}

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.
    // Draw Circle 
    CGRect planetRect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    NSBezierPath *planetPath;
    if (planet.starbase == nil)
    {
        planetPath = [NSBezierPath bezierPathWithOvalInRect:planetRect];
    }
    else
    {
        planetPath = [NSBezierPath bezierPathWithRect:planetRect];
    }
    
    [planetPath setLineWidth:0.0];
    
    if (self.colors == nil)
    {
        if (planet.ownerId == player.playerId)
        {
            [[NSColor greenColor] setFill]; 
        }
        else
        {
            [[NSColor redColor] setFill]; 
        }
    }
    else
    {
        if (planet.ownerId > 0)
        {
            [[self.colors colorForPlayer:planet.ownerId] setFill];
        }
        else
        {
            [[NSColor grayColor] setFill];
        }
    }    

    [planetPath fill];
}

@end
