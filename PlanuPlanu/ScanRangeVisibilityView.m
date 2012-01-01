//
//  ScanRangeVisibilityView.m
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/31/11.
//  Copyright 2011 Roboboogie Studios. All rights reserved.
//

#import "ScanRangeVisibilityView.h"

@implementation ScanRangeVisibilityView

@synthesize turn, scanningEntities;

- (id)initWithFrame:(NSRect)frame forTurn:(NuTurn*)t
{
    self.turn = t;
    
    [self generateScanningEntities];
    
    return [self initWithFrame:frame];
}

- (void)generateScanningEntities
{
    NuPlayer* thisPlayer = self.turn.player;
    
    NSMutableSet* scanners = [NSMutableSet set];
    
    NSMutableSet* allies = [NSMutableSet set];
    
    for (NuDiplomaticRelation* ndr in self.turn.diplomaticRelations)
    {
        if (ndr.playerId == thisPlayer.playerId
            && (ndr.relationFrom == kNuDiplomaticRelationShareIntel
                || ndr.relationFrom == kNuDiplomaticRelationFullAlliance))
        {
            [allies addObject:[NSNumber numberWithInteger:ndr.playerToId]];
        }
    }
    
    for (NuShip* ship in self.turn.ships)
    {
        if (ship.ownerId == thisPlayer.playerId
            || [allies containsObject:[NSNumber numberWithInteger:ship.ownerId]])
        {
            [scanners addObject:ship];
        }
    }
    
    for (NuPlanet* planet in self.turn.planets)
    {
        if (planet.ownerId == thisPlayer.playerId
            || [allies containsObject:[NSNumber numberWithInteger:planet.ownerId]])
        {
            [scanners addObject:planet];
        }
    }
    
    self.scanningEntities = [scanners allObjects];
    
    NSMutableArray* sorted = [self.scanningEntities mutableCopy];
    [sorted sortUsingComparator:(NSComparator)^(NuMappableEntity* lhs, NuMappableEntity* rhs)
     {
         NSComparisonResult retVal;
         if (lhs.ownerId == rhs.ownerId)
         {
             retVal = NSOrderedSame;
         }
         else if (lhs.ownerId == self.turn.player.playerId)
         {
             retVal = NSOrderedDescending;
         }
         else if (rhs.ownerId == self.turn.player.playerId)
         {
             retVal = NSOrderedAscending;
         }
         else
         {
             retVal = NSOrderedSame;
         }
         
         return retVal;
     }];
    
    self.scanningEntities = sorted;
}

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.

     
    for (NuMappableEntity* entity in self.scanningEntities)
    {
        NSInteger scanVisibility = self.turn.gameSettings.shipScanRange;
        
        CGRect scanRect = CGRectMake(entity.x-scanVisibility, 
                                     entity.y - scanVisibility,
                                     scanVisibility*2, 
                                     scanVisibility*2);
        
        if (entity.ownerId == self.turn.player.playerId)
        {
            [[NSColor colorWithDeviceRed:.1 green:.1 blue:.35 alpha:1] setFill]; 
        }
        else
        {
            // By changing only the alpha it won't screw with overlaps
            [[NSColor colorWithDeviceRed:.1 green:.1 blue:.25 alpha:1] setFill];  
        }
//        [[NSColor clearColor] setStroke];
        
        NSBezierPath* scanPath = [NSBezierPath bezierPathWithOvalInRect:scanRect];
        
        [scanPath setLineWidth:0];
        
        [scanPath fill];
    }
}

@end
