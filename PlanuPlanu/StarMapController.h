//
//  StarMapController.h
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/23/11.
//  Copyright 2011 Roboboogie Studios. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <PlanuKit/PlanuKit.h>

@interface StarMapController : NSWindowController
{
    NuTurn* turn;
    NSScrollView* mapScroll;
}

@property (nonatomic, retain) NuTurn* turn;
@property (assign) IBOutlet NSScrollView* mapScroll;

- (void)initStarMapView;

@end
