//
//  PlanuMenuController.m
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/21/11.
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

#import "PlanuMenuController.h"
#import "AccountWindowController.h"
#import "ShipDatabaseWindowController.h"

@implementation PlanuMenuController

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)AccountLoginSelected:(id)sender
{
    AccountWindowController* awc = [[AccountWindowController alloc] initWithWindowNibName:@"AccountWindow"];
    [awc showWindow:self]; 
}


- (IBAction)ShipDatabaseSelected:(id)sender
{
    ShipDatabaseWindowController* sdbw = [[ShipDatabaseWindowController alloc] initWithWindowNibName:@"ShipDatabaseWindow"];
    [sdbw showWindow:self]; 
}

@end
