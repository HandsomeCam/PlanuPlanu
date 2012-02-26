//
//  ShipDatabaseWindowController.m
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/30/11.
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

#import "ShipDatabaseWindowController.h"
#import <PlanuKit/PlanuKit.h>

@implementation ShipDatabaseWindowController

@synthesize hulls;

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
        NuShipDatabase* sdb = [NuShipDatabase sharedDatabase];
        
        // copy to our local version for sorting
        self.hulls = [sdb.hulls mutableCopy];
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView
{
    return self.hulls.count;
}

- (void)tableView:(NSTableView *)aTableView setObjectValue:(id)anObject forTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
{
    
}

- (void)tableView:(NSTableView *)tableView didClickTableColumn:(NSTableColumn *)tableColumn
{
    if (lastSortColumn == nil || lastSortColumn != tableColumn)
    {
        reverseSort = NO;
        lastSortColumn = tableColumn;
    }
    else
    {
        reverseSort = !reverseSort;
    }
    
    columnSortSelector = NSSelectorFromString([NSString stringWithFormat: @"%@Comparison:",
                                               tableColumn.identifier]);
    [self.hulls sortUsingSelector:columnSortSelector];
    
    
    if (reverseSort == YES)
    {
        NSUInteger i = 0;
        NSUInteger j = [self.hulls count] - 1;
        while (i < j) {
            [self.hulls exchangeObjectAtIndex:i
                      withObjectAtIndex:j];
            
            i++;
            j--;
        }
    }
    
    [tableView deselectAll:self];
    [tableView reloadData];
    
}



- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
{
    
    
    NuHull* hull = [self.hulls objectAtIndex:rowIndex];
    
    if ([aTableColumn.identifier isEqualToString:@"hullId"])
    {
        return [NSString stringWithFormat:@"%d", hull.hullId];
    }
    else if ([aTableColumn.identifier isEqualToString:@"name"])
    {
        return hull.name;
    }
    else if ([aTableColumn.identifier isEqualToString:@"techLevel"])
    {
        return [NSString stringWithFormat:@"%d", hull.techLevel];
    }
    else if ([aTableColumn.identifier isEqualToString:@"fuel"])
    {
        return [NSString stringWithFormat:@"%d", hull.fuel];
    }
    else if ([aTableColumn.identifier isEqualToString:@"mass"])
    {
        return [NSString stringWithFormat:@"%d", hull.mass];
    }
    else if ([aTableColumn.identifier isEqualToString:@"beams"])
    {
        return [NSString stringWithFormat:@"%d", hull.beams];
    }
    else if ([aTableColumn.identifier isEqualToString:@"torps"])
    {
        return [NSString stringWithFormat:@"%d", hull.torpedoes];
    }
    else if ([aTableColumn.identifier isEqualToString:@"bays"])
    {
        return [NSString stringWithFormat:@"%d", hull.fighterBays];
    }
    
    return @"";
}


@end
