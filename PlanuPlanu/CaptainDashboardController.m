//
//  CaptainDashboardController.m
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/22/11.
//  Copyright 2011 Roboboogie Studios. All rights reserved.
//

#import "CaptainDashboardController.h"
#import "Preferences.h"
#import "GameListRequest.h"
#import "NuGame.h"
#import "TurnRequest.h"
#import "NuPlanet.h"
#import "StarMapController.h"

@implementation CaptainDashboardController

@synthesize loginMessage, gameList, games, progress;

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    
    if ([defaults boolForKey:kPrefAutoLogin] == YES)
    {
        NSString* apiKey =  [defaults stringForKey:kPrefApiKey];
        loginMessage.stringValue = apiKey;
    }
    
    GameListRequest* glr = [[GameListRequest alloc] init];
    
    NSString* username = [defaults stringForKey:kPrefUsername];
    
    if (username != nil)
    {
        [glr requestGamesFor:username withDelegate:self];
    }
}
 
- (void)requestsSucceededWith:(NSArray*) Games
{
    self.games = Games;
    [gameList reloadData];
}

- (void)requestFailedWith:(NSString*) Reason
{
    // TODO: notify user
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView
{
    if (games == nil)
    {
        return 0;
    }
    
    return [games count];
}

- (void)tableView:(NSTableView *)aTableView setObjectValue:(id)anObject forTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
{
    
}

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
{
    NuGame* ng = [games objectAtIndex:rowIndex];
    
    if ([aTableColumn.identifier isEqualToString:@"gameid"])
    {
        return [NSString stringWithFormat:@"%d", ng.gameId];
    }
    else
    {
        return ng.name;
    }
}


- (void)loadGame:(id)sender
{
    NSInteger sRow = gameList.selectedRow;
    
    if (sRow < 0)
    {
        return;
    }
    
    NuGame* game = [games objectAtIndex:sRow];
    
    TurnRequest* tr = [[TurnRequest alloc] init];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *apiKey = [defaults stringForKey:kPrefApiKey];
    
    [progress startAnimation:self];
    [progress setHidden:NO];
    
    [tr requestTurnFor:game.gameId With:apiKey andDelegate:self];
}


- (void)turnRequestSucceededWith:(NuTurn*) turn
{
    StarMapController* smc = [[StarMapController alloc] initWithWindowNibName:@"StarMap"];
    
    [progress stopAnimation:self];
    [progress setHidden:YES];

    [smc showWindow:self];
    
    [smc.window makeKeyAndOrderFront:self];
    [smc release];
}

- (void)turnRequestFailedWith:(NSString*) Reason
{
    [progress stopAnimation:self];
    [progress setHidden:YES];
    
    NSAlert* alert = [[NSAlert alloc] init];
    alert.messageText = Reason;
    [alert runModal];
    [alert release];
}

@end
