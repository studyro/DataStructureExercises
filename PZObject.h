//
//  PZObject.h
//  Exercises
//
//  Created by Zhang Studyro on 13-1-30.
//  Copyright (c) 2013年 Studyro Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PZComparableProtocol.h"

@interface PZObject : NSObject <PZComparableProtocol>
@property (nonatomic, assign) NSUInteger amount;
@end
