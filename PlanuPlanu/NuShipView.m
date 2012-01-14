//
//  NuShipView.m
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/29/11.
//  Copyright 2011 Roboboogie Studios. All rights reserved.
//

#import "NuShipView.h"

@implementation NuShipView

#define kShipRadius 6
#define kShipAtPlanetRadius 12

@synthesize ships, player, colors;

- (void)setColors:(NuColorScheme *)c
{
    if (colors != nil)
    {
        [colors release];
    }
    
    colors = [c retain];
    
    // TODO: check all ships
    NuShip* baseShip = [self.ships objectAtIndex:0];
    
    if (colors.lastUpdate == baseShip.ownerId)
    {
        [self setNeedsDisplay];
    }
}

- (NSRect)calculateLayerBounds
{
    shipRadius = kShipRadius;
    
    NSRect retVal = CGRectZero;
    
    for (NuShip* ship in ships)
    {
        NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
        
        BOOL expandShipRadiusInWarpWells = [def boolForKey:@"expandShipRadiusInWarpWells"];
        
        double dcp = ship.distanceToClosestPlanet;
        
        if ( (expandShipRadiusInWarpWells == YES 
              && dcp  <= 10)
            || dcp < 1)
        {
            shipRadius = kShipAtPlanetRadius;
        }
        
        NSInteger nextTurnTravel = [ship flightLength];
        if ([def boolForKey:@"shipPathSingleTurn"] == NO)
        {
            nextTurnTravel = pow(ship.warp, 2);
        }
        
        NSInteger viewRadius = shipRadius;
        
        if (ship.heading != -1 && nextTurnTravel > shipRadius)
        {
            viewRadius = nextTurnTravel;
        }
        
        CGRect currentFrame = CGRectMake(ship.x - viewRadius,
                                      ship.y - viewRadius,
                                      viewRadius*2, viewRadius*2);
        
        if (currentFrame.size.width * currentFrame.size.height > retVal.size.width * retVal.size.height)
        {
            retVal = currentFrame;
        }
    }
    
    return retVal;
}

- (id)initWithShip:(NuShip*)s
{
    self.ships = [NSMutableArray array];
    [self.ships addObject:s];
    
    // TODO: check all ships
    NuShip* baseShip = [self.ships objectAtIndex:0];
    
    self.identifier = baseShip.shipId;
    
    NSRect rectangle = [self calculateLayerBounds];
    
    [self init];
    self.frame = rectangle;
    
    return self;
}

 

- (id)hitTest:(NSPoint)aPoint
{
    // pass-through events that don't hit one of the visible subviews
    CGPoint center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
      
    NSPoint local_point = [self convertPoint:aPoint fromLayer:[self superlayer]];
    
    CGFloat distX = center.x - local_point.x;
    CGFloat distY = center.y - local_point.y;
    
    CGFloat dist = sqrt(pow(distX, 2) + pow(distY, 2));
    
    if ((NSInteger)dist <= shipRadius)
    {
        return self;
    }
    
    return nil;
}

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
    
    
    for (NuShip* ship in self.ships) // TODO: this draws ships on top of each other
    {
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
            
            NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
            
            NSInteger flightLength = [ship flightLength];
            BOOL shipPathSingleTurn = [def boolForKey:@"shipPathSingleTurn"];
            if (shipPathSingleTurn == NO)
            {
                flightLength = pow(ship.warp, 2);
            }
        
                  
            CGPoint endPoint = CGPointZero;
            
            
            if ( shipPathSingleTurn == YES &&
                (ship.targetX >= 0 && ship.targetY >= 0) )
            {
                // Targets give us exact points
                endPoint = CGPointMake(ship.targetX - ship.x,
                                       ship.targetY - ship.y);
            }
            else
            {
                endPoint = CGPointMake(flightLength * sin(ship.heading*pi/180), 
                                           flightLength * cos(ship.heading*pi/180));
            }
            endPoint.x += centerBorder;
            endPoint.y += centerBorder;
            
            endPoint.x = round(endPoint.x);
            endPoint.y = round(endPoint.y);
            
            CGFloat pattern = 4.0;
            // TODO: check the HYP capability
            if (flightLength == 350 && [ship.friendlyCode isEqualToString:@"HYP"])
            {
                [flightPath setLineDash:&pattern count:1 phase:0];
            }
            
            [flightPath lineToPoint:endPoint];
            [flightPath stroke];
        }   
    }
    
    [NSGraphicsContext restoreGraphicsState];
}


- (void)addShip:(NuShip*)ship
{
    [self.ships addObject:ship];
    
    self.frame = [self calculateLayerBounds];
}

@end
