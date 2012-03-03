//
//  NuScore+DeltaDisplay.m
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 2/29/12.
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

#import "NuScore+DeltaDisplay.h"

@implementation NuScore (DeltaDisplay)

- (NSString*)playerAndRaceName
{
    return [NSString stringWithFormat:@"%@ (%@)", self.owner.race.name, self.owner.username];
}

- (NSString*)planetsDelta
{
    NSInteger delta = 0;
    NSString* mod = @"";
    
    NuTurn* lastTurn  = [self.turn.game getTurnNumber:self.turn.settings.turnNumber - 1];
    NuScore* prevScore = nil;
    
    for (NuScore* s in lastTurn.scores)
    {
        if (s.ownerId == self.ownerId)
        {
            prevScore = s;
        }
    }
    
    if (prevScore != nil)
    {
        delta = self.planets - prevScore.planets;
        
        if (delta > 0)
        {
            mod = @"+";
        }
        else if (delta < 0)
        {
            mod = @"-";
        }
        
        if (delta < 0) {delta *= -1;}
    }
    
    return [NSString stringWithFormat:@"%@%d",
            mod, 
            delta];
}

- (NSInteger)allShips
{
    return (self.freighters + self.capitalShips);
}

- (NSString*)shipsDelta
{
    NSInteger delta = 0;
    NSString* mod = @"";
    
    NuTurn* lastTurn  = [self.turn.game getTurnNumber:self.turn.settings.turnNumber - 1];
    NuScore* prevScore = nil;
    
    for (NuScore* s in lastTurn.scores)
    {
        if (s.ownerId == self.ownerId)
        {
            prevScore = s;
        }
    }
    
    if (prevScore != nil)
    {
        delta =   [self allShips]
                - ([prevScore allShips]);
        
        if (delta > 0)
        {
            mod = @"+";
        }
        else if (delta < 0)
        {
            mod = @"-";
        }
        
        if (delta < 0) {delta *= -1;}
    }    
    
    return [NSString stringWithFormat:@"%@%d",
            mod,
            delta];
}

- (NSString*)starbasesDelta
{
    NSInteger delta = 0;
    NSString* mod = @"";
    
    NuTurn* lastTurn  = [self.turn.game getTurnNumber:self.turn.settings.turnNumber - 1];
    NuScore* prevScore = nil;
    
    for (NuScore* s in lastTurn.scores)
    {
        if (s.ownerId == self.ownerId)
        {
            prevScore = s;
        }
    }
    
    if (prevScore != nil)
    {
        delta = self.starbases - prevScore.starbases;
        
        if (delta > 0)
        {
            mod = @"+";
        }
        else if (delta < 0)
        {
            mod = @"-";
        }
        
        if (delta < 0) {delta *= -1;}
    }
    
    return [NSString stringWithFormat:@"%@%d",
            mod,
            delta];
}

- (NSString*)capitalShipsDelta
{
    NSInteger delta = 0;
    NSString* mod = @"";
    
    NuTurn* lastTurn  = [self.turn.game getTurnNumber:self.turn.settings.turnNumber - 1];
    NuScore* prevScore = nil;
    
    for (NuScore* s in lastTurn.scores)
    {
        if (s.ownerId == self.ownerId)
        {
            prevScore = s;
        }
    }
    
    if (prevScore != nil)
    {
        delta = self.capitalShips - prevScore.capitalShips;
        
        if (delta > 0)
        {
            mod = @"+";
        }
        else if (delta < 0)
        {
            mod = @"-";
        }
        
        if (delta < 0) {delta *= -1;}
    }
    
    return [NSString stringWithFormat:@"%@%d",
            mod,
            delta];
}

- (NSString*)freightersDelta
{
    NSInteger delta = 0;
    NSString* mod = @"";
    
    NuTurn* lastTurn  = [self.turn.game getTurnNumber:self.turn.settings.turnNumber - 1];
    NuScore* prevScore = nil;
    
    for (NuScore* s in lastTurn.scores)
    {
        if (s.ownerId == self.ownerId)
        {
            prevScore = s;
        }
    }
    
    if (prevScore != nil)
    {
        delta = self.freighters - prevScore.freighters;
        
        if (delta > 0)
        {
            mod = @"+";
        }
        else if (delta < 0)
        {
            mod = @"-";
        }
        
        if (delta < 0) {delta *= -1;}
    }
    
    return [NSString stringWithFormat:@"%@%d",
            mod,
            delta];
}

@end
