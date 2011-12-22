//
//  NSAttributedString+Hyperlink.m
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/21/11.
//  Copyright 2011 Roboboogie Studios. All rights reserved.
//

// This code has been copied from http://developer.apple.com/library/mac/#qa/qa1487/_index.html

#import "NSAttributedString+Hyperlink.h"

@implementation NSAttributedString (Hyperlink)
        
    +(id)hyperlinkFromString:(NSString*)inString withURL:(NSURL*)aURL
    {
        NSMutableAttributedString* attrString = [[NSMutableAttributedString alloc] initWithString: inString];
        NSRange range = NSMakeRange(0, [attrString length]);
        
        [attrString beginEditing];
        [attrString addAttribute:NSLinkAttributeName value:[aURL absoluteString] range:range];
        
        // make the text appear in blue
        [attrString addAttribute:NSForegroundColorAttributeName value:[NSColor blueColor] range:range];
        
        // next make the text appear with an underline
        [attrString addAttribute:
         NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSSingleUnderlineStyle] range:range];
        
        [attrString endEditing];
        
        return [attrString autorelease];
    }


@end
