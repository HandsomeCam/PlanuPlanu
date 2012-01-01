//
//  StarMapController.h
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/23/11.
//  Copyright 2011 Roboboogie Studios. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <PlanuKit/PlanuKit.h>
#import "StarMapView.h"

@interface StarMapController : NSWindowController
{
    NuTurn* turn;
    NSScrollView* mapScroll;
    StarMapView* starMap;
    
    NSButton* planetToolBarButton;
    NSButton* shipToolBarButton;
    NSButton* stormToolBarButton;
    NSButton* connectionToolBarButton;
    NSButton* visibilityToolBarButton;
}

@property (nonatomic, retain) NuTurn* turn;

@property (assign) IBOutlet NSScrollView* mapScroll;
@property (assign) IBOutlet NSButton* planetToolBarButton;
@property (assign) IBOutlet NSButton* shipToolBarButton;
@property (assign) IBOutlet NSButton* stormToolBarButton;
@property (assign) IBOutlet NSButton* connectionToolBarButton;
@property (assign) IBOutlet NSButton* visibilityToolBarButton;

- (void)initStarMapView;
- (void)initToolBar;

- (IBAction)colorToolBarClicked:(id)sender;
- (IBAction)planetToolBarClicked:(id)sender;
- (IBAction)shipToolBarClicked:(id)sender;
- (IBAction)stormToolBarClicked:(id)sender;
- (IBAction)connectionToolBarClicked:(id)sender;
- (IBAction)visibilityToolBarClicked:(id)sender;
@end
