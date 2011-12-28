//
//  ShipDatabase.h
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/26/11.
//  Copyright 2011 Roboboogie Studios. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kShipSpecialTerraform           1
#define kShipSpecialRadiationShielding  2
#define kShipSpecialTachyonDevice		4
#define kShipSpecialBioscanner			8
#define kShipSpecialNebulaScanner		16
#define kShipSpecialAdvancedCloak		32
#define kShipSpecialGloryDevice			64
#define kShipSpecialGambling			128
#define kShipSpecialGravitonic			256

@interface ShipDatabase : NSObject
{
    NSArray* hulls;
}

@property (nonatomic, retain) NSArray* hulls;

+ (ShipDatabase*)sharedDatabase;

@end
