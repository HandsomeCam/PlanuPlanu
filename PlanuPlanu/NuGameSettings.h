//
//  NuGameSettings.h
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/23/11.
//  Copyright 2011 Roboboogie Studios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NuGameSettings : NSObject
{
    NSInteger mapWidth;
    NSInteger mapHeight;
}

@property (nonatomic, assign) NSInteger mapWidth;
@property (nonatomic, assign) NSInteger mapHeight;

- (BOOL)loadFromDict:(NSDictionary*)input;

@end
