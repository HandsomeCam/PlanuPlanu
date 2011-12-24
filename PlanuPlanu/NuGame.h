//
//  NuGame.h
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/23/11.
//  Copyright 2011 Roboboogie Studios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NuGame : NSObject
{
    NSString* name;
    NSInteger gameId;
}

@property (nonatomic, retain) NSString* name;
@property (nonatomic, assign) NSInteger gameId;

- (BOOL)loadFromDict:(NSDictionary*)input;

@end
