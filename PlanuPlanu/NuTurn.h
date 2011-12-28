//
//  NuTurn.h
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/23/11.
//  Copyright 2011 Roboboogie Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NuGameSettings.h"
#import "NuPlayer.h"

@interface NuTurn : NSObject
{
    NSArray* planetList;
    NuGameSettings* gameSettings;
    NuPlayer* player;
    NSArray* ionStorms;
    NSArray* ships;
    
}

@property (nonatomic, retain) NSArray* planetList;
@property (nonatomic, retain) NuGameSettings* gameSettings;
@property (nonatomic, retain) NuPlayer* player;
@property (nonatomic, retain) NSArray* ionStorms;
@property (nonatomic, retain) NSArray* ships;

-(BOOL)loadFromDict:(NSDictionary*)input;

@end
