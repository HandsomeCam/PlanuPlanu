//
//  ScanRangeVisibilityView.m
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/31/11.
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

#import "ScanRangeVisibilityView.h"

@implementation ScanRangeVisibilityView

@synthesize turn, scanningEntities;

- (id)initWithFrame:(NSRect)frame forTurn:(NuTurn*)t
{
    self.turn = t;
    
    [self generateScanningEntities];
    [self init];
    self.frame = frame;
    return self;
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
    [sorted sortUsingComparator:(NSComparator)^(id lhs, id rhs)
     {
         // TODO make planet and ship version
         NSComparisonResult retVal;
         if ([lhs ownerId] == [rhs ownerId])
         {
             retVal = NSOrderedSame;
         }
         else if ([lhs ownerId] == self.turn.player.playerId)
         {
             retVal = NSOrderedDescending;
         }
         else if ([rhs ownerId] == self.turn.player.playerId)
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

- (void)drawInContext:(CGContextRef)ctx
{
    NSGraphicsContext *nsGraphicsContext;
    nsGraphicsContext = [NSGraphicsContext graphicsContextWithGraphicsPort:ctx
                                                                   flipped:NO];
    [NSGraphicsContext saveGraphicsState];
    [NSGraphicsContext setCurrentContext:nsGraphicsContext];

     
    for (id entity in self.scanningEntities)
    {
        NSInteger scanVisibility = self.turn.settings.shipScanRange;
        
        CGRect scanRect = CGRectMake([entity x]-scanVisibility, 
                                     [entity y] - scanVisibility,
                                     scanVisibility*2, 
                                     scanVisibility*2);
        
        if ([entity ownerId] == self.turn.player.playerId)
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
    
    [NSGraphicsContext restoreGraphicsState];
}

@end
