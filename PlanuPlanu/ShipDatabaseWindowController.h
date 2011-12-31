//
//  ShipDatabaseWindowController.h
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/30/11.
//  Copyright 2011 Roboboogie Studios. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ShipDatabaseWindowController : NSWindowController <NSTableViewDataSource, NSTableViewDelegate>
{
    SEL columnSortSelector;
    NSMutableArray* hulls;
}

@property (nonatomic, retain) NSMutableArray* hulls;

@end
