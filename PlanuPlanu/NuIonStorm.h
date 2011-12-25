//
//  NuIonStorm.h
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/24/11.
//  Copyright 2011 Roboboogie Studios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NuIonStorm : NSObject
{
    NSInteger heading;
    NSInteger ionStormId;
    BOOL isGrowing;
    NSInteger radius;
    NSInteger voltage;
    NSInteger warp;
    NSInteger x;
    NSInteger y;
}

@property (nonatomic, assign) NSInteger heading;
@property (nonatomic, assign) NSInteger ionStormId;
@property (nonatomic, assign) BOOL isGrowing;
@property (nonatomic, assign) NSInteger radius;
@property (nonatomic, assign) NSInteger voltage;
@property (nonatomic, assign) NSInteger warp;
@property (nonatomic, assign) NSInteger x;
@property (nonatomic, assign) NSInteger y;

- (void)loadFromDict:(NSDictionary*)input;

@end
