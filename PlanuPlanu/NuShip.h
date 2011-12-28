//
//  NuShip.h
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/26/11.
//  Copyright 2011 Roboboogie Studios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NuShip : NSObject
{
    NSInteger x;
    NSInteger y;
}

@property (nonatomic, assign) NSInteger x;
@property (nonatomic, assign) NSInteger y;

- (void)loadFromDict:(NSDictionary*)input;

@end
