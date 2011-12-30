//
//  NuIonStormView.m
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/29/11.
//  Copyright 2011 Roboboogie Studios. All rights reserved.
//

#import "NuIonStormView.h"
#include <stdlib.h>

@implementation NuIonStormView

@synthesize storm;

- (id)initWithIonStorm:(NuIonStorm*)ionStorm;
{
    self.storm = ionStorm;
    
    NSRect rect = CGRectMake(storm.x - storm.radius,
                             storm.y - storm.radius,
                             storm.radius*2, 
                             storm.radius*2);    
    
    // Create lightning
    
    // Add lightning
    NSMutableArray* lt = [NSMutableArray array];
    
    for (int i=0; i <  storm.radius/6; i++) // i was 10
    {
        NSInteger r = arc4random() % 34;
        
        NSInteger endHeading = r + storm.heading + 10 + (34 * i);

        NSInteger endX = storm.radius * sin(endHeading*pi/180) + storm.radius;
        NSInteger endY = storm.radius * cos(endHeading*pi/180) + storm.radius;
        
        NSArray *path = 
        [self drawLightningFrom:CGPointMake(storm.radius, storm.radius)
                             to:CGPointMake(endX, endY)
                    displacedBy:50];
        [lt addObject:path];
        
    }
    
    lightning = [lt retain];
    
    return [self initWithFrame:rect];
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
    CGContextRef context = [[NSGraphicsContext // 1
                               currentContext] graphicsPort];
    
//    //    // Add bg
//    CGContextSetRGBFillColor (context, 0, 0, 1, 1);// 3
//    CGContextFillRect (context, dirtyRect);// 4

    CGRect stormRect = CGRectMake(0,0,self.frame.size.width, self.frame.size.height);
    
    CGContextSetLineWidth(context, 1.0);
    CGColorRef thickYellow = CGColorCreateGenericRGB(.7, .9, 0, .7);
    
    CGColorRef yellow = CGColorCreateGenericRGB(.5 + (.01 * storm.voltage), .9, 0, .5);
    CGContextSetFillColorWithColor(context, yellow);
     
    CGContextFillEllipseInRect(context, stormRect);
    
    CGContextStrokePath(context);
    
    // draw heading line
    CGContextSetStrokeColorWithColor(context, thickYellow);
    CGContextSetLineWidth(context, 2.0);
    
    NSInteger centerX = storm.radius;
    NSInteger centerY = storm.radius;
    CGContextMoveToPoint(context, centerX, centerY);
    
    double headingLength = pow(storm.warp, 2); 
    CGPoint endPoint; 
    double headingX = sin(storm.heading * pi/180) * headingLength;
    double headingY = cos(storm.heading * pi/180) * headingLength;
    endPoint.x = headingX + centerX;
    endPoint.y = headingY + centerY;
    
    CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
    CGContextStrokePath(context);
        
    for (NSArray *path in lightning)
    {
        CGColorRef lightningColor = CGColorCreateGenericRGB(.95, .95, 0, .2);        
        CGContextSetLineWidth(context, 1.8);
        CGContextSetStrokeColorWithColor(context, lightningColor);
        
        CGContextMoveToPoint(context, storm.radius, storm.radius);
        
        for (NSString* step in path)
        {
            NSArray* pts = [step componentsSeparatedByString:@","];
            CGFloat pathX = [[pts objectAtIndex:0] doubleValue];
            CGFloat pathY = [[pts objectAtIndex:1] doubleValue];
            CGContextAddLineToPoint(context, pathX, pathY);
        }
        
        CGContextStrokePath(context);
    }
}



- (NSArray*)drawLightningFrom:(CGPoint)start to:(CGPoint)finish displacedBy:(NSInteger)displacement
{ 
    NSInteger curDetail = 2;
    
    if (displacement < curDetail)
    {
        return [NSArray arrayWithObjects:[NSString stringWithFormat:@"%lf,%lf", finish.x, finish.y], nil];
    }
    else 
    {
        CGPoint mid;
        CGFloat midRadius;
        
        do
        {
            NSInteger mid_x = (finish.x + start.x)/2;
            NSInteger mid_y = (finish.y + start.y)/2;
            
            NSInteger ri1 = (arc4random() % 100);
            NSInteger ri2 = (arc4random() % 100);
            
            double r1 =  ((double)ri1) / 100;
            double r2 =  ((double)ri2) / 100;
            
            mid_x += (r1-.5)*displacement;
            mid_y += (r2-.5)*displacement;
            
            mid = CGPointMake(mid_x, mid_y);
            
            midRadius = sqrt(pow(mid_x-storm.radius,2) + pow(mid_y-storm.radius,2));
        } while (midRadius >= storm.radius);
        
        
        NSMutableArray* retVal = [NSMutableArray array];
        [retVal addObjectsFromArray:[self drawLightningFrom:start 
                             to:mid 
                    displacedBy:displacement/2]];
        
        [retVal addObjectsFromArray:[self drawLightningFrom:mid 
                             to:finish 
                    displacedBy:displacement/2]]; 
        
        return retVal;
        
    }

}

@end
