//
//  NuHull+Sorting.m
//  PlanuPlanu
//
//  Created by Cameron Hotchkies on 12/30/11.
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

#import "NuHull+Sorting.h"

@implementation NuHull (Sorting)

NSComparisonResult (^valcompare)(NSInteger,NSInteger) = ^(NSInteger lhs, NSInteger rhs) 
{
    if(lhs < rhs) 
    {
        return (NSComparisonResult)NSOrderedAscending;
    } 
    else if(lhs > rhs) 
    {
        return (NSComparisonResult)NSOrderedDescending;
    }
    
    return (NSComparisonResult)NSOrderedSame;
};

- (NSComparisonResult)nameComparison:(NuHull *)otherHull;
{
    return [self.name caseInsensitiveCompare:otherHull.name];
}

- (NSComparisonResult)hullIdComparison:(NuHull *)otherHull;
{
    return [self genericComparison:self.hullId and:otherHull.hullId for:otherHull];
}

- (NSComparisonResult)techLevelComparison:(NuHull *)otherHull
{    
    return [self genericComparison:self.techLevel and:otherHull.techLevel for:otherHull];
}

- (NSComparisonResult)fuelComparison:(NuHull *)otherHull
{    
    return [self genericComparison:self.fuel and:otherHull.fuel for:otherHull];
}

- (NSComparisonResult)massComparison:(NuHull *)otherHull
{    
    return [self genericComparison:self.mass and:otherHull.mass for:otherHull];
}

- (NSComparisonResult)beamsComparison:(NuHull *)otherHull
{
    return [self genericComparison:self.beams and:otherHull.beams for:otherHull];
}

- (NSComparisonResult)torpsComparison:(NuHull *)otherHull
{
    return [self genericComparison:self.torpedoes 
                               and:otherHull.torpedoes
                               for:otherHull];
}

- (NSComparisonResult)baysComparison:(NuHull *)otherHull
{
    return [self genericComparison:self.fighterBays
                               and:otherHull.fighterBays 
                               for:otherHull];
    
}

- (NSComparisonResult)genericComparison:(NSInteger)lhs and:(NSInteger)rhs for:(NuHull*)otherHull
{    
    NSComparisonResult retVal = [[NSNumber numberWithInteger:lhs] 
                                 compare:[NSNumber numberWithInteger:rhs]];
    
    if (retVal != NSOrderedSame)
    {
        return retVal;
    }
    
    return [self nameComparison:otherHull];
}

@end
