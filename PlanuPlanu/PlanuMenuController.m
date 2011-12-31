//
//  PlanuMenuController.m
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/21/11.
//  Copyright 2011 Roboboogie Studios. All rights reserved.
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
