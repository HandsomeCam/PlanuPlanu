//
//  NuPlanetView.m
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/29/11.
//  Copyright 2011 Roboboogie Studios. All rights reserved.
//

#import "NuPlanetView.h"

@implementation NuPlanetView

@synthesize planet, player;

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
    CGContextRef context = [[NSGraphicsContext 
                               currentContext] graphicsPort];
    CGContextSetLineWidth(context, 2.0);
    
    CGColorRef grey =  CGColorCreateGenericRGB(.9, .9, .9, 1);
    CGColorRef green = CGColorCreateGenericRGB(.1, 1, .2, 1);
    
    CGRect planetRect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    if (planet.ownerId == player.playerId)
    {
        CGContextSetFillColorWithColor(context, green);
    }
    else
    {
        CGContextSetFillColorWithColor(context, grey);
    }
    
    if (planet.starbase == nil)
    {
        CGContextFillEllipseInRect(context, planetRect);
    }
    else
    {
        CGContextFillRect(context, planetRect);
    }
    
    CGContextStrokePath(context);
}

@end
