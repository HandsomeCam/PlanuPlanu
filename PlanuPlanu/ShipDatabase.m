//
//  ShipDatabase.m
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/26/11.
//  Copyright 2011 Roboboogie Studios. All rights reserved.
//

#import "ShipDatabase.h"
#import "NuHull.h"

@implementation ShipDatabase

@synthesize hulls;

static ShipDatabase* instance;

- (id)init
{
    self = [super init];
    if (self) 
    {
        // Initialization code here.
        NSString* path = [[NSBundle mainBundle] pathForResource:@"HullDatabase" ofType:@"plist"];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:path]) {
            NSLog(@"The file exists");
        } else {
            NSLog(@"The file does not exist");
        }
        
        
        
        NSMutableArray *hullDicts = [[[NSMutableDictionary alloc] initWithContentsOfFile:
                              path] objectForKey:@"Ships"];
        
        
        
        NSMutableArray* h = [NSMutableArray array];
        for (NSDictionary* hullDict in hullDicts)
        {
            NuHull* hull = [[[NuHull alloc] init] autorelease];
            [hull loadFromDict:hullDict];
            [h addObject:hull];
        }
        self.hulls = h;
    }
    
    return self;
}

+ (ShipDatabase*)sharedDatabase
{
    @synchronized(self)
    {
        if (!instance)
        {
           instance = [[ShipDatabase alloc] init]; 
        }
        
        return instance;
    }
}

@end
