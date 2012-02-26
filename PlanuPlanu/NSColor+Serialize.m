//
//  NSColor+Serialize.m
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/31/11.
//  Copyright 2012 Roboboogie Studios. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
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
