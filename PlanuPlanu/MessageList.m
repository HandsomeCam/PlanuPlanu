//
//  MessageList.m
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 1/12/12.
//  Copyright (c) 2012 Roboboogie Studios. All rights reserved.
//

#import "MessageList.h"

@implementation MessageList

@synthesize messageType, isSystemMessage;

- (id)init
{
    if (self = [super init])
    {
        messages = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)addMessage:(NuMessage*)message
{
    [messages addObject:message];
}

- (NuMessage*)messageAtIndex:(NSInteger)index
{
    return [messages objectAtIndex:index];
}

- (NSInteger)count
{
    return [messages count];
}

- (void)dealloc
{
    [messages release];
    messages = nil;
    
    [super dealloc];
}

@end
