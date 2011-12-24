//
//  TurnRequest.m
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/23/11.
//  Copyright 2011 Roboboogie Studios. All rights reserved.
//

#define kPlanetsNuLoadTurnUrl @"http://api.planets.nu/game/loadturn"

#import "TurnRequest.h"
#import "JSONKit.h"

@implementation TurnRequest

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)requestTurnFor:(NSInteger)gameId With:(NSString *)apiKey andDelegate:(id<TurnRequestDelegate>)delegateIncoming
{
    delegate = delegateIncoming;
    
    NSString* fullUrl = [NSString stringWithFormat:@"%@?gameid=%d&apikey=%@", kPlanetsNuLoadTurnUrl, gameId, apiKey];
    
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
    
    [delegate turnRequestFailedWith:[error localizedDescription]];
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // do something with the data
    // receivedData is declared as a method instance elsewhere
    NSLog(@"Succeeded! Received %lu bytes of data",[receivedData length]);
    
    NSString *responseString = [[NSString alloc] initWithData:receivedData encoding:NSASCIIStringEncoding];
    
    NSLog(@"Response: %@", responseString);
    
    // release the connection, and the data object
    [connection release];
    [receivedData release];
    
    
    if ([responseString hasPrefix:@"Error:"] == true)
    {
        [delegate turnRequestFailedWith:[responseString substringFromIndex:6]];
        [responseString release];
        return;
    }
    
    NuTurn* retVal = [self parseTurnFromResponse:responseString];
    
    [delegate turnRequestSucceededWith:retVal];
}

- (NuTurn*) parseTurnFromResponse:(NSString*)response
{ 
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    NuTurn* retVal = [[NuTurn alloc] init];
    
    id decodedJson = [response objectFromJSONString];
    
    if ([decodedJson isKindOfClass:[NSDictionary class]] == false)
    {
        return nil;
    }
    
    [retVal loadFromDict:decodedJson];
    
    [pool drain];
    
    return [retVal autorelease];
} 

@end
