//
//  LoginRequest.h
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/21/11.
//  Copyright 2011 Roboboogie Studios. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LoginRequestDelegate <NSObject>

- (void)loginSucceededWith:(NSString*) ApiKey;
- (void)loginFailedWith:(NSString*) Reason;

@end
 

@interface LoginRequest : NSObject
{
@private
    id<LoginRequestDelegate> delegate;
    NSMutableData* receivedData;
}

- (void)performLoginWithUsername:(NSString*)username withPassword:(NSString*)password withDelegate:(id<LoginRequestDelegate>)delegate;

@end
