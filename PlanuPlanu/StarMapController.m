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
    }
}

- (void)initStarMapView
{ 
    StarMapView* smv = [[StarMapView alloc] initWithTurn:turn];
    
    smv.planets = turn.planets;
    smv.player = turn.player;
    smv.ionStorms = turn.ionStorms;
    smv.ships = turn.ships;
    
    [mapScroll setHasHorizontalScroller:YES];
    [mapScroll setHasVerticalScroller:YES];
    
    [mapScroll setDocumentView:smv];
    [smv scrollToHomeWorld];
}

- (IBAction)colorToolBarClicked:(id)sender
{
    
}

- (IBAction)planetToolBarClicked:(id)sender
{
    
}

- (IBAction)shipToolBarClicked:(id)sender
{
    
}

- (IBAction)stormToolBarClicked:(id)sender
{
    
}

- (IBAction)connectionToolBarClicked:(id)sender
{
    
}


- (IBAction)visibilityToolBarClicked:(id)sender
{
    
}

@end
