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
#import "NuPlanetaryConnectionView.h"
#import <QuartzCore/CoreAnimation.h>

@implementation StarMapView

@synthesize planets, player, ionStorms, ships, turn;
@synthesize planetViews, shipViews, stormViews, connectionViews;
@synthesize scanRangeView, colorScheme;

- (void)setScanRangeHidden:(BOOL)visibility
{
    [self.scanRangeView setHidden:visibility];
}

- (void)setPlanetsHidden:(BOOL)visibility
{
    for (NuPlanetView* pv in self.planetViews)
    {
        [pv setHidden:visibility];
    }
}

- (void)setShipsHidden:(BOOL)visibility
{
    for (NuShipView* ship in self.shipViews)
    {
        [ship setHidden:visibility];
    }
}

- (void)setStormsHidden:(BOOL)visibility
{
    for (NuIonStormView* storm in self.stormViews)
    {
        [storm setHidden:visibility];
    }
}

- (void)setConnectionsHidden:(BOOL)visibility
{
    for (NuPlanetaryConnectionView* cnx in self.connectionViews)
    {
        [cnx setHidden:visibility];
    }
}

- (id)initWithTurn:(NuTurn*)trn
{
    self.turn = trn;
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
        
        CALayer *newLayer = [[CALayer alloc] init];
        newLayer.bounds = self.bounds;
        
        self.layer = newLayer;
        //[[self enclosingScrollView] setLayer:newLayer];
        [self setWantsLayer: YES];
        //[[self enclosingScrollView] setWantsLayer:YES];
        
//        CALayer* bg = [CALayer layer];
//        bg.frame = self.frame;
//        
//        [self setLayer:bg];
//        
        ScanRangeVisibilityView* srvv = 
            [[[ScanRangeVisibilityView alloc] initWithFrame:frame 
                                                    forTurn:self.turn] autorelease
             ];
        [srvv setNeedsDisplay];
        [self.layer addSublayer:srvv];
        
        self.scanRangeView = srvv;
        
        if (self.ionStorms != nil)
        {
            [self addIonStorms];
        }
        
        if (self.planets != nil)
        {
            // connections go first for the Z-order
            [self addPlanetaryConnections];
            
            [self addPlanets];
        }
        
        if (self.ships != nil)
        {
            [self addShips];
        }
    }
    
    [self.layer setNeedsDisplay];
  
    return self;
}

//-(void)displayLayer:(CALayer *)layer
//{
//    CGDataProviderRef data;
//    data = CGDataProviderCreateWithFilename("Compass.png");
//	
//    CGImageRef compass;
//    compass = CGImageCreateWithPNGDataProvider(data, NULL, FALSE, 
//                                               kCGRenderingIntentDefault);
//	
//    layer.contents = compass;
//    layer.contentsGravity = kCAGravityCenter;
//	
//    CGImageRelease(compass);
//    CGDataProviderRelease(data);
//}

- (void)addShips
{
    NSMutableArray* svs = [NSMutableArray array];
    
    for (NuShip* ship in self.ships)
    {
        NuShipView* sv = [[[NuShipView alloc] initWithShip:ship] autorelease];
        sv.player = self.player;
        sv.delegate = self;
        
        [self.layer addSublayer:sv];
        //sv.delegate = self;
        [sv setNeedsDisplay];
        [svs addObject:sv];
    }
    
    self.shipViews = svs;
}

- (void)addPlanets
{
    NSMutableArray* pvs = [NSMutableArray array];
    
    for (NuPlanet* planet in self.planets)
    {
        NuPlanetView* pv = [[[NuPlanetView alloc] initWithPlanet:planet] autorelease];
        pv.player = self.player;
        pv.delegate = self;
          
        [self.layer addSublayer:pv];
        [pv setNeedsDisplay];
        [pvs addObject:pv];
    }
    
    self.planetViews = pvs;
}

- (void)addPlanetaryConnections
{
    NSMutableArray* connections = [NSMutableArray array];
    
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
                NuPlanetaryConnectionView* pcv = 
                    [[NuPlanetaryConnectionView alloc] initWithPlanet:a 
                                                            andPlanet:b];
                [self.layer addSublayer:pcv];
                [pcv setNeedsDisplay];
                [connections addObject:pcv];
            }
        }
    }
    
    self.connectionViews = connections;
}

- (void)addIonStorms
{
    NSMutableArray* isvs = [NSMutableArray array];
    
    for (NuIonStorm* storm in ionStorms)
    {
        NuIonStormView* isv = [[[NuIonStormView alloc] initWithIonStorm:storm] autorelease];
       
        [self.layer addSublayer:isv];
        [isv setNeedsDisplay];
        [isvs addObject:isv];
    }
    
    self.stormViews = isvs;
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

- (void)showPlanetPopover:(NuPlanetView*)planet
{
    NSPopover* planetPopover = [[NSPopover alloc] init];
  
//    CGRect planetRect = CGRectMake(planet.x - 5, planet.y - 5, 10, 10);
    
    PlanetPopoverController* ppc = [[PlanetPopoverController alloc] initWithNibName:@"PlanetPopover" bundle:nil];
    planetPopover.contentViewController = [ppc autorelease];
    planetPopover.delegate = ppc;
    ppc.planet = planet.planet;
    planetPopover.behavior = NSPopoverBehaviorTransient;
    ppc.child = planetPopover;
    
    [planetPopover showRelativeToRect:planet.frame
                         ofView:self 
                  preferredEdge:NSMinYEdge];
    popover = [ppc retain];
}

- (void)mouseDown:(NSEvent *)theEvent
{
    // This is used for dragging the map
    startOrigin = [self visibleRect].origin;
    startPt = theEvent.locationInWindow;
    
    return;
}

- (void)mouseDragged:(NSEvent *)theEvent
{
    CGPoint scrollPoint =  NSMakePoint(startOrigin.x - ([theEvent locationInWindow].x -
                                                        startPt.x),
                                       startOrigin.y - ([theEvent locationInWindow].y -
                                                        startPt.y));
    
    [self scrollPoint:scrollPoint];
}


- (void)setColorScheme:(NuColorScheme*)cs
{
    if (colorScheme != nil)
    {
        [colorScheme release];
    }
    colorScheme = [cs retain];
    
    for (NuPlanetView* pl in self.planetViews)
    {
        pl.colors = cs;
    }
    
    for (NuShipView* sv in self.shipViews)
    {
        sv.colors = cs;
    }
}

- (void)shipSelected:(NuShipView *)sender atLocation:(CGPoint)point
{
    startOrigin = [self visibleRect].origin;
    startPt = point;
    
    NSLog(@"Tapped Ship: %@ (%ld)", sender.ship.name, sender.ship.shipId);
}

- (void)planetSelected:(NuPlanetView *)sender atLocation:(CGPoint)point
{
    startOrigin = [self visibleRect].origin;
    startPt = point;
    
    if (popover != nil)
    {
        [popover.child close];
        [popover release];
        popover = nil;
    }
    
     
    [self showPlanetPopover:sender];
          
    
    return;
    
}

@end
