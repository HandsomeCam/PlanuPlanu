//
//  StarMapView.m
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/24/11.
//  Copyright 2011 Roboboogie Studios. All rights reserved.
//

#import <QuartzCore/CoreAnimation.h>

#import "StarMapView.h" 
#import "PlanetPopoverController.h" 
#import "NuIonStormView.h"
#import "NuPlanetView.h"
#import "NuShipView.h"
#import "NuPlanetaryConnectionView.h"
#import "MapMuxPopoverController.h"
#import "NuMinefieldLayer.h"

@implementation StarMapView

@synthesize planets, player, ionStorms, ships, turn;
@synthesize planetViews, shipViews, stormViews, connectionViews, mineLayers;
@synthesize scanRangeView, colorScheme, delegate;

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

- (void)setMinefieldsHidden:(BOOL)visibility
{
    for (NuMinefieldLayer* mfl in self.mineLayers)
    {
        [mfl setHidden:visibility];
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
        
        viewsByLocation = [[NSMutableDictionary dictionary] retain];
        
        if (self.ionStorms != nil)
        {
            [self addIonStorms];
        }
        
        if (turn.minefields != nil)
        {
            [self addMinefields];
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
 
- (void)addShips
{
    NSMutableArray* svs = [NSMutableArray array];
    
    for (NuShip* ship in self.ships)
    {
        BOOL newShip = YES;
         
        NSPoint loc;
        loc.x = ship.x;
        loc.y = ship.y;
        NSValue* locVal = [NSValue valueWithPoint:loc];
        
        if ([viewsByLocation objectForKey:locVal] == nil)
        {
            [viewsByLocation setObject:[NSMutableArray array]
                               forKey:locVal];
        }
        
        
        for (NuMappableEntityLayer* layer in
             [viewsByLocation objectForKey:locVal])
        {
            if ([layer isKindOfClass:[NuShipView class]])
            {
                NuShipView* nsv = (NuShipView*)layer;
                [nsv addShip:ship];
                newShip = NO;
            }
        }
        
        if (newShip == YES)
        {
            NuShipView* sv = [[[NuShipView alloc] initWithShip:ship] autorelease];
            sv.player = self.player; 
            
            NSMutableArray* arr = [viewsByLocation objectForKey:locVal];
            [arr addObject:sv];
            
            [self.layer addSublayer:sv];
            //sv.delegate = self;
            [sv setNeedsDisplay];
            [svs addObject:sv];
        }
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
        
        NSPoint loc;
        loc.x = planet.x;
        loc.y = planet.y;
        NSValue* locVal = [NSValue valueWithPoint:loc];
        
        if ([viewsByLocation objectForKey:locVal] == nil)
        {
            [viewsByLocation setObject:[NSMutableArray array]
                                forKey:locVal];
        }
        
        NSMutableArray* arr = [viewsByLocation objectForKey:locVal];
        [arr addObject:pv];
        
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

- (void)addMinefields
{
    NSMutableArray* mfs = [NSMutableArray array];
    
    for (NuMinefield* mf in turn.minefields)
    {
        NuMinefieldLayer* mfl = [[[NuMinefieldLayer alloc] initWithMinefield:mf] autorelease];
        mfl.player = self.player;
        
        [self.layer addSublayer:mfl];
        [mfl setNeedsDisplay];
        [mfs addObject:mfl];
    }
    
    self.mineLayers = mfs;
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
  
//    CGRect planetRect = CGRectMake(planet.x - 5, planet.y - 5, 10, 10);
    
    PlanetPopoverController* ppc = [[PlanetPopoverController alloc] initWithNibName:@"PlanetPopover" bundle:nil];
    planetPopover.contentViewController = [ppc autorelease];
    planetPopover.delegate = ppc;
    planetPopover.appearance = NSPopoverAppearanceHUD;
    
    ppc.planet = planet;
    planetPopover.behavior = NSPopoverBehaviorTransient;
    ppc.child = planetPopover;
    
    NSRect f = NSMakeRect(planet.x, planet.y, 1, 1);
    
    [planetPopover showRelativeToRect:f
                         ofView:self 
                  preferredEdge:NSMinYEdge];
    popover = [ppc retain];
}

- (void)showShipPopover:(NuShip*)ship
{
    NSPopover* shipPopover = [[NSPopover alloc] init];
    
    //    CGRect planetRect = CGRectMake(planet.x - 5, planet.y - 5, 10, 10);
    
    ShipPopoverController* ppc = [[ShipPopoverController alloc] initWithNibName:@"ShipPopover" bundle:nil];
    shipPopover.contentViewController = [ppc autorelease];
    shipPopover.delegate = ppc;
    shipPopover.appearance = NSPopoverAppearanceHUD;
    
    ppc.ship = ship;
    shipPopover.behavior = NSPopoverBehaviorTransient;
    ppc.child = shipPopover;
    
    NSRect f = NSMakeRect(ship.x, ship.y, 1, 1);
    
    [shipPopover showRelativeToRect:f
                               ofView:self 
                        preferredEdge:NSMinYEdge];
    shipover = [ppc retain];
}

- (void)showMultiplexPopover:(NSArray*)entities at:(NSRect)popFrame
{
    NSPopover* muxPopover = [[NSPopover alloc] init];
      
    MapMuxPopoverController* mmpc = [[MapMuxPopoverController alloc] initWithNibName:@"MapMuxPopover" bundle:nil];
    
    [muxPopover setAnimates:YES];
    muxPopover.appearance = NSPopoverAppearanceHUD;
    muxPopover.contentViewController = [mmpc autorelease];
    muxPopover.delegate = mmpc;
    
    //    
    mmpc.entities = entities;
    mmpc.turn = self.turn;
    mmpc.delegate = self;
    mmpc.child = [muxPopover autorelease];
    //    
    
    muxPopover.behavior = NSPopoverBehaviorTransient;
      // mmpc.child = planetPopover;
     
    [muxPopover showRelativeToRect:popFrame
                            ofView:self 
                       preferredEdge:NSMinYEdge];
    muxover = [mmpc retain];
   
} 


- (void)mouseDown:(NSEvent *)theEvent
{
    // This is used for dragging the map
    startOrigin = [self visibleRect].origin;
    startPt = theEvent.locationInWindow;
    
    NSPoint scPt = [[self enclosingScrollView] convertPointFromBase:startPt];
     
    NSRect vr = self.visibleRect;
 
    NSPoint reflection = NSMakePoint(scPt.x, vr.size.height - scPt.y);
 
    NSPoint refLayerPt = [self.layer convertPoint:reflection fromLayer:nil];
     
    NSMutableArray* entities = [NSMutableArray array];
    
    NSRect r = CGRectZero;
    
    for (NSArray* vws in [viewsByLocation allValues])
    {
        for (NuMappableEntityLayer* layer in vws)
        {
            if ([layer isKindOfClass:[NuPlanetView class]])
            {
                NuPlanetView* pv = (NuPlanetView*)layer;
                
                r = pv.frame;
                
                NuPlanet* pl = pv.planet;
               
                if ([pv hitTest:refLayerPt])
                {
                     NSLog(@"HIT! %@: (%ld, %ld)", pl.name, pl.x, pl.y);
                    [entities addObject:pl];
                }
            }
            
            if ([layer isKindOfClass:[NuShipView class]] == YES)
            {
                NuShipView* sv = (NuShipView*)layer;
                if ([sv hitTest:refLayerPt])
                {
                    for (NuShip* ship in sv.ships)
                    {
                        NSLog(@"HIT! %@: (%ld, %ld)", ship.name, ship.x, ship.y);
                        [entities addObject:ship];
                    }
                }
            }
            
            // TODO: ion storms
            
            // TODO: minefields
        }
        
    }
    
    if ([entities count] > 1)
    {
        NuMappableEntity* e = [entities objectAtIndex:0];
        NSRect r = NSMakeRect(e.x, e.y, 1, 1);
        [self showMultiplexPopover:entities at:r];
    }
    else if ([entities count] == 1)
    {
        NuMappableEntity* e = [entities objectAtIndex:0];
        [self entitySelected:e];
    }
    
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
    
    for (NuMinefieldLayer* mfl in self.mineLayers)
    {
        mfl.colors = cs;
    }
}

//- (void)shipSelected:(NuShipView *)sender atLocation:(CGPoint)point
//{
//    startOrigin = [self visibleRect].origin;
//    startPt = point;
//    
//    
//    
//    NSLog(@"Tapped Ship: %@ (%ld)", 
//          sender.ship.name, 
//          sender.ship.shipId);
//}



- (void)entitySelected:(NuMappableEntity *)entity
{
    [muxover.child close];
    
    if ([entity isKindOfClass:[NuPlanet class]])
    {
        [self showPlanetPopover:(NuPlanet*)entity];
    }
    else if ([entity isKindOfClass:[NuShip class]])
    {
        [self showShipPopover:(NuShip*)entity];
    }
}

@end
