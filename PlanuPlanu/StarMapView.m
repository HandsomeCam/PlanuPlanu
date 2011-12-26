//
//  StarMapView.m
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/24/11.
//  Copyright 2011 Roboboogie Studios. All rights reserved.
//

#import "StarMapView.h"
#import "NuPlanet.h"
#import "PlanetPopoverController.h"

@implementation StarMapView

@synthesize planets, player, ionStorms;

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
    CGContextRef myContext = [[NSGraphicsContext // 1
                               currentContext] graphicsPort];
    
    // Add bg
    CGContextSetRGBFillColor (myContext, 0, 0, 0, 1);// 3
    CGContextFillRect (myContext, CGRectMake (0, 0, 4000, 4000 ));// 4
    
    
//    // ********** Your drawing code here ********** // 2
//    CGContextSetRGBFillColor (myContext, 1, 0, 0, 1);// 3
//    CGContextFillRect (myContext, CGRectMake (0, 0, 200, 100 ));// 4
//    CGContextSetRGBFillColor (myContext, 0, 0, 1, .5);// 5
//    CGContextFillRect (myContext, CGRectMake (0, 0, 100, 200)); // 6
    
    [self drawPlanetaryConnections:myContext];
    [self drawPlanets:myContext];
    [self drawIonStorms:myContext];
}

- (void)drawPlanetaryConnections:(CGContextRef)context
{
    // NSMutableArray* connections = [NSMutableArray array];
    for (int i=0; i < [planets count]; i++)
    {
        NuPlanet* a = [planets objectAtIndex:i];
        
        for (int j=i+1; j < [planets count]; j++)
        {
            NuPlanet* b = [planets objectAtIndex:j];
            
            NSInteger x = a.x - b.x;
            NSInteger y = a.y - b.y;
            
            double len = sqrt(x*x + y*y);
            
            if (len <= 81)
            {
                // add connection
                CGContextSetLineWidth(context, 2.0);
                CGColorRef grey = CGColorCreateGenericRGB(.9, .9, .9, .7);
                CGContextSetStrokeColorWithColor(context, grey);
                CGContextMoveToPoint(context, a.x, a.y);
                CGContextAddLineToPoint(context, b.x, b.y);
                CGContextStrokePath(context);
            }
        }
    }
}

- (void)drawIonStorms:(CGContextRef)context
{
    // Draw Circle 
    CGContextSetLineWidth(context, 1.0);
    CGColorRef thickYellow = CGColorCreateGenericRGB(.7, .9, 0, .7);
    
    
    for (NuIonStorm* storm in ionStorms)
    {
        
        CGColorRef yellow =  CGColorCreateGenericRGB(.5 + (.01 * storm.voltage), .9, 0, .5);
        CGContextSetFillColorWithColor(context, yellow);
        
        CGRect rectangle = CGRectMake(storm.x - storm.radius,
                                      storm.y - storm.radius,
                                      storm.radius*2, storm.radius*2);
        CGContextFillEllipseInRect(context, rectangle);
    
        CGContextStrokePath(context);
        
        // draw heading line
        CGContextSetStrokeColorWithColor(context, thickYellow);
        CGContextSetLineWidth(context, 1.0);
        CGContextMoveToPoint(context, storm.x, storm.y);
        
        NSInteger headingLength = storm.warp * storm.warp;
        
        CGPoint endPoint; 
        
        endPoint.x = headingLength * sin(storm.heading) + storm.x;
        endPoint.y = headingLength * cos(storm.heading) + storm.y;
        
        CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
        CGContextStrokePath(context);
    }
}

