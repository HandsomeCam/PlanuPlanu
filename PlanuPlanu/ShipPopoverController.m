//
//  ShipPopoverController.m
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 1/10/12.
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

#import "ShipPopoverController.h"

@implementation ShipPopoverController

@synthesize shipName, hullClass, ship, child, fuelOfFuel, xy;
@synthesize crewLabel, crewAmount, clanLabel, clanAmount;
@synthesize durLabel, durAmount, triLabel, triAmount;
@synthesize molLabel, molAmount, suppLabel, suppAmount;
@synthesize isCloaked, mcLabel, mcAmount;

- (NSString*)fuelOfFuel
{
    NSString* estFuel;
    
    if (ship.crew == -1 && ship.neutronium == 0)
    {
        // Estimate
        estFuel = @"?";
    }
    else
    {
        estFuel = [[NSNumber numberWithInteger:ship.neutronium] stringValue];
    }
    
    return [NSString stringWithFormat:@"%@ / %ld", estFuel, ship.hull.fuel];
}

- (NSString*)displayHeading
{
    if (ship.heading < 0)
    {
        return @"?";
    }
    
    return [[NSNumber numberWithInteger:self.ship.heading] stringValue];
}

- (NSString*)xy
{
    return [NSString stringWithFormat:@"(%ld,%ld)", ship.x, ship.y];
}

- (NSString*)shipCrew
{
    if (ship.crew >= 0)
    {
        return [[NSNumber numberWithInteger:ship.crew] stringValue];
    }
    else
    {
        return @"?";
    }
}

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

    [self.isCloaked setHidden:(ship.isCloaked == NO)];
    
    // Cargo data is unknown, make it grey
    if (ship.crew < 0)
    {
        NSColor* gc = [NSColor grayColor];
        crewLabel.textColor = gc;
        crewAmount.textColor = gc;
        clanLabel.textColor = gc;
        clanAmount.textColor = gc;
        durLabel.textColor = gc;
        durAmount.textColor = gc;
        triLabel.textColor = gc;
        triAmount.textColor = gc;
        molLabel.textColor = gc;
        molAmount.textColor = gc;
        mcLabel.textColor = gc;
        mcAmount.textColor = gc;
        suppLabel.textColor = gc;
        suppAmount.textColor = gc;
    }
    
    
}

@end
