//
//  PlanetPopoverController.m
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/24/11.
//  Copyright 2011 Roboboogie Studios. All rights reserved.
//

#import "PlanetPopoverController.h"

@implementation PlanetPopoverController

@synthesize planetName, planet, child, clanQuantity;

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
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    
    planetName.stringValue = planet.name;
    clanQuantity.stringValue = [NSString stringWithFormat:@"Clans: %ld", planet.clans];
}

- (void)dealloc
{
    self.planet = nil;
    
    
    [super dealloc];
}

@end
