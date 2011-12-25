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
    NSRect smvFrame = CGRectMake(0, 0, 4000, 4000);
    StarMapView* smv = [[StarMapView alloc] initWithFrame:smvFrame];
    
    smv.planets = turn.planetList;
    smv.player = turn.player;
    smv.ionStorms = turn.ionStorms;
    
    [mapScroll setHasHorizontalScroller:YES];
    [mapScroll setHasVerticalScroller:YES];
    
    [mapScroll setDocumentView:smv];
    [smv scrollToHomeWorld];
}

@end