- (void)drawPlanets:(CGContextRef)context
{
//    CGRect visibleRect = [self visibleRect];
     
    // Draw Circle 
    CGContextSetLineWidth(context, 2.0);
    
    CGColorRef grey =  CGColorCreateGenericRGB(.9, .9, .9, 1);
    CGColorRef green = CGColorCreateGenericRGB(.1, 1, .2, 1);
    
    
    for (NuPlanet* planet in planets)
    {
//        if (planet.x >= visibleRect.origin.x
//            && planet.y >= visibleRect.origin.y
//            && planet.x <= (visibleRect.origin.x + visibleRect.size.width)
//            && planet.y <= (visibleRect.origin.y + visibleRect.size.height))
//        {
            
        if (planet.ownerId == player.playerId)
        {
            CGContextSetFillColorWithColor(context, green);
        }
        else
        {
            CGContextSetFillColorWithColor(context, grey);
        }
            
        CGRect rectangle = CGRectMake(planet.x -5 ,planet.y -5,10, 10);
        
        if (planet.starbase == nil)
        {
            CGContextFillEllipseInRect(context, rectangle);
        }
        else
        {
            CGContextFillRect(context, rectangle);
        }
        
        CGContextStrokePath(context);
//        }
    }
   
}

- (void)mouseDown:(NSEvent *)theEvent
{
    if (popover != nil)
    {
        [popover.child close];
        [popover release];
        popover = nil;
    }
    
    startOrigin = [self visibleRect].origin;
//    CGPoint absOrigin = self.bounds.origin;
//    NSClipView* cv = self.superview;
//    
//    CGPoint dvr = [cv documentVisibleRect].origin;
   
    // For some reason this is always offset by 25, possibly it's the window origin, not the 
    // scroll box
    CGPoint realLocation = CGPointMake(theEvent.locationInWindow.x + startOrigin.x - 20,
                theEvent.locationInWindow.y + startOrigin.y - 20);
    
    // pl.x = 1177
    // pl.y = 1021
    // rl.x == 1205
    // rl.y == 1044
    // el.x == 509
    // el.y == 401
    // so.x == 694
    // so.y == 645
    
    // rl - pl = (28, 23)
    
    for (NuPlanet* planet in planets)
    {
        if ( (abs(realLocation.x - planet.x) < 10)
            && (abs(realLocation.y - planet.y) < 10) )
        {
            [self showPlanetPopover:planet];
            break;
        }
    }
    
    
    startPt = theEvent.locationInWindow;
    
    return;
}

- (void)scrollToHomeWorld
{
    NuPlanet* probableHomeworld = nil;
    
    for (NuPlanet* planet in planets)
    {
        if (planet.ownerId == player.playerId)
        {
            if (probableHomeworld == nil)
            {
                probableHomeworld = planet;
            }
            else if (planet.starbase != nil)
            {
                if (probableHomeworld.starbase == nil)
                {
                    probableHomeworld = planet;
                }
                else if (probableHomeworld.clans < planet.clans)
                {
                    probableHomeworld = planet;
                }
            }
        }
    }
    
    CGPoint hwPoint = CGPointMake(probableHomeworld.x, probableHomeworld.y);
    
    CGRect visible = [self visibleRect];
    
    CGPoint scrollPoint = CGPointMake(hwPoint.x - (visible.size.width / 2),
                                      hwPoint.y - (visible.size.height / 2));
    
    [self scrollPoint:scrollPoint];
}

- (void)showPlanetPopover:(NuPlanet*)planet
{
    NSPopover* planetPopover = [[NSPopover alloc] init];
  
    CGRect planetRect = CGRectMake(planet.x - 5, planet.y - 5, 10, 10);
    
    PlanetPopoverController* ppc = [[PlanetPopoverController alloc] initWithNibName:@"PlanetPopover" bundle:nil];
    planetPopover.contentViewController = [ppc autorelease];
    planetPopover.delegate = ppc;
    ppc.planet = planet;
    planetPopover.behavior = NSPopoverBehaviorTransient;
    ppc.child = planetPopover;
    
    [planetPopover showRelativeToRect:planetRect
                         ofView:self 
                  preferredEdge:NSMinYEdge];
    popover = [ppc retain];
}

- (void)mouseDragged:(NSEvent *)theEvent
{
    CGPoint scrollPoint =  NSMakePoint(startOrigin.x - ([theEvent locationInWindow].x -
                                                        startPt.x),
                                       startOrigin.y - ([theEvent locationInWindow].y -
                                                        startPt.y));
    
    [self scrollPoint:scrollPoint];
}

@end
