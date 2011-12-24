//
//  GameListRequest.h
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/22/11.
//  Copyright 2011 Roboboogie Studios. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GameListRequestDelegate <NSObject>

- (void)requestsSucceededWith:(NSArray*) Games;
- (void)requestFailedWith:(NSString*) Reason;

@end


@interface GameListRequest : NSObject
{
@private
    id<GameListRequestDelegate> delegate;
    NSMutableData* receivedData;
}

- (void)requestGamesFor:(NSString*)username withDelegate:(id<GameListRequestDelegate>)delegate;

@end


@interface GameListRequest(private) 

- (NSArray*) parseGamesFromResponse:(NSString*)response;

@end

