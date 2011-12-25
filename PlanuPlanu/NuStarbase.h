//
//  NuStarbase.h
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/24/11.
//  Copyright 2011 Roboboogie Studios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NuStarbase : NSObject
{
    NSInteger planetId;
}

@property (nonatomic, assign) NSInteger planetId;

- (void)loadFromDict:(NSDictionary*)input;

@end
