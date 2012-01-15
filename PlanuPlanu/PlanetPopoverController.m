//
//  PlanetPopoverController.m
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/24/11.
//  Copyright 2011 Roboboogie Studios. All rights reserved.
//

#import "PlanetPopoverController.h"

@implementation PlanetPopoverController

@synthesize planetName, planet, child, temperature, nativeRace;
@synthesize planetDataAge, currentTurn;

- (NSString*)displayMC
{
    if (self.planet.megacredits == -1)
    {
        return @"?";
    }
    
    return [[NSNumber numberWithInteger:self.planet.megacredits] stringValue];
}

- (NSString*)displaySupplies
{
    if (self.planet.supplies == -1)
    {
        return @"?";
    }
    
    return [[NSNumber numberWithInteger:self.planet.supplies] stringValue];
}

- (NSString*)displayClans
{
    if (self.planet.clans == -1)
    {
        return @"?";
    }
    
    return [[NSNumber numberWithInteger:self.planet.clans] stringValue];
}

- (NSString*)displayDuranium
{
    if (self.planet.duranium == -1)
    {
        return @"?";
    }
    
    return [NSString stringWithFormat:@"%ld / %ld", self.planet.duranium, self.planet.duraniumOnGround];
}

- (NSString*)displayMolybdenum
{
    if (self.planet.molybdenum == -1)
    {
        return @"?";
    }
    
    return [NSString stringWithFormat:@"%ld / %ld", self.planet.molybdenum, self.planet.molybdenumOnGround];
}

- (NSString*)displayNeutronium
{
    if (self.planet.neutronium == -1)
    {
        return @"?";
    }
    
    return [NSString stringWithFormat:@"%ld / %ld", self.planet.neutronium, self.planet.neutroniumOnGround];
}

- (NSString*)displayTritanium
{
    if (self.planet.tritanium == -1)
    {
        return @"?";
    }
    
    return [NSString stringWithFormat:@"%ld / %ld", self.planet.tritanium, self.planet.tritaniumOnGround];
}

- (NSString*)displayMines
{
    if (self.planet.mines >= 0)
    {
        return [[NSNumber numberWithInteger:self.planet.mines] stringValue];
    }
    else
    {
        return @"?";
    }
}

- (NSString*)displayFactories
{
    if (self.planet.factories >= 0)
    {
        return [[NSNumber numberWithInteger:self.planet.factories] stringValue];
    }
    else
    {
        return @"?";
    }    
}

- (NSString*)displayTemp
{
    if (planet.temperature == -1)
    {
        return @"?";
    }
    
    return [NSString stringWithFormat:@"%ld°", planet.temperature];
}

- (NSString*)displayDefense
{
    if (self.planet.defensePosts >= 0)
    {
        return [[NSNumber numberWithInteger:self.planet.defensePosts] stringValue];
    }
    else
    {
        return @"?";
    } 
}

- (NSString*)displayOwner
{
    if (self.planet.ownerId <= 0)
    {
        return @"Unknown Owner";
    }
    return [NSString stringWithFormat:@"%@ (%@)", self.planet.owner.race.shortName, self.planet.owner.username];
}

- (NSString*)displayNatives
{
    if (self.planet.nativeRace == 0)
    {
        [self.nativeRace setHidden:YES];
        return @"";
    }
    else
    {
        [self.nativeRace setHidden:NO];
        return [NSString stringWithFormat:@"%@ - %@", self.planet.nativeRaceName, self.planet.nativeGovernmentName];
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
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    
    planetName.stringValue = planet.name;
    
    if (self.planet.infoTurn != self.currentTurn)
    {
        [planetDataAge setHidden:NO];
        planetDataAge.stringValue = [NSString stringWithFormat:@"Data is %ld turns old.", self.currentTurn - self.planet.infoTurn];
    }
    else
    {
        [planetDataAge setHidden:YES];
    }
}

- (void)dealloc
{
    self.planet = nil;
    
    
    [super dealloc];
}

@end
