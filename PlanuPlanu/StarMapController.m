//
//  StarMapController.m
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/23/11.
//  Copyright 2011 Roboboogie Studios. All rights reserved.
//

#import "StarMapController.h"
#import "StarMapView.h"
#import "NuColorScheme.h"

@implementation StarMapController

@synthesize turn;
@synthesize mapScroll;
@synthesize planetToolBarButton, shipToolBarButton;
@synthesize stormToolBarButton, connectionToolBarButton, visibilityToolBarButton;

@synthesize colorSchemeWindow, colorSchemeTableView;
@synthesize loadScheme, colorSchemes, activeScheme;
@synthesize muxPopover, mmpc;

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
    
    [self initColorScheme];
    
    starMap.colorScheme = self.activeScheme;
    
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

- (void)initColorScheme
{
    NSString* path = [[NSBundle mainBundle] pathForResource:@"ColorSchemes" ofType:@"plist"];
    
    NSDictionary *schemes = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    
    NSMutableArray* colors = [NSMutableArray array];
    
    for (NSString *key in [schemes allKeys])
    {
        NuColorScheme* cs = [[NuColorScheme alloc] initWithArray:[schemes objectForKey:key]
                                                         forTurn:self.turn];
        [colors addObject:cs];
        cs.name = key;
        [cs release];
        
        [self.loadScheme addItemWithTitle:key];
    }
    
    self.colorSchemes = colors;
    self.activeScheme = [colorSchemes objectAtIndex:0];
    
    [schemes release];
}

- (IBAction)colorToolBarClicked:(id)sender
{
    [loadScheme removeAllItems];
 
    for (NuColorScheme* cs in self.colorSchemes)
    { 
        [self.loadScheme addItemWithTitle:cs.name];
    }
      
    
    [colorSchemeWindow makeKeyAndOrderFront:self];
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

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView
{
    // In case the nib didn't hook up right
    if (self.colorSchemeTableView != aTableView)
    {
        self.colorSchemeTableView = aTableView;
    }
    
    return [turn.players count];
}

- (void)colorChanged:(NSColorWell*)sender
{
    [self.activeScheme setColor:sender.color forPlayer:sender.tag];
    
    starMap.colorScheme = self.activeScheme;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    NuPlayer* player = [self.turn.players objectAtIndex:row];
    
    CGFloat tw = tableView.frame.size.width;
    
    if ([tableColumn.identifier isEqualToString:@"color"])
    {
        NSColorWell* cw = [[NSColorWell alloc] initWithFrame:CGRectMake(0, 0, tw, 20)];
        cw.color = [activeScheme colorForPlayer:player.playerId];
        cw.target = self;
        [cw setAction:@selector(colorChanged:)];
        
        cw.tag = player.playerId;
        return cw;
    }
    else
    {
        // get an existing cell with the MyView identifier if it exists
        NSTextField *lbl = [tableView makeViewWithIdentifier:@"textCell" owner:self];
        
        // There is no existing cell to reuse so we will create a new one
        if (lbl == nil) 
        {
            lbl = [[[NSTextField alloc] initWithFrame:CGRectMake(0,0, tw, 20)] autorelease];
            lbl.identifier = @"textCell";
            [lbl setBezeled:NO];
            [lbl setDrawsBackground:NO];
            [lbl setEditable:NO];
            [lbl setSelectable:NO];
        }
        
        if ([tableColumn.identifier isEqualToString:@"player"])
        {         
            lbl.stringValue = player.username;
            return lbl;
        }
        else if ([tableColumn.identifier isEqualToString:@"race"])
        {
            NSInteger raceId = player.raceId;
            NSString* raceName;
            
            for (NuPlayerRace* race in turn.races)
            {
                if (race.raceId == raceId)
                {
                    raceName = race.shortName;
                }
            }
             
            lbl.stringValue = raceName;
            
            return lbl;
        }
    }
    
    return nil;
}

- (IBAction)loadColorScheme:(id)sender
{
    NSString* schemeName = [loadScheme titleOfSelectedItem];
    
    for (NuColorScheme* cs in self.colorSchemes)
    {
        if ([schemeName isEqualToString:cs.name])
        {
            self.activeScheme = cs;
            starMap.colorScheme = cs;
            [self.colorSchemeTableView reloadData];
        }
    }
}


- (IBAction)ppvr:(NSView*)sender
{
   NSRect r = NSMakeRect(10, 10, 0, 0);
       [self.muxPopover showRelativeToRect:r ofView:starMap preferredEdge:NSMaxYEdge];
}

- (void)showMultiplexPopover:(NSArray *)entities at:(NSRect)popFrame
{
    
//    NSPopover* muxPopover = [[NSPopover alloc] init];
//    //[muxPopover setContentSize:NSMakeSize(50, 50)];
//    //    CGRect planetRect = CGRectMake(planet.x - 5, planet.y - 5, 10, 10);
//   
//    NSView *anchor = [[NSView alloc] initWithFrame:popFrame];
//    [self addSubview:anchor];
//    
//    MapMuxPopoverController* mmpc = [[MapMuxPopoverController alloc] initWithNibName:@"MapMuxPopover" bundle:nil];
//    
//    [muxPopover setAnimates:YES];
//    muxPopover.contentViewController = [mmpc autorelease];
//    muxPopover.delegate = mmpc;
//    
//    // TODO: add shit
//    
//    muxPopover.behavior = NSPopoverBehaviorTransient;
//    // mmpc.child = planetPopover;
//    
//    NSLog(@"Show it!");
//    [muxPopover showRelativeToRect:anchor.frame
//                            ofView:anchor 
//                     preferredEdge:NSMinYEdge];
//    muxover = [mmpc retain];
//    
    
//    [self.muxPopover showRelativeToRect:starMap.bounds ofView:starMap preferredEdge:NSMinXEdge];
}
 

@end
