//
//  NuShipView.m
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/29/11.
//  Copyright 2011 Roboboogie Studios. All rights reserved.
//

#import "NuShipView.h"

@implementation NuShipView

@synthesize ship, player;

- (id)initWithShip:(NuShip*)s
{
    self.ship = s;
    
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
    NSInteger centerBorder = self.frame.size.width / 2;
    NSInteger outerOrigin = centerBorder - (shipRadius);
    
    CGRect shipRect = CGRectMake(outerOrigin+2, outerOrigin+2, (shipRadius*2)-4, (shipRadius*2)-4);
    
    if (ship.ownerId == player.playerId)
    {
        [[NSColor greenColor] setStroke]; 
    }
    else
    {
        [[NSColor redColor] setStroke]; 
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
}

@end
