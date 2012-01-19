//
//  TurnWarning.h
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 1/18/12.
//  Copyright (c) 2012 Roboboogie Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <PlanuKit/PlanuKit.h>

@interface TurnWarning : NSObject
{
    NSString* warning;
    NuShip* ship;
}

@property (nonatomic, retain) NSString* warning;
@property (nonatomic, retain) NuShip* ship;

@end
