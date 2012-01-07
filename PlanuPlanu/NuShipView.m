//
//  NuShipView.m
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/29/11.
//  Copyright 2011 Roboboogie Studios. All rights reserved.
//

#import "NuShipView.h"

@implementation NuShipView

@synthesize ship, player, colors, delegate;

- (void)setColors:(NuColorScheme *)c
{
    if (colors != nil)
    {
        [colors release];
    }
    
    colors = [c retain];
    
    if (colors.lastUpdate == ship.ownerId)
    {
        [self setNeedsDisplay];
    }
}

- (id)initWithShip:(NuShip*)s
{
    self.ship = s;
    self.identifier = self.ship.shipId;
    
    shipRadius = 6;
    
    if (ship.distanceToClosestPlanet <= 10)
    {
        shipRadius *= 2;
    }
    
    NSInteger nextTurnTravel = [self.ship flightLength];
    
    NSInteger viewRadius = shipRadius;
    
    if (ship.heading != -1 && nextTurnTravel > shipRadius)
    {
        viewRadius = nextTurnTravel;
    }
    
    CGRect rectangle = CGRectMake(ship.x - viewRadius,
                                  ship.y - viewRadius,
                                  viewRadius*2, viewRadius*2);
    
    [self init];
    self.frame = rectangle;
    
    return self;
}

 

//- (NSView *)hitTest:(NSPoint)aPoint
//{
//    // pass-through events that don't hit one of the visible subviews
//    CGPoint center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
//      
//    NSPoint local_point = [self convertPoint:aPoint fromView:nil];
//    
//    CGFloat distX = self.ship.x - aPoint.x;
//    CGFloat distY = self.ship.y - aPoint.y;
//    
//    CGFloat dist = sqrt(pow(distX, 2) + pow(distY, 2));
//    
//    if (self.ship.shipId == 182)
//    {
//        NSLog(@"Dist: %lf ap: (%lf, %lf) LP: (%lf, %lf)", dist, aPoint.x, aPoint.y, local_point.x, local_point.y);
//    }
//    
//    if ((NSInteger)dist <= shipRadius)
//    {
//        return self;
//    }
//    
//    return nil;
//}

- (void)drawInContext:(CGContextRef)ctx
{
    NSGraphicsContext *nsGraphicsContext;
    nsGraphicsContext = [NSGraphicsContext graphicsContextWithGraphicsPort:ctx
                                                                   flipped:NO];
    [NSGraphicsContext saveGraphicsState];
    [NSGraphicsContext setCurrentContext:nsGraphicsContext];
    
    NSInteger centerBorder = self.frame.size.width / 2;
    NSInteger outerOrigin = centerBorder - (shipRadius);
    
    CGRect shipRect = CGRectMake(outerOrigin+2, outerOrigin+2, (shipRadius*2)-4, (shipRadius*2)-4);
    
    if (self.colors == nil)
    {
        if (ship.ownerId == player.playerId)
        {
            [[NSColor greenColor] setStroke]; 
        }
        else
        {
            [[NSColor redColor] setStroke]; 
        }
    }
    else
    {
        [[self.colors colorForPlayer:ship.ownerId] setStroke];
    }
    
    NSBezierPath* circlePath = [NSBezierPath bezierPathWithOvalInRect:shipRect];
    [circlePath setLineWidth:2.0];
    
    [circlePath stroke];
    
    
    if (ship.heading != -1 && ship.warp > 0)
    {
        NSBezierPath* flightPath = [NSBezierPath bezierPath];
        [flightPath setLineWidth:2.0];
        
        [flightPath moveToPoint:CGPointMake(centerBorder, centerBorder)];
        NSInteger flightLength = [ship flightLength];
              
        CGPoint endPoint = CGPointMake(flightLength * sin(ship.heading*pi/180), 
                                       flightLength * cos(ship.heading*pi/180));
        
        endPoint.x += centerBorder;
        endPoint.y += centerBorder;
        
        CGFloat pattern = 4.0;
        // TODO: check the HYP capability
        if (flightLength == 350 && [self.ship.friendlyCode isEqualToString:@"HYP"])
        {
            [flightPath setLineDash:&pattern count:1 phase:0];
        }
        
        [flightPath lineToPoint:endPoint];
        [flightPath stroke];
    }   
    
    [NSGraphicsContext restoreGraphicsState];
}
//
//- (void)mouseDown:(NSEvent *)theEvent
//{
//    if (self.delegate != nil)
//    {
//        CGPoint center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
//        
//        CGPoint liw = theEvent.locationInWindow;
//        NSPoint local_point = [self convertPoint:theEvent.locationInWindow fromView:nil];
//        
//        CGFloat distX = center.x - local_point.x;
//        CGFloat distY = center.y - local_point.y;
//        
//        CGFloat dist = sqrt(pow(distX, 2) + pow(distY, 2));
//        
//        if ((NSInteger)dist <= shipRadius)
//        {
//            [delegate shipSelected:self atLocation:theEvent.locationInWindow];
//            [self findNextSiblingBelowEventLocation:theEvent];
//            
//        }
//    }
//    
//    return;
//}

@end
