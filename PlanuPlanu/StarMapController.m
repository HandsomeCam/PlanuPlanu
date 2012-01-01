//
//  StarMapController.m
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/23/11.
//  Copyright 2011 Roboboogie Studios. All rights reserved.
//

#import "StarMapController.h"
#import "StarMapView.h"

@implementation StarMapController

@synthesize turn;
@synthesize mapScroll;
@synthesize planetToolBarButton, shipToolBarButton;
@synthesize stormToolBarButton, connectionToolBarButton, visibilityToolBarButton;

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    
    if (turn != nil)
    {
        [self initStarMapView];
        [self initToolBar];
    }
}

- (void)initToolBar
{
    [planetToolBarButton setState:NSOnState];
    [shipToolBarButton setState:NSOnState];
    [stormToolBarButton setState:NSOnState];
    [connectionToolBarButton setState:NSOffState];
    [visibilityToolBarButton setState:NSOffState];
}

- (void)initStarMapView
{ 
    starMap = [[StarMapView alloc] initWithTurn:turn];
    
    starMap.planets = turn.planets;
    starMap.player = turn.player;
    starMap.ionStorms = turn.ionStorms;
    starMap.ships = turn.ships;
    
    [starMap setScanRangeHidden:YES];
    [starMap setConnectionsHidden:YES];
    
    [mapScroll setHasHorizontalScroller:YES];
    [mapScroll setHasVerticalScroller:YES];
    
    [mapScroll setDocumentView:starMap];
    [starMap scrollToHomeWorld];
}

- (IBAction)colorToolBarClicked:(id)sender
{
    
}

- (IBAction)planetToolBarClicked:(id)sender
{
    [starMap setPlanetsHidden:(((NSButton*)sender).state == NSOffState)];
}

- (IBAction)shipToolBarClicked:(id)sender
{
    [starMap setShipsHidden:(((NSButton*)sender).state == NSOffState)];
}

- (IBAction)stormToolBarClicked:(id)sender
{
    [starMap setStormsHidden:(((NSButton*)sender).state == NSOffState)];
}

- (IBAction)connectionToolBarClicked:(id)sender
{
    [starMap setConnectionsHidden:(((NSButton*)sender).state == NSOffState)];
}


- (IBAction)visibilityToolBarClicked:(id)sender
{
    [starMap setScanRangeHidden:(((NSButton*)sender).state == NSOffState)];
}

@end
