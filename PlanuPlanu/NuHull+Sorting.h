//
//  NuHull+Sorting.h
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/30/11.
//  Copyright 2011 Roboboogie Studios. All rights reserved.
//

#import <PlanuKit/PlanuKit.h>

@interface NuHull (Sorting)

- (NSComparisonResult)nameComparison:(NuHull *)otherHull;
- (NSComparisonResult)hullIdComparison:(NuHull *)otherHull;
- (NSComparisonResult)techLevelComparison:(NuHull *)otherHull;
- (NSComparisonResult)fuelComparison:(NuHull *)otherHull;
- (NSComparisonResult)massComparison:(NuHull *)otherHull;

- (NSComparisonResult)beamsComparison:(NuHull *)otherHull;
- (NSComparisonResult)torpsComparison:(NuHull *)otherHull;
- (NSComparisonResult)baysComparison:(NuHull *)otherHull;

- (NSComparisonResult)genericComparison:(NSInteger)lhs and:(NSInteger)rhs for:(NuHull*)otherHull;

@end
