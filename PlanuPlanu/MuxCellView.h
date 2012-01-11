//
//  MuxCellView.h
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 1/10/12.
//  Copyright (c) 2012 Roboboogie Studios. All rights reserved.
//

#import <AppKit/AppKit.h>

@interface MuxCellView : NSTableCellView
{
    NSTextField* entityClass;
}

@property (nonatomic, assign) IBOutlet NSTextField* entityClass;

@end
