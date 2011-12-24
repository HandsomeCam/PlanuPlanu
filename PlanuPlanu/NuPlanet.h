//
//  NuPlanet.h
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/23/11.
//  Copyright 2011 Roboboogie Studios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NuPlanet : NSObject
{
    BOOL isBuildingStarbase;
    
    NSInteger planetId;
    NSString* name;
    
    NSInteger infoTurn;
    NSString* friendlyCode;
    NSInteger temperature;
    NSInteger x;
    NSInteger y;
    
    NSInteger ownerId;
    NSInteger readyStatus;
    
    NSInteger clans;
    NSInteger colonistsChange;
    NSInteger colonyHappinessChange;
    NSInteger colonyTaxRate;
    
    NSInteger nativeChange;
    NSInteger nativeClans;
    NSInteger nativeHappinessChange;
    NSInteger nativeHappiness;
    
    // TODO: make this an enum
    NSInteger nativeGovernment;
    NSString* nativeGovernmentName;
    NSString* nativeRaceName;
    NSInteger nativeRace;
    NSInteger nativeTaxRate;
    
    BOOL debrisDisk;
    
    // Resources
    NSInteger duranium;
    NSInteger molybdenum;
    NSInteger neutronium;
    
    NSInteger megacredits;
    NSInteger supplies;
    
    NSInteger suppliesSold;
    
    NSInteger defenseTarget;
    NSInteger factoriesTarget;
    NSInteger minesTarget;
    
    NSInteger duraniumDensity;
    NSInteger neutroniumDensity;
    NSInteger molybdenumDensity;
    NSInteger tritaniumDensity;
    
    NSInteger duraniumOnGround;
    NSInteger molybdenumOnGround;
    NSInteger neutroniumOnGround;
    NSInteger tritaniumOnGround;
    
    NSInteger duraniumTotal;
    NSInteger molybdenumTotal;
    NSInteger neutroniumTotal;
    NSInteger tritaniumTotal;
    
    // Infrastructure
    NSInteger factories;
    NSInteger defensePosts;
    NSInteger mines;
    
    NSInteger defenseBuilt;
    NSInteger factoriesBuilt;
    NSInteger minesBuilt;
    
}

@property (nonatomic, assign) BOOL isBuildingStarbase;
@property (nonatomic, assign) NSInteger defenseBuilt;
@property (nonatomic, assign) NSInteger factoriesBuilt;
@property (nonatomic, assign) NSInteger minesBuilt;

@property (nonatomic, assign) NSInteger x;
@property (nonatomic, assign) NSInteger y;
@property (nonatomic, retain) NSString* name;

- (BOOL)loadFromDict:(NSDictionary*)input;

@end
