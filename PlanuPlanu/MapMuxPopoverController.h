//
//  MapMuxPopoverController.h
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 1/9/12.
//  Copyright (c) 2012 Roboboogie Studios. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <PlanuKit/PlanuKit.h>

@protocol MapMuxDelegate <NSObject>

- (void)entitySelected:(NuMappableEntity*)entity;

@end

@interface MapMuxPopoverController : NSViewController <NSTableViewDataSource, NSTableViewDelegate, NSPopoverDelegate>

{
    NSArray* entities;
    NuTurn* turn;
    NSTableView* tableview;
    id<MapMuxDelegate> delegate;
    NSPopover* child;
}

@property (nonatomic, retain) NSArray* entities;
@property (nonatomic, retain) NuTurn* turn;
@property (nonatomic, assign) IBOutlet NSTableView* tableview;
@property (nonatomic, assign) id<MapMuxDelegate>delegate;
@property (nonatomic, retain) NSPopover* child;

@end
