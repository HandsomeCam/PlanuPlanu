//
//  MessageList.h
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 1/12/12.
//  Copyright (c) 2012 Roboboogie Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <PlanuKit/PlanuKit.h>

@interface MessageList : NSObject
{
    NuMessageType messageType;
    NSMutableArray* messages;
    BOOL isSystemMessage;
}

@property (nonatomic, assign) NuMessageType messageType;
@property (nonatomic, assign) BOOL isSystemMessage;

- (void)addMessage:(NuMessage*)message;
- (NuMessage*)messageAtIndex:(NSInteger)index;
- (NSInteger)count;

@end
