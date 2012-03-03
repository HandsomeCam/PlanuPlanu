//
//  TurnWarningWindowController.m
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 1/17/12.
//  Copyright 2012 Roboboogie Studios. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
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
        warnings = [[NSMutableArray array] retain];
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
    [self generateFleet];
    [self detectLokis];
    [self.tableview reloadData];
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return [warnings count];
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    NSTextField* tf = [[NSTextField alloc] init];
    [tf setEditable:NO];
    [tf setBordered:NO];
    tf.backgroundColor = [NSColor clearColor];
    
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
                                        + pow(cloakerEnd.y - lokiEnd.y, 2));
                
                BOOL dupeFound = NO;
                
                if (startDist <= 10)
                {
                    TurnWarning* sw = [[[TurnWarning alloc] init] autorelease];
                    sw.ship = cloaker;
                    sw.warning = [NSString stringWithFormat:@"%@ begins turn near a Loki, will be decloaked for the remainder of this turn.", cloaker.name];
                    sw.warningType = kTurnWarningLokiDecloakStarting;
                    
                    for (TurnWarning* tw in warnings)
                    {
                        if (tw.warningType == sw.warningType
                            && tw.ship == sw.ship)
                        {
                            dupeFound = YES;
                        }
                    }
                    
                    if (dupeFound == NO)
                    {
                        [warnings addObject:sw];
                    }
                }
                if (endDist <= 10)
                { 
                    TurnWarning* ew = [[[TurnWarning alloc] init] autorelease];
                    ew.ship = cloaker;
                    ew.warning = [NSString stringWithFormat:@"%@ ends turn near a Loki, it may potentially be decloaked next turn.", cloaker.name];
                    ew.warningType = kTurnWarningLokiDecloakEnding;
                    
                    for (TurnWarning* tw in warnings)
                    {
                        if (tw.warningType == ew.warningType
                            && tw.ship == ew.ship)
                        {
                            dupeFound = YES;
                        }
                    }
                    
                    if (dupeFound == NO)
                    {
                        [warnings addObject:ew];
                    }
;
                }
            }
        }
    }
}

@end
