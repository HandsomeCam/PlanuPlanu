//
//  NSColor+Serialize.m
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/31/11.
//  Copyright 2011 Roboboogie Studios. All rights reserved.
//

#import "NSColor+Serialize.h"

@implementation NSColor (Serialize)

+ (NSColor*)deserialize:(NSString *)stringColor
{ 
    
    CGFloat components[4];
    NSArray* chunks = [stringColor componentsSeparatedByString:@":"];
    
    if ([chunks count] != 4)
    {
        return[NSColor grayColor];
    }
    else
    {
        for (int i = 0; i < 4; i++)
        {
            components[i] = [[chunks objectAtIndex:i] floatValue];
        }
        
        
        return [NSColor colorWithDeviceRed:components[0]
                                                green:components[1]
                                                 blue:components[2]
                                                alpha:components[3]];
    }
}

- (NSString*)serialize
{
    return [NSString stringWithFormat:@"%lf:%lf:%lf:%lf",
            self.redComponent,
            self.greenComponent,
            self.blueComponent,
            self.alphaComponent];
    
}

@end
