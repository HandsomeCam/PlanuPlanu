//
//  MessagesWindowController.m
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 1/12/12.
//  Copyright (c) 2012 Roboboogie Studios. All rights reserved.
//

#import "MessagesWindowController.h"
#import "MessageList.h"

@implementation MessagesWindowController

@synthesize outline, turn, systemMessages, playerMessages;
@synthesize headline, body, parentWindow;

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)setTurn:(NuTurn *)t
{
    if (turn != nil)
    {
        [turn release];
    }
    
    turn = [t retain];
    
    [self sortMessages];
}

- (void)sortMessages
{
    self.playerMessages = [NSMutableDictionary dictionary];
    for (NuMessage* m in turn.playerMessages)
    {
        NSNumber* key;
        
        if (turn.player.playerId != m.ownerId)
        {
            key = [NSNumber numberWithInteger:m.ownerId];      
        }
        else
        {
            key = [NSNumber numberWithInteger:m.target];
        }
    
        if ([self.playerMessages objectForKey:key] == nil)
        {
            MessageList* ml = [[[MessageList alloc] init] autorelease];
            [self.playerMessages setObject:ml
                                    forKey:key];
        }
        
        MessageList* array = [self.playerMessages objectForKey:key];
        
        array.messageType = [key intValue];
        
        [array addMessage:m];
    }
    
    self.systemMessages = [NSMutableDictionary dictionary];
    for (NuMessage* m in turn.systemMessages)
    {
        NSNumber* key = [NSNumber numberWithInteger:m.messageType];
        
        if ([self.systemMessages objectForKey:key] == nil)
        {
            MessageList* ml = [[[MessageList alloc] init] autorelease];
            [self.systemMessages setObject:ml
                                    forKey:key];
        }
        
        MessageList* array = [self.systemMessages objectForKey:key];
        array.messageType = m.messageType;
        array.isSystemMessage = YES;
        
        [array addMessage:m];
    }
    
}

- (void)webView:(WebView *)sender
    decidePolicyForNavigationAction:(NSDictionary *)actionInformation
      request:(NSURLRequest *)request 
        frame:(WebFrame *)frame
    decisionListener:(id<WebPolicyDecisionListener>)listener
{
    NSURL* url = [request URL];
    NSString* scheme = [url scheme];
    NSString* fragment = [url fragment];

    NSScanner *scanner = [NSScanner scannerWithString:fragment];
    int hostId = 0;
    [scanner scanInt:&hostId];
    
    if ([scheme isEqualToString:@"planet"])
    {
        for (NuPlanet* planet in self.turn.planets)
        {
            if (planet.planetId == hostId)
            {
                [self.parentWindow scrollToPlanet:planet];
            }
        }
    }
    else if ([scheme isEqualToString:@"ship"])
    {
        for (NuShip* ship in self.turn.ships)
        {
            if (ship.shipId == hostId)
            {
                [self.parentWindow scrollToShip:ship];
            }
        }
    }
    else if ([scheme isEqualToString:@"sorp"])
    {
        // TODO: figure out how to best mux this
        for (NuPlanet* planet in self.turn.planets)
        {
            if (planet.planetId == hostId)
            {
                [self.parentWindow scrollToPlanet:planet];
            }
        }
    }
    
    [listener use];
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    
    [outline expandItem:nil expandChildren:YES];
    headline.stringValue = @"";
    [[body mainFrame] loadHTMLString:@"" baseURL:nil];
    
    body.policyDelegate = self;
}

- (NSString*)addSmartLinksToBody:(NSString*)messageBody
{
    NSString* retVal = messageBody;
    
    NSString* planetOrShipPattern = @"((ID| )#\\d{1,3})";
    NSString* planetPattern = @"(P#\\d{1,3})";
    NSString* shipPattern = @"(S#\\d{1,3})";
    
    NSRegularExpression* regex = [[NSRegularExpression alloc]
                                  initWithPattern:planetOrShipPattern 
                                  options:NSRegularExpressionCaseInsensitive error:nil];
                                                                                       
    retVal = 
        [regex stringByReplacingMatchesInString:retVal
                                        options:0
                                          range:NSMakeRange(0, [retVal length])
                                   withTemplate:@"<a href=\"sorp://$1\">$1</a>"];
    
    regex = [[NSRegularExpression alloc]
             initWithPattern:planetPattern 
             options:NSRegularExpressionCaseInsensitive error:nil];
    
    retVal = 
        [regex stringByReplacingMatchesInString:retVal
                                    options:0
                                      range:NSMakeRange(0, [retVal length])
                               withTemplate:@"<a href=\"planet://$1\">$1</a>"];
    
    regex = [[NSRegularExpression alloc]
             initWithPattern:shipPattern 
             options:NSRegularExpressionCaseInsensitive error:nil];
    
    retVal = 
        [regex stringByReplacingMatchesInString:retVal
                                    options:0
                                      range:NSMakeRange(0, [retVal length])
                               withTemplate:@"<a href=\"ship://$1\">$1</a>"];
    [regex release];
    
    return retVal;
}

