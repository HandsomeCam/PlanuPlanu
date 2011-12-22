//
//  NSAttributedString+Hyperlink.h
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/21/11.
//  Copyright 2011 Roboboogie Studios. All rights reserved.
//

// This code has been copied from http://developer.apple.com/library/mac/#qa/qa1487/_index.html

#import <Foundation/Foundation.h>

@interface NSAttributedString (Hyperlink)
    +(id)hyperlinkFromString:(NSString*)inString withURL:(NSURL*)aURL;
@end
