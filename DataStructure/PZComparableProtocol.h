//
//  PZComparableProtocol.h
//  Exercises
//
//  Created by Zhang Studyro on 13-1-30.
//  Copyright (c) 2013年 Studyro Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PZComparableProtocol <NSObject>

- (NSComparisonResult)comparesToObject:(id<PZComparableProtocol>)object;

@end
