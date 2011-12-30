//
//  StarMapView.m
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/24/11.
//  Copyright 2011 Roboboogie Studios. All rights reserved.
//

#import "StarMapView.h" 
#import "PlanetPopoverController.h" 
#import "NuIonStormView.h"
#import "NuPlanetView.h"
#import "NuShipView.h"

@implementation StarMapView

@synthesize planets, player, ionStorms, ships;

- (id)initWithTurn:(NuTurn*)trn
{
    self.ionStorms = trn.ionStorms;
    self.planets = trn.planets;
    self.player = trn.player;
    self.ships = trn.ships;
    
    NSRect smvFrame = CGRectMake(0, 0, 4000, 4000);
    
    return [self initWithFrame:smvFrame];
}

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        if (self.ionStorms != nil)
        {
            [self addIonStorms];
        }
        
        if (self.planets != nil)
        {
            [self addPlanets];
        }
        
        if (self.ships != nil)
        {
            [self addShips];
        }
    }
    
    return self;
}

- (void)addShips
{
    for (NuShip* ship in self.ships)
    {
        NuShipView* sv = [[[NuShipView alloc] initWithShip:ship] autorelease];
        sv.player = self.player;
        
        [self addSubview:sv];
    }
}

- (void)addPlanets
{
    for (NuPlanet* planet in self.planets)
    {
        NuPlanetView* pv = [[[NuPlanetView alloc] initWithPlanet:planet] autorelease];
        pv.player = self.player;
        
        [self addSubview:pv];
    }
}

- (void)addIonStorms
{
    
    for (NuIonStorm* storm in ionStorms)
    {
        NuIonStormView* isv = [[[NuIonStormView alloc] initWithIonStorm:storm] autorelease];
       
        [self addSubview:isv];
    }
}

- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.
    CGContextRef myContext = [[NSGraphicsContext // 1
                               currentContext] graphicsPort];
    
    [self drawPlanetaryConnections:myContext];
    
    //[self drawShips:myContext];
    
}

//- (void)drawShips:(CGContextRef)context
//{
//    
//    NSInteger shipRadius = 4;
//    for (NuShip* ship in self.ships)
//    {
//        CGColorRef shipColor =  CGColorCreateGenericRGB(.6, .9, .6, 1);
//        CGContextSetFillColorWithColor(context, shipColor);
//        
//        CGRect rectangle = CGRectMake(ship.x - shipRadius/2,
//                                      ship.y - shipRadius/2,
//                                      shipRadius, shipRadius);
//        CGContextStrokeEllipseInRect(context, rectangle);
//        
//        
//        CGContextStrokePath(context);
//    }
//}

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

- (void)mouseDown:(NSEvent *)theEvent
{
    if (popover != nil)
    {
        [popover.child close];
        [popover release];
        popover = nil;
    }
    
    startOrigin = [self visibleRect].origin;
    // For some reason this is always offset by 25, possibly it's the window origin, not the 
    // scroll box
    CGPoint realLocation = CGPointMake(theEvent.locationInWindow.x + startOrigin.x - 20,
                theEvent.locationInWindow.y + startOrigin.y - 20);

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
