//
//  NuMappableEntityLayer.h
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 1/4/12.
//  Copyright 2012 Roboboogie Studios. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NuMappableEntityLayer : CALayer
{
    NSInteger identifier;
}

@property (nonatomic, assign) NSInteger identifier;

//- (NSView *)findNextSiblingBelowEventLocation:(NSEvent *)theEvent;

@end
