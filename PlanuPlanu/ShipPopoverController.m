//
//  ShipPopoverController.m
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 1/10/12.
//  Copyright (c) 2012 Roboboogie Studios. All rights reserved.
//

#import "ShipPopoverController.h"

@implementation ShipPopoverController

@synthesize shipName, hullClass, ship, child;

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
    
    shipName.stringValue = ship.name;
    
    NuHull* hull = [[[NuShipDatabase sharedDatabase] hulls] objectAtIndex:ship.hullId - 1];
     hullClass.stringValue = hull.name;
    
}

@end
