//
//  NSColor+Serialize.h
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/31/11.
//  Copyright 2011 Roboboogie Studios. All rights reserved.
//

#import <AppKit/AppKit.h>

@interface NSColor (Serialize)

+ (NSColor*)deserialize:(NSString *)stringColor;
- (NSString*)serialize;

@end
