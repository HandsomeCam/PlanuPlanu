//
//  CaptainDashboardController.h
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/22/11.
//  Copyright 2011 Roboboogie Studios. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <PlanuKit/PlanuKit.h>

@interface CaptainDashboardController : NSWindowController <NuGameListRequestDelegate, NSTableViewDelegate, NSTableViewDataSource, NuTurnRequestDelegate>
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
