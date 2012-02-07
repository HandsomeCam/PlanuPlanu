//
//  TurnScorePanelController.h
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 2/4/12.
//  Copyright (c) 2012 Roboboogie Studios. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <CorePlot/CorePlot.h>
#import <PlanuKit/PlanuKit.h>
#import "NuColorScheme.h"

@interface TurnScorePanelController : NSWindowController <CPTPlotDataSource>
{
    CPTXYGraph *graph;
    CPTGraphHostingView* graphPlaceholder;
    NuGame* game;
    NuColorScheme* colors;
}

@property (nonatomic, retain) NuGame* game;
@property (nonatomic, retain) NuColorScheme* colors;

@property (nonatomic, assign) IBOutlet CPTGraphHostingView* graphPlaceholder;

@end
