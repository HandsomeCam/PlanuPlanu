//
//  NuPlanetaryConnectionView.m
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/31/11.
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
