//
//  TurnScorePanelController.m
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 2/4/12.
//  Copyright (c) 2012 Roboboogie Studios. All rights reserved.
//

#import "TurnScorePanelController.h"
#import <CorePlot/CorePlot.h>

#import <PlanuKit/PlanuKit.h>

@interface TurnScorePanelController (private)

- (void)graphPlayerShips;
- (CPTPlot*)graphShipsForPlayer:(NuPlayer*)player;

@end

@implementation TurnScorePanelController

@synthesize graphPlaceholder, game, colors;

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.

    [self graphPlayerShips];
    
}

- (void)graphPlayerShips
{
    
    graph = [[CPTXYGraph alloc] initWithFrame: self.graphPlaceholder.bounds];
    
    CPTGraphHostingView *hostingView = self.graphPlaceholder;
    hostingView.hostedGraph = graph;
    graph.paddingLeft = 10.0;
    graph.paddingTop = 10.0;
    graph.paddingRight = 10.0;
    graph.paddingBottom = 10.0;

    graph.backgroundColor = [[CPTColor blackColor] cgColor];
    
    NSInteger turnCount = [self.game.turns count];
    NSLog(@"TurnCount: %ld", turnCount);
    
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)graph.defaultPlotSpace;
    plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(-2)
                                                    length:CPTDecimalFromFloat(turnCount+2)];
    plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(-1) 
                                                    length:CPTDecimalFromFloat(25)];
 
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *)graph.axisSet;
    
    CPTXYAxis *x = axisSet.xAxis;
    
    CPTMutableLineStyle *axisStyle = [CPTMutableLineStyle lineStyle];
    axisStyle.lineColor = [CPTColor grayColor];
    
    
    CPTMutableTextStyle* ts = [CPTMutableTextStyle textStyle];
    ts.color = [CPTColor whiteColor];
    
    x.axisLineStyle = axisStyle;
    x.labelTextStyle = ts;
    x.majorIntervalLength = CPTDecimalFromFloat(1);
    x.minorTicksPerInterval = 0;
    x.borderWidth = 1;
    x.labelExclusionRanges = [NSArray arrayWithObjects:
                            [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(-10) 
                                                        length:CPTDecimalFromFloat(10)], 
                            nil];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setMaximumFractionDigits:0];
     
    x.majorTickLength = 1.0;
    x.labelFormatter = formatter;
    
    CPTXYAxis *y = axisSet.yAxis;

    y.majorIntervalLength = CPTDecimalFromFloat(1);
    y.minorTicksPerInterval = 0; 
    y.labelTextStyle = ts;
    y.axisLineStyle = axisStyle;
    y.labelFormatter = formatter;
    y.labelExclusionRanges = [NSArray arrayWithObjects:
                              [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(-10) 
                                                           length:CPTDecimalFromFloat(10)], 
                              nil];
    
    NuTurn* trn = [self.game.turns anyObject];
    
    for (NuPlayer* player in trn.players)
    {
        [graph addPlot:[self graphShipsForPlayer:player]];
    }
}

- (CPTPlot*)graphShipsForPlayer:(NuPlayer*)player
{
    CPTScatterPlot *shipPlot = [[[CPTScatterPlot alloc]
                                     initWithFrame:graph.bounds] autorelease];
    shipPlot.identifier = [NSString stringWithFormat:@"%ld", player.playerId];

    CPTMutableLineStyle* ls = [[[CPTMutableLineStyle alloc] init] autorelease];
    
    NSColor* playerColor = [self.colors colorForPlayer:player.playerId];
    CGColorRef cColor = CPTCreateCGColorFromNSColor(playerColor);
    ls.lineColor = 
        [CPTColor colorWithCGColor:cColor];;
    ls.lineWidth = 2.0;
    
    [shipPlot setDataLineStyle:ls];
    
    shipPlot.dataSource = self;
    
    CPTPlotSymbol *greenCirclePlotSymbol = [CPTPlotSymbol ellipsePlotSymbol];
    greenCirclePlotSymbol.fill = [CPTFill fillWithColor:[CPTColor colorWithCGColor:cColor]];
    greenCirclePlotSymbol.size = CGSizeMake(5.0, 5.0);
    [shipPlot setPlotSymbol:greenCirclePlotSymbol];  
    
    return shipPlot;
}

-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot;
{
    return [self.game.turns count];
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot 
                     field:(NSUInteger)fieldEnum 
               recordIndex:(NSUInteger)index 
{
   
    NSLog(@"Field Enum: %ld", fieldEnum);
    if (CPTScatterPlotFieldY == fieldEnum)
    {
        NuTurn* thisTurn = [self.game getTurnNumber:index+1];
        
        NuPlayer* thisPlayer = nil;
        
        for (NuPlayer* playa in thisTurn.players)
        {
            NSNumber* playaId = [NSNumber numberWithInteger:playa.playerId];
            NSString* plyrstr = (NSString*) plot.identifier;
            NSNumber* thisPlayerId = [NSNumber numberWithInteger:[plyrstr intValue]];
            
            if ([playaId isEqualToNumber:thisPlayerId])
            {
                thisPlayer = playa;
            }
        }
        
        return [NSNumber numberWithInteger:thisPlayer.priorityPoints];
    }

    // X-Axis is turn number
    return [NSNumber numberWithInteger:index+1];
}

@end