- (void)outlineViewSelectionDidChange:(NSNotification *)notification 
{
    NSInteger row;
    row = [outline selectedRow];
    
    if (row >= 0)
    {
        // do stuff for the selected row
        id item = [outline itemAtRow:row];
        
        if ([item isKindOfClass:[NuMessage class]])
        {
            NuMessage* msg = (NuMessage*)item;
            headline.stringValue = msg.headline;
            
            NSString *html = [NSString stringWithFormat:
                              @"<html><style type=\"text/css\">body { font-family: \"Lucida Grande\"; }</style><body>%@</body></html>", 
                              [self addSmartLinksToBody:msg.body]];
 
            [[body mainFrame] loadHTMLString:html baseURL:nil];

        }
        else
        {
            headline.stringValue = @"";
            [[body mainFrame] loadHTMLString:@"" baseURL:nil];
        }
    }
    
}

- (BOOL)outlineView:(NSOutlineView *)sender isGroupItem:(id)item 
{
	if ([item isKindOfClass:[NSDictionary class]])
    {
		return YES;
	}
    else
	{
        return NO;
    }
}

// outlineView:isItemExpandable:, 
- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item
{
    if ([item isKindOfClass:[NSDictionary class]])
    {
        return YES;
    }
    else if ([item isKindOfClass:[MessageList class]])
    {
        return YES;
    }
    
    return NO;
}


- (NSView *)outlineView:(NSOutlineView *)outlineView viewForTableColumn:(NSTableColumn *)tableColumn item:(id)item
{
    NSTextField* retVal = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, 0, 0)];
    
    [retVal setBezeled:NO];
    [retVal setDrawsBackground:NO];
    [retVal setEditable:NO];
    [retVal setSelectable: NO];

    return [retVal autorelease];
}

//outlineView:numberOfChildrenOfItem:,
- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item
{
    if (item == nil)
    {
        return 2;
    }
    else if (item == self.systemMessages)
    {
        return [self.systemMessages count];
    }
    else if (item == self.playerMessages)
    {
        return [self.playerMessages count];
    }
    else if ([item isKindOfClass:[MessageList class]])
    {
        MessageList* ml = (MessageList*)item;
        return [ml count];
    }
    else
    {
        return 0;
    }
}


//outlineView:child:ofItem: 
- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item
{
    if (item == nil)
    {
        if (index == 0)
        {
            return self.systemMessages;
        }
        else
        {
            return self.playerMessages;
        }
    }
    else if ([item isKindOfClass:[NSDictionary class]])
    {
        NSDictionary* d = (NSDictionary*)item;
         
        
        NSArray* keys = [[d allKeys] sortedArrayUsingSelector:@selector(compare:)];
        
        return [d objectForKey:[keys objectAtIndex:index]];
    }
    else if ([item isKindOfClass:[MessageList class]])
    {
        MessageList* ml = (MessageList*)item;
        return [ml messageAtIndex:index];
    }
    else
    {
        return @"---";
    }
}


//outlineView:objectValueForTableColumn:byItem:
- (id)outlineView:(NSOutlineView *)outlineView objectValueForTableColumn:(NSTableColumn *)tableColumn byItem:(id)item
{
    if (item == self.systemMessages)
    {
        return @"System";
    }
    else if (item == self.playerMessages)
    {
        return @"Player Messages";
    }
    else if ([item isKindOfClass:[MessageList class]])
    {
        MessageList* ml = (MessageList*)item;
 
        if (ml.isSystemMessage)
        {
            if (ml.messageType == kNuMessageTypeSensorSweep)
            {
                return @"Sensor Sweep";
            }
            else if (ml.messageType == kNuMessageTypeMineScan)
            {
                return @"Mine Scan";
            }
            else if (ml.messageType == kNuMessageTypeMineSweep)
            {
                return @"Mine Sweep";
            }
            else if (ml.messageType == kNuMessageTypeShip)
            {
                return @"Fleet Messages";
            }
            else if (ml.messageType == kNuMessageTypeExplosion)
            {
                return @"Explosion";
            }
            else if (ml.messageType == kNuMessageTypeStarbase)
            {
                return @"Starbase";
            }
            else if (ml.messageType == kNuMessageTypeMeteors)
            {
                return @"Meteors";
            }
            else if (ml.messageType == kNuMessageTypeDistressCall)
            {
                return @"Distress Calls";
            }
            else if (ml.messageType == kNuMessageTypeColony)
            {
                return @"Colony";
            }
            
            return [NSString stringWithFormat:@"Message type:%ld", ml.messageType];
        }
        else
        {
            for (NuPlayerRace* race in self.turn.races)
            {
                if (race.raceId == ml.messageType)
                {
                    return race.shortName;
                }
            }
        }
        
        return [NSString stringWithFormat:@"Message type:%ld", ml.messageType];
    }
    else if ([item isKindOfClass:[NuMessage class]])
    {
        NuMessage* msg = (NuMessage*)item;
        
        if (msg.isPlayerMessage)
        {
            if (msg.ownerId != turn.player.playerId)
            {
                return [NSString stringWithFormat:@"[T:%ld] Outgoing", msg.turnNumber];
            }
            else
            {
                return [NSString stringWithFormat:@"[T:%ld] Incoming", msg.turnNumber];
            }
        }
        else
        {
            return msg.headline;
        }
    }
    else
    {
        return [item stringValue];
    }
}

@end
