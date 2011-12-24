//
//  TurnRequest.h
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/23/11.
//  Copyright 2011 Roboboogie Studios. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "NuTurn.h"

@protocol TurnRequestDelegate <NSObject>

- (void)turnRequestSucceededWith:(NuTurn*) turn;
- (void)turnRequestFailedWith:(NSString*) Reason;

@end

@interface TurnRequest : NSObject
{
    id<TurnRequestDelegate> delegate;
    NSMutableData* receivedData;

}

- (void)requestTurnFor:(NSInteger)gameId With:(NSString *)apiKey andDelegate:(id<TurnRequestDelegate>)delegate;

@end

@interface TurnRequest (private)

- (NuTurn*) parseTurnFromResponse:(NSString*)response;

@end