//
//  MessageList.m
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 1/12/12.
//  Copyright 2012 Roboboogie Studios. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
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
