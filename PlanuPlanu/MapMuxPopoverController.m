//
//  MapMuxPopoverController.m
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 1/9/12.
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

#import "MapMuxPopoverController.h"
#import <PlanuKit/PlanuKit.h>
#import "MuxCellView.h"

@implementation MapMuxPopoverController

@synthesize entities, turn, tableview, delegate, child;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)loadView
{
    [super loadView];
    
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row 
{
    MuxCellView *result = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
    id item = [entities objectAtIndex:row];
    
    if ([item isKindOfClass:[NuPlanet class]])
    {
        NuPlanet* planet = (NuPlanet*)item;
        result.imageView.image = [NSImage imageNamed:@"planet.png"];
        result.textField.stringValue = planet.name;
         
        NuPlayer* player = planet.owner;
        
        NuPlayerRace* race = player.race;
        
        result.entityClass.stringValue = [NSString stringWithFormat:@"Owned by: %@", race.name];
    }
    else if ([item isKindOfClass:[NuShip class]])
    {
        NuShip* ship = (NuShip*)item;
        result.imageView.image = [NSImage imageNamed:@"ship.png"];
        result.textField.stringValue =  ship.name;
        result.entityClass.stringValue = ship.hull.name;
    }
    
    return result;
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView
{
    if (entities == nil)
    {
        return 0;
    }
    
    return [entities count];
}

- (void) tableViewSelectionDidChange: (NSNotification *) notification
{
    NSInteger row;
    row = [tableview selectedRow];
    
    if (row != -1)
    {
        [tableview deselectRow:row];
        
        [delegate entitySelected:[entities objectAtIndex:row]];
        
        // TODO: dismiss the popover
    }
    
} 

@end
