//
//  NuShipView.h
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/29/11.
//  Copyright 2011 Roboboogie Studios. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <PlanuKit/PlanuKit.h>

#import "NuColorScheme.h"
#import "NuMappableEntityLayer.h"

@class NuShipView;

@protocol NuShipViewDelegate <NSObject>

- (void)shipSelected:(NuShipView*)sender atLocation:(CGPoint)point;

@end

@interface NuShipView : NuMappableEntityLayer
{
    NuShip* ship;
    NuPlayer* player;
    NSInteger shipRadius;
    NuColorScheme* colors;
    id<NuShipViewDelegate> delegate;
     
}

@property (nonatomic, retain) NuShip* ship;
@property (nonatomic, retain) NuPlayer* player;
@property (nonatomic, retain) NuColorScheme* colors;
@property (assign) id<NuShipViewDelegate> delegate; 

- (id)initWithShip:(NuShip*)ship;

@end
