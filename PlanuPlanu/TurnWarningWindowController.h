//
//  TurnWarningWindowController.h
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 1/17/12.
//  Copyright (c) 2012 Roboboogie Studios. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <PlanuKit/PlanuKit.h>

@interface TurnWarningWindowController : NSWindowController <NSTabViewDelegate, NSTableViewDataSource>
{
    NSTableView* tableview;
    NuTurn* turn;
    NSArray* fleet;
    NSMutableArray* warnings;
}

@property (nonatomic, assign) IBOutlet NSTableView* tableview;
@property (nonatomic, retain) NuTurn* turn;

- (void)generateFleet;
- (void)detectLokis;

@end
