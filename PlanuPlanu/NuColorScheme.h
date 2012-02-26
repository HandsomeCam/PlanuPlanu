//
//  NuColorScheme.h
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

#import <Foundation/Foundation.h>
#import <PlanuKit/PlanuKit.h>

@interface NuColorScheme : NSObject
{
    NSMutableArray* colors;
    NuTurn* turn;
    NSString* name;
    NSInteger lastUpdate;
}

@property (nonatomic, retain) NuTurn* turn;
@property (nonatomic, retain) NSString* name;
@property (nonatomic, assign) NSInteger lastUpdate;

- (id)initWithArray:(NSArray*)playerColorArray forTurn:(NuTurn*)turn;

- (NSColor *)colorForPlayer:(NSInteger)playerId;
- (void)setColor:(NSColor*)color forPlayer:(NSInteger)playerId;

- (void)initDiplomaticColorScheme:(NSArray*)scheme;
- (void)initRacialColorScheme:(NSArray*)scheme;
- (void)initXenophobicColorScheme:(NSArray*)scheme;
- (void)initPlayerOrderColorScheme:(NSArray*)scheme;
- (void)serializeToPlist:(NSString *)filename;

@end
