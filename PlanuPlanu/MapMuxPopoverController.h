//
//  MapMuxPopoverController.h
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 1/9/12.
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

#import <Cocoa/Cocoa.h>
#import <PlanuKit/PlanuKit.h>

@protocol MapMuxDelegate <NSObject>

- (void)entitySelected:(id)entity;

@end

@interface MapMuxPopoverController : NSViewController <NSTableViewDataSource, NSTableViewDelegate, NSPopoverDelegate>

{
    NSArray* entities;
    NuTurn* turn;
    NSTableView* tableview;
    id<MapMuxDelegate> delegate;
    NSPopover* child;
}

@property (nonatomic, retain) NSArray* entities;
@property (nonatomic, retain) NuTurn* turn;
@property (nonatomic, assign) IBOutlet NSTableView* tableview;
@property (nonatomic, assign) id<MapMuxDelegate>delegate;
@property (nonatomic, retain) NSPopover* child;

@end
