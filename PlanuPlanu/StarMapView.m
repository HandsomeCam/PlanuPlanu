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
#import "NuPlanetaryConnectionView.h"

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
        
        ScanRangeVisibilityView* srvv = 
            [[[ScanRangeVisibilityView alloc] initWithFrame:frame 
                                                    forTurn:self.turn] autorelease];
        [self addSubview:srvv];
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
    
    return self;
}

- (void)addShips
{
    NSMutableArray* svs = [NSMutableArray array];
    
    for (NuShip* ship in self.ships)
    {
        NuShipView* sv = [[[NuShipView alloc] initWithShip:ship] autorelease];
        sv.player = self.player;
        
        [self addSubview:sv];
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
        
        [self addSubview:pv];
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
                [self addSubview:pcv];
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
       
        [self addSubview:isv];
        [isvs addObject:isv];
    }
    
    self.stormViews = isvs;
}

- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.
    
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
    
    [self setNeedsDisplay:YES];
}

@end
