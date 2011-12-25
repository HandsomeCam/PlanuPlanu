//
//  GameListRequest.m
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/22/11.
//  Copyright 2011 Roboboogie Studios. All rights reserved.
//

#import "GameListRequest.h"
#import "JSONKit.h"
#import "NuGame.h"

#define kPlanetsNuGameListUrl @"http://api.planets.nu/games/list"

@implementation GameListRequest

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}


- (void)requestGamesFor:(NSString*)username withDelegate:(id<GameListRequestDelegate>)delegateIncoming
{
    delegate = delegateIncoming;
    
    NSString* fullUrl = [NSString stringWithFormat:@"%@?username=%@", kPlanetsNuGameListUrl, username];
    
    // Create the request.
    NSMutableURLRequest *theRequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:fullUrl]
                                                            cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                        timeoutInterval:60.0];
    
    [theRequest setHTTPMethod:@"GET"];
      
    // create the connection with the request
    // and start loading the data
    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    if (theConnection) {
        // Create the NSMutableData to hold the received data.
        // receivedData is an instance variable declared elsewhere.
        receivedData = [[NSMutableData data] retain];
    } else {
        // Inform the user that the connection failed.
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // This method is called when the server has determined that it
    // has enough information to create the NSURLResponse.
    
    // It can be called multiple times, for example in the case of a
    // redirect, so each time we reset the data.
    
    // receivedData is an instance variable declared elsewhere.
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the new data to receivedData.
    // receivedData is an instance variable declared elsewhere.
    [receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection
didFailWithError:(NSError *)error
{
    // release the connection, and the data object
    [connection release];
    // receivedData is declared as a method instance elsewhere
    [receivedData release];
    
    // inform the user
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
    
    [delegate requestFailedWith:[error localizedDescription]];
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // do something with the data
    // receivedData is declared as a method instance elsewhere
    //NSLog(@"Succeeded! Received %lu bytes of data",[receivedData length]);
    
    NSString *responseString = [[NSString alloc] initWithData:receivedData encoding:NSASCIIStringEncoding];
    
    //NSLog(@"Response: %@", responseString);
    
    // release the connection, and the data object
    [connection release];
    [receivedData release];
    
    
    if ([responseString hasPrefix:@"Error:"] == true)
    {
        [delegate requestFailedWith:[responseString substringFromIndex:6]];
        [responseString release];
        return;
    }
     
    NSArray* returnValue = [self parseGamesFromResponse:responseString];
    
    // TODO: fail if nil
    
    [delegate requestsSucceededWith:returnValue];
}

- (NSArray*) parseGamesFromResponse:(NSString*)response
{ 
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    NSMutableArray* retVal = [[NSMutableArray alloc] init];
    
    id decodedJson = [response objectFromJSONString];
    
    if ([decodedJson isKindOfClass:[NSArray class]] == false)
    {
        return nil;
    }
    
    for (NSDictionary* gameDict in decodedJson)
    {
        NuGame *game = [[NuGame alloc] init];
        [game loadFromDict:gameDict];
        
        [retVal addObject:[game autorelease]];
    }
    
    [pool drain];
     
    return [retVal autorelease];
} 

@end
