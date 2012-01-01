//
//  ScanRangeVisibilityView.h
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/31/11.
//  Copyright 2011 Roboboogie Studios. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <PlanuKit/PlanuKit.h>

@interface ScanRangeVisibilityView : NSView
{
    NuTurn* turn;
//    NSArray* scanningEntities;
}

@property (nonatomic, retain) NuTurn* turn;
@property (nonatomic, retain) NSArray* scanningEntities;

- (id)initWithFrame:(NSRect)frame forTurn:(NuTurn*)turn;
- (void)generateScanningEntities;

@end
