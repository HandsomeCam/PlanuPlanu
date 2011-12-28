//
//  NuHull.h
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/27/11.
//  Copyright 2011 Roboboogie Studios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NuHull : NSObject
{
    NSInteger hullId;
    NSInteger techLevel;
    NSString* name;
    NSInteger mass;
    NSInteger fuel;
    NSInteger cargo;
    NSInteger crew;
    NSInteger engines;
    NSInteger beams;
    NSInteger torpedoes;
    NSInteger fighterBays;
    NSInteger cost;
    NSInteger duranium;
    NSInteger tritanium;
    NSInteger molybdenum;
    BOOL canCloak;
    NSInteger specialAbility;
}

@property (nonatomic, assign) NSInteger hullId;
@property (nonatomic, assign) NSInteger techLevel;
@property (nonatomic, retain) NSString* name;
@property (nonatomic, assign) NSInteger mass;
@property (nonatomic, assign) NSInteger fuel;
@property (nonatomic, assign) NSInteger cargo;
@property (nonatomic, assign) NSInteger crew;
@property (nonatomic, assign) NSInteger engines;
@property (nonatomic, assign) NSInteger beams;
@property (nonatomic, assign) NSInteger torpedoes;
@property (nonatomic, assign) NSInteger fighterBays;
@property (nonatomic, assign) NSInteger cost;
@property (nonatomic, assign) NSInteger duranium;
@property (nonatomic, assign) NSInteger tritanium;
@property (nonatomic, assign) NSInteger molybdenum;
@property (nonatomic, assign) BOOL canCloak;
@property (nonatomic, assign) NSInteger specialAbility;

- (void)loadFromDict:(NSDictionary*)input;

@end
