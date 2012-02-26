//
//  NuColorScheme.m
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

#import "NuColorScheme.h"
#import "NSColor+Serialize.h"

@implementation NuColorScheme

@synthesize turn, name, lastUpdate;

- (NSArray*)deserialize:(NSArray *)stringColors
{
    NSMutableArray* retVal = [NSMutableArray array];
    
    for (NSString *serialized in stringColors)
    {
        [retVal addObject:[NSColor deserialize:serialized]];
    }
         
    return retVal;
}

- (id)initWithArray:(NSArray *)playerColorArray forTurn:(NuTurn *)t
{
    if (self = [super init])
    {    
        self.turn = t;
        
        NSString* schemeType = [playerColorArray objectAtIndex:0];
        NSRange sub;
        sub.location = 1;
        sub.length = [playerColorArray count] - 1;
        NSArray* clrs = [self deserialize:[playerColorArray subarrayWithRange:sub]];
        
        if ([schemeType isEqualToString:@"DIPL"])
        {
            [self initDiplomaticColorScheme:clrs];
        }
        else if ([schemeType isEqualToString:@"RACE"])
        {
            [self initRacialColorScheme:clrs];
        }
        else if ([schemeType isEqualToString:@"XENO"])
        {
            [self initXenophobicColorScheme:clrs];
        }
        else if ([schemeType isEqualToString:@"PLYR"])
        {
            [self initPlayerOrderColorScheme:clrs];
        }
    }
    
    return self;
}

- (void)initDiplomaticColorScheme:(NSArray*)scheme
{
    NSMutableArray* baseScheme = [NSMutableArray arrayWithCapacity:7];
    
    for (int i=0; i < 7; i++)
    {
        NSColor* color = [NSColor grayColor];
        
        if ([scheme count] > i)
        {
            color = [scheme objectAtIndex:i];
        }
        
        [baseScheme addObject:color];
    }
    
    NSMutableArray* pa = [NSMutableArray arrayWithCapacity:[self.turn.players count]];
    
    for (int j=0; j < [self.turn.players count]; j++)
    {
        [pa addObject:[NSColor grayColor]];
    }
    
    for (NuDiplomaticRelation* diplo in self.turn.diplomaticRelations)
    {
        [pa replaceObjectAtIndex:diplo.playerToId-1 
                      withObject:[baseScheme objectAtIndex:diplo.relationTo]];
    }
    
    [pa replaceObjectAtIndex:self.turn.player.playerId-1 withObject:[baseScheme objectAtIndex:6]];
    
    colors = [pa retain];
}

- (void)initRacialColorScheme:(NSArray*)scheme
{
    NSMutableArray* baseScheme = [NSMutableArray arrayWithCapacity:11];
    
    for (int i=0; i < 11; i++)
    {
        NSColor* color = [NSColor grayColor];
        
        if ([scheme count] > i)
        {
            color = [scheme objectAtIndex:i];
        }
        
        [baseScheme addObject:color];
    }
    
    NSMutableArray* pa = [NSMutableArray arrayWithCapacity:[self.turn.players count]];
    
    for (int j=0; j < [self.turn.players count]; j++)
    {
        [pa addObject:[NSColor grayColor]];
    }
    
    for (NuPlayer* player in self.turn.players)
    {
        [pa replaceObjectAtIndex:player.playerId-1 
                      withObject:[baseScheme objectAtIndex:player.raceId-1]];
    }
    
    colors = [pa retain];
}

- (void)initXenophobicColorScheme:(NSArray*)scheme
{
    NSMutableArray* baseScheme = [NSMutableArray arrayWithCapacity:2];
    
    for (int i=0; i < 2; i++)
    {
        NSColor* color = [NSColor grayColor];
        
        if ([scheme count] > i)
        {
            color = [scheme objectAtIndex:i];
        }
        
        [baseScheme addObject:color];
    }
    
    NSMutableArray* pa = [NSMutableArray arrayWithCapacity:[self.turn.players count]];
    
    for (int p=0; p < [self.turn.players count]; p++)
    {
        [pa addObject:[baseScheme objectAtIndex:1]];
    }
    
    [pa replaceObjectAtIndex:self.turn.player.playerId - 1
                  withObject:[baseScheme objectAtIndex:0]];
    
    colors = [pa retain];
}

- (void)initPlayerOrderColorScheme:(NSArray*)scheme
{
    NSMutableArray* pa = [NSMutableArray arrayWithCapacity:[self.turn.players count]];
    
    for (int p=0; p < [pa count]; p++)
    {
        if ([scheme count] > p)
        {
            [pa replaceObjectAtIndex:p 
                      withObject:[scheme objectAtIndex:p]];
        }
        else
        {
            [pa replaceObjectAtIndex:p 
                          withObject:[NSColor grayColor]];
        }
    }
    
    colors = [pa retain];
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (NSColor*)colorForPlayer:(NSInteger)playerId
{
    if (playerId <= 0 || playerId > [colors count])
    {
        return [NSColor grayColor];
    }
    
    return [colors objectAtIndex:playerId - 1];
}

- (void)setColor:(NSColor*)color forPlayer:(NSInteger)playerId
{
    lastUpdate = playerId;
    
    [colors replaceObjectAtIndex:playerId-1
                      withObject:color];
}

@end
