//
//  MuxCellView.m
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 1/10/12.
//  Copyright (c) 2012 Roboboogie Studios. All rights reserved.
//

#import "MuxCellView.h"

@implementation MuxCellView

@synthesize entityClass;

- (NSColor *)highlightColorWithFrame:(NSRect)cellFrame inView:(NSView *)controlView
{
    return [NSColor darkGrayColor];
}

@end
