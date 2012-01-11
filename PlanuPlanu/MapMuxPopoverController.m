//
//  MapMuxPopoverController.m
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 1/9/12.
//  Copyright (c) 2012 Roboboogie Studios. All rights reserved.
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
    NuMappableEntity *item = [entities objectAtIndex:row];
    
    if ([item isKindOfClass:[NuPlanet class]])
    {
        NuPlanet* planet = (NuPlanet*)item;
        result.imageView.image = [NSImage imageNamed:@"planet.png"];
        result.textField.stringValue = planet.name;
        
        NSInteger planetOwner = planet.ownerId;
        NuPlayer* player = [turn playerForId:planetOwner];
        NSInteger playerRace = player.raceId;
        NuPlayerRace* race = [turn.races objectAtIndex:playerRace];
        
        result.entityClass.stringValue = [NSString stringWithFormat:@"Owned by: %@", race.name];
    }
    else if ([item isKindOfClass:[NuShip class]])
    {
        NuShip* ship = (NuShip*)item;
        result.imageView.image = [NSImage imageNamed:@"ship.png"];
        result.textField.stringValue =  ship.name;
        NuHull* hull = [[[NuShipDatabase sharedDatabase] hulls] objectAtIndex:ship.hullId - 1];
        result.entityClass.stringValue = hull.name;
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
