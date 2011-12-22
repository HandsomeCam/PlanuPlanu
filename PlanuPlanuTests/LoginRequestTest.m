//
//  LoginRequestTest.m
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/21/11.
//  Copyright 2011 Roboboogie Studios. All rights reserved.
//

#import "LoginRequestTest.h"

@implementation LoginRequestTest

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
    
    loginRequest = [[LoginRequest alloc] init];
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

#define VALID_USERNAME @"XXXX"
#define VALID_PASSWORD @"XXXX"
#define VALID_API_KEY @"XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"



- (void)testValidLogin
{
    
    requestComplete = NO;
    
    NSRunLoop *theRL = [NSRunLoop currentRunLoop];
    
    [loginRequest performLoginWithUsername:VALID_USERNAME withPassword:VALID_PASSWORD withDelegate:self];
    
    
    // Begin a run loop terminated when the downloadComplete it set to true
    while (!requestComplete && [theRL runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);

}

- (void)loginSucceededWith:(NSString*) ApiKey
{
    STAssertTrue([ApiKey isEqualToString:VALID_API_KEY], @"API Key Compare", nil);
    requestComplete = YES;
}
- (void)loginFailedWith:(NSString*) Reason
{
    STAssertFalse(YES, Reason, nil);
    requestComplete = YES;
}

@end
