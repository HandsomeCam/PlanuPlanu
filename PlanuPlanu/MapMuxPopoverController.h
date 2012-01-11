//
//  MapMuxPopoverController.h
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 1/9/12.
//  Copyright (c) 2012 Roboboogie Studios. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <PlanuKit/PlanuKit.h>

@interface MapMuxPopoverController : NSViewController <NSTableViewDataSource, NSTableViewDelegate, NSPopoverDelegate>

{
    NSArray* entities;
    NuTurn* turn;
}

@property (nonatomic, retain) NSArray* entities;
@property (nonatomic, retain) NuTurn* turn;

@end
