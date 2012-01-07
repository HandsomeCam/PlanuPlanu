//
//  NuColorScheme.h
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/31/11.
//  Copyright 2011 Roboboogie Studios. All rights reserved.
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

@end
