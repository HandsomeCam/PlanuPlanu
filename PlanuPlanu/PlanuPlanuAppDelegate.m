//
//  PlanuPlanuAppDelegate.m
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

#import "PlanuPlanuAppDelegate.h"
#import "CaptainDashboardController.h"

@implementation PlanuPlanuAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults registerDefaults:[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Preferences" ofType:@"plist"]]];
    
    CaptainDashboardController* cdc = [[CaptainDashboardController alloc] initWithWindowNibName:@"CaptainDashboard"];
    [cdc showWindow:self];
    
    self.window = cdc.window;

}

+ (NSString*)sharedDocumentsPath 
{
    static NSString *SharedDocumentsPath = nil;
    if (SharedDocumentsPath)
        return SharedDocumentsPath;
    
    // Compose a path to the <Library>/Database directory
    NSString *libraryPath = [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0] retain];
    SharedDocumentsPath = [[libraryPath stringByAppendingPathComponent:@"PlanuPlanu"] retain];
    
    // Ensure the database directory exists
    NSFileManager *manager = [NSFileManager defaultManager];
    BOOL isDirectory;
    if (![manager fileExistsAtPath:SharedDocumentsPath isDirectory:&isDirectory] || !isDirectory) 
    {
        NSError *error = nil;
        NSDictionary *attr = [NSDictionary dictionary];
        [manager createDirectoryAtPath:SharedDocumentsPath
           withIntermediateDirectories:YES
                            attributes:attr
                                 error:&error];
        if (error)
        {
            NSLog(@"Error creating directory path: %@", [error localizedDescription]);
        }
    }
    
    return SharedDocumentsPath;
}

@end
