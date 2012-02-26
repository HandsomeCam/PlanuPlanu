//
//  PlanetPopoverController.h
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/24/11.
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

#import <Cocoa/Cocoa.h>
#import <PlanuKit/PlanuKit.h>

@interface PlanetPopoverController : NSViewController <NSPopoverDelegate>
{
    NSTextField* planetName;
    NuPlanet* planet;
    NSPopover *child;
    NSTextField* temperature;
    NSTextField* nativeRace;
    NSTextField* planetDataAge;
    NSInteger currentTurn;
}

@property (nonatomic, assign) NSInteger currentTurn;
@property (nonatomic, assign) IBOutlet NSTextField* planetDataAge;
@property (nonatomic, assign) IBOutlet NSTextField* planetName;
@property (nonatomic, assign) IBOutlet NSTextField* temperature;
@property (nonatomic, assign) IBOutlet NSTextField* nativeRace;

@property (nonatomic, retain) NuPlanet* planet;
@property (nonatomic, assign) NSPopover* child;

@property (nonatomic, readonly) NSString* displayNeutronium;
@property (nonatomic, readonly) NSString* displayDuranium;
@property (nonatomic, readonly) NSString* displayTritanium;
@property (nonatomic, readonly) NSString* displayMolybdenum;

@property (nonatomic, readonly) NSString* displayMines;
@property (nonatomic, readonly) NSString* displayFactories;
@property (nonatomic, readonly) NSString* displayDefense;

@property (nonatomic, readonly) NSString* displayClans;
@property (nonatomic, readonly) NSString* displayTemp;

@property (nonatomic, readonly) NSString* displayNatives;

@property (nonatomic, readonly) NSString* displayOwner;

@property (nonatomic, readonly) NSString* displayMC;
@property (nonatomic, readonly) NSString* displaySupplies;

@end
