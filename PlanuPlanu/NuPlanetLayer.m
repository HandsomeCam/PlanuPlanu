//
//  NuPlanetView.m
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/29/11.
//  Copyright 2012 Roboboogie Studios. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import "NuPlanetLayer.h"

@implementation NuPlanetLayer

@synthesize planet, player, colors, delegate;

- (id)initWithPlanet:(NuPlanet*)pln
{
    self.planet = pln;
    NSInteger planetRadius = 5;
    CGRect rectangle = CGRectMake(planet.x - planetRadius,
                                  planet.y - planetRadius,
                                  planetRadius*2, planetRadius*2);
    
    self.identifier = self.planet.planetId;
    [self init];
    self.frame = rectangle;
    
    return self;
    
}
 
- (void)setColors:(NuColorScheme *)c
{
    if (colors != nil)
    {
        [colors release];
    }
    
    colors = [c retain];
    
    if (colors.lastUpdate == planet.ownerId
        || colors.lastUpdate < 0)
    {
        [self setNeedsDisplay];
    }
}

- (void)drawInContext:(CGContextRef)ctx
{
    NSGraphicsContext *nsGraphicsContext;
    nsGraphicsContext = [NSGraphicsContext graphicsContextWithGraphicsPort:ctx
                                                                   flipped:NO];
    [NSGraphicsContext saveGraphicsState];
    [NSGraphicsContext setCurrentContext:nsGraphicsContext];
    
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
    
    [NSGraphicsContext restoreGraphicsState];
}

//- (void)mouseDown:(NSEvent *)theEvent
//{
//    if (self.delegate != nil)
//    {
//        CGPoint center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
//        
//        NSPoint local_point = [self convertPoint:theEvent.locationInWindow fromView:nil];
//        
//        CGFloat distX = center.x - local_point.x;
//        CGFloat distY = center.y - local_point.y;
//        
//        CGFloat dist = sqrt(pow(distX, 2) + pow(distY, 2));
//        
//        if ((NSInteger)dist <= 5) // TODO: make a local ivar
//        {
//            [delegate planetSelected:self atLocation:theEvent.locationInWindow];
//        }
//    }
//    
//    return;
//}

@end
