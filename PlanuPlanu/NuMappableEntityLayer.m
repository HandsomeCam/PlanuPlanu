//
//  NuMappableEntityLayer.m
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 1/4/12.
//  Copyright 2012 Roboboogie Studios. All rights reserved.
//

#import "NuMappableEntityLayer.h"

@implementation NuMappableEntityLayer

@synthesize identifier;

//
//- (void)drawRect:(NSRect)dirtyRect
//{
//    // Drawing code here.
//}


//- (NSView *)findNextSiblingBelowEventLocation:(NSEvent *)theEvent
//{
//    // Translate the event location to view coordinates
//    NSPoint location = [theEvent locationInWindow];
//    NSPoint convertedLocation = [self convertPointToBacking:location];
//    NSPoint cl2 = [[self superview] convertPoint:convertedLocation fromView:self];
//    NSPoint cl3 = [[self superview] convertPoint:location
//                            fromView:self];
//    NSPoint cl4 = [self convertPoint:convertedLocation fromView:[self superview]];
//    NSPoint cl5 = [self convertPoint:location fromView:[self superview]];
//    NSPoint cl6 = [[self superview] convertPointToBase:location];
//    NSPoint cl7 = [self convertPoint:location fromView:nil];
//    
//    // Find next view below self
//    NSArray *siblings = [[self superview] subviews];
//    NSView *viewBelow = nil;
//    
//    NSLog(@"Subviews: %ld", [siblings count]);
//    
//    for (NuMappableEntityLayer* view in siblings) 
//    {
//        if (view != self && [view isKindOfClass:[NuMappableEntityLayer class]]) 
//        {
//            NSPoint vr1 = view.frame.origin;
//            
//            if (view.identifier == 11
//                || view.identifier == 23)
//            {
//                NSLog(@"SHIP!");
//            }
//            
//            NSView *lView = [view hitTest:location];
//            NSView *hitView = [view hitTest:convertedLocation];
//            NSView *hv2 = [view hitTest:cl2];
//            NSView *hv3 = [view hitTest:cl3];
//            NSView *hv4 = [view hitTest:cl4];
//            NSView *hv5 = [view hitTest:cl5];
//            NSView *hv6 = [view hitTest:cl6];
//            
//            NSView *hv7 = [view hitTest:cl7];
//            
//            if (hitView != nil) 
//            {
//                [view mouseDown:theEvent];
//            }
//        }
//    }
//    
//    return viewBelow;
//}


@end
