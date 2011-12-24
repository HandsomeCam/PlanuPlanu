//
//  CaptainDashboardController.h
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/22/11.
//  Copyright 2011 Roboboogie Studios. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "GameListRequest.h"
#import "TurnRequest.h"

@interface CaptainDashboardController : NSWindowController <GameListRequestDelegate, NSTableViewDelegate, NSTableViewDataSource, TurnRequestDelegate>
{
    @private
    NSTextField* loginMessage;
    NSTableView* gameList;
    NSArray *games;
    NSProgressIndicator* progress;
}

@property (assign) IBOutlet NSTextField* loginMessage;
@property (assign) IBOutlet NSTableView* gameList;
@property (nonatomic, retain) NSArray* games;
@property (assign) IBOutlet NSProgressIndicator* progress;

- (IBAction)loadGame:(id)sender;

@end
