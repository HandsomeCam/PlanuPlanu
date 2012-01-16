//
//  NuPlanetaryConnectionView.m
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/31/11.
//  Copyright 2011 Roboboogie Studios. All rights reserved.
//

#import "NuPlanetaryConnectionLayer.h"

@implementation NuPlanetaryConnectionLayer

@synthesize first, second;

- (id)initWithPlanet:(NuPlanet*)f andPlanet:(NuPlanet*)s
{
    self.first = f;
    self.second = s;
    
    CGRect rect = CGRectMake(MIN(f.x, s.x), 
                             MIN(f.y, s.y),
                             abs((int)(f.x-s.x)),
                             abs((int)(f.y-s.y)));
    
    
    // The buffer gives vertical and horizontal lines the ability to show up
    rect.size.width += 4;
    rect.origin.x -= 2;

    rect.size.height += 4;
    rect.origin.y -= 2;
   
    [self init];
    self.frame = rect;
    
    return self;
}

- (void)drawInContext:(CGContextRef)ctx
{
    NSGraphicsContext *nsGraphicsContext;
    nsGraphicsContext = [NSGraphicsContext graphicsContextWithGraphicsPort:ctx
                                                                   flipped:NO];
    [NSGraphicsContext saveGraphicsState];
    [NSGraphicsContext setCurrentContext:nsGraphicsContext];
    
    // Drawing code here. 
    NSBezierPath* flightPath = [NSBezierPath bezierPath];
    [flightPath setLineWidth:2.0];
    
    NSColor* grey = [NSColor colorWithDeviceRed:.9 green:.9 blue:.9 alpha:.7];
    [grey setStroke];
    [flightPath setLineCapStyle:NSRoundLineCapStyle];
    
    NSInteger vectorX = first.x - second.x;
    NSInteger vectorY = first.y - second.y;
    
    // Buffer origin
    CGPoint start = CGPointMake(2, 2);
    if (vectorX < 0)
    {
        start.x += vectorX * -1;
        vectorX = 0;
    }
    
    if (vectorY < 0)
    {
        start.y += vectorY * -1;
        vectorY = 0;
    }
     
    [flightPath moveToPoint:start];
    [flightPath lineToPoint:CGPointMake(vectorX+2, vectorY+2)];
    
    [flightPath stroke];
    
    [NSGraphicsContext restoreGraphicsState];
}

@end
