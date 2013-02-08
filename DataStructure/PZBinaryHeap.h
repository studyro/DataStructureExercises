//
//  PZBinaryHeap.h
//  Exercises
//
//  Created by Zhang Studyro on 13-2-8.
//  Copyright (c) 2013年 Studyro Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PZComparableProtocol.h"

@interface PZBinaryHeap : NSObject

- (instancetype)init;

- (instancetype)initWithObjects:(NSArray *)array;

- (BOOL)insertValue:(id<PZComparableProtocol>)value;

- (id<PZComparableProtocol>)minValue;

- (id<PZComparableProtocol>)dequeueMinValue;

- (BOOL)removeMinValue;

- (NSUInteger)count;

@end
