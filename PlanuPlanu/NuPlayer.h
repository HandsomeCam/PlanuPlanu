//
//  NuPlayer.h
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/24/11.
//  Copyright 2011 Roboboogie Studios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NuPlayer : NSObject
{
    NSInteger playerId;
}

@property (nonatomic, assign) NSInteger playerId;

- (void)loadFromDict:(NSDictionary*)input;

@end
