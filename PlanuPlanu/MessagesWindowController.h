//
//  MessagesWindowController.h
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 1/12/12.
//  Copyright (c) 2012 Roboboogie Studios. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import <PlanuKit/PlanuKit.h>
#import "StarMapController.h"

@interface MessagesWindowController : NSWindowController <NSOutlineViewDelegate, NSOutlineViewDataSource, NSTableViewDelegate>
{
    NSOutlineView* outline;
    NuTurn* turn;
    NSMutableDictionary* systemMessages;
    NSMutableDictionary* playerMessages;
    
    NSTextField* headline;
    WebView* body;
    StarMapController *parentWindow;
}

@property (nonatomic, assign) IBOutlet NSOutlineView* outline;
@property (nonatomic, retain) NuTurn* turn;
@property (nonatomic, retain) NSMutableDictionary* systemMessages;
@property (nonatomic, retain) NSMutableDictionary* playerMessages;

@property (nonatomic, assign) IBOutlet NSTextField* headline;
@property (nonatomic, assign) IBOutlet WebView* body;
@property (nonatomic, retain) StarMapController* parentWindow;

- (void)sortMessages;
- (NSString*)addSmartLinksToBody:(NSString*)messageBody;

@end
