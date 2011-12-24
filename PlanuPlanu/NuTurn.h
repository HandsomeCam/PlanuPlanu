//
//  NuTurn.h
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/23/11.
//  Copyright 2011 Roboboogie Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NuGameSettings.h"

@interface NuTurn : NSObject
{
    NSArray* planetList;
    NuGameSettings* gameSettings;
}

@property (nonatomic, retain) NSArray* planetList;
@property (nonatomic, retain) NuGameSettings* gameSettings;

-(BOOL)loadFromDict:(NSDictionary*)input;

@end
