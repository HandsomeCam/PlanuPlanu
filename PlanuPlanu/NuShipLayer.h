//
//  NuShipView.h
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/29/11.
//  Copyright 2012 Roboboogie Studios. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import <Cocoa/Cocoa.h>
#import <PlanuKit/PlanuKit.h>

#import "NuColorScheme.h"
#import "NuMappableEntityLayer.h"

@class NuShipView;
 

@interface NuShipLayer : NuMappableEntityLayer
{
    NSMutableArray* ships;
    NuPlayer* player;
    NSInteger shipRadius;
    NuColorScheme* colors; 
     
}

@property (nonatomic, retain) NSMutableArray* ships;
@property (nonatomic, retain) NuPlayer* player;
@property (nonatomic, retain) NuColorScheme* colors; 

- (id)initWithShip:(NuShip*)ship;
- (NSRect)calculateLayerBounds;
- (void)addShip:(NuShip*)ship;

@end
