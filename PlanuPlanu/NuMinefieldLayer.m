//
//  NuMinefieldLayer.m
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 1/11/12.
//  Copyright (c) 2012 Roboboogie Studios. All rights reserved.
//

#import "NuMinefieldLayer.h"

@implementation NuMinefieldLayer

@synthesize minefield, player, colors;

- (id)initWithMinefield:(NuMinefield*)mf
{
    self.minefield = mf;
    CGRect rectangle = CGRectMake(mf.x - mf.radius,
                                  mf.y - mf.radius,
                                  mf.radius*2, mf.radius*2);
    
    //self.identifier = self.minefield.minefieldId;
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
    
    if (colors.lastUpdate == minefield.ownerId
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
    
    NSBezierPath *minePath;
 
    minePath = [NSBezierPath bezierPathWithOvalInRect:planetRect];
    
    [minePath setLineWidth:0.0];
    
    NSColor* color;
    
    if (colors == nil)
    {
        if (minefield.ownerId == player.playerId)
        {
            color = [NSColor greenColor]; 
        }
        else
        {
            color = [NSColor redColor]; 
        }
    }
    else
    {
        if (minefield.ownerId > 0)
        {
             color = [self.colors colorForPlayer:minefield.ownerId];
        }
        else
        {
            color = [NSColor grayColor];
        }
    }    
    
    color = [color colorUsingColorSpaceName:NSCalibratedRGBColorSpace];
    color = [NSColor colorWithSRGBRed:color.redComponent
                                green:color.greenComponent
                                 blue:color.blueComponent
                                alpha:.2];
    [color setFill];
    
    [minePath fill];
    
    [NSGraphicsContext restoreGraphicsState];
}


@end
