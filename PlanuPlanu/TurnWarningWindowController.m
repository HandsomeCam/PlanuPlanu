//
//  TurnWarningWindowController.m
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 1/17/12.
//  Copyright (c) 2012 Roboboogie Studios. All rights reserved.
//

#import "TurnWarningWindowController.h"
#import "TurnWarning.h"

@implementation TurnWarningWindowController

@synthesize tableview, turn;

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
        warnings = [NSMutableArray array];
    }
    
    return self;
}

- (void)dealloc
{
    [warnings release];
    warnings = nil;
    
    [super dealloc];
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return [warnings count];
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    NSTextField* tf = [[NSTextField alloc] init];
    
    TurnWarning* warning = [warnings objectAtIndex:row];
    
    if ([tableColumn.identifier isEqualToString:@"ship"])
    {
        tf.stringValue = warning.ship.name;
    }
    else if ([tableColumn.identifier isEqualToString:@"warning"])
    {
        tf.stringValue = warning.warning;
    }
    
    return tf;
}

- (void)generateFleet
{
    NSMutableArray* fm = [NSMutableArray array];
    
    for (NuShip* ship in self.turn.ships)
    {
        if (ship.ownerId == self.turn.player.playerId)
        {
            [fm addObject:ship];
        }
    }
    
    fleet = [fm retain];
}

- (void)detectLokis
{
    NSMutableArray* lokis = [NSMutableArray array];
    
    for (NuShip* ship in self.turn.ships)
    {
        if (ship.hull.specialAbility == kShipSpecialTachyonDevice)
        {
            [lokis addObject:ship];
        }
    }
    
    for (NuShip* cloaker in fleet)
    {
        if (cloaker.hull.canCloak == true)
        {
            // TODO: generate end of turn location
            
            for (NuShip* loki in lokis)
            {
                CGFloat start_x = cloaker.x - loki.x;
                CGFloat start_y = cloaker.y - loki.y;
                
                CGFloat startDist = sqrt(pow(start_x, 2) + pow(start_y, 2));
                
                NSPoint cloakerEnd = [cloaker nextTurnDestination];
                NSPoint lokiEnd = [loki nextTurnDestination];
                
                CGFloat endDist = sqrt(pow(cloakerEnd.x - lokiEnd.x, 2) 
                                        + pow(cloakerEnd.y - cloakerEnd.y, 2));
                
                if (startDist <= 10)
                {
                    // TODO: add warning
                }
                if (endDist <= 10)
                {
                    // TODO: add warning
                }
            }
        }
    }
}

@end
