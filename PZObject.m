//
//  PZObject.m
//  Exercises
//
//  Created by Zhang Studyro on 13-1-30.
//  Copyright (c) 2013年 Studyro Studio. All rights reserved.
//

#import "PZObject.h"

@implementation PZObject

- (NSComparisonResult)comparesToObject:(id<PZComparableProtocol>)object
{
    if (![object isKindOfClass:[self class]]) return -1;
    
    PZObject *anotherObj = (PZObject *)object;
    if (self.amount == anotherObj.amount) return NSOrderedSame;
    else if (self.amount > anotherObj.amount) return NSOrderedDescending;
    else return NSOrderedAscending;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%lu", self.amount];
}

@end
