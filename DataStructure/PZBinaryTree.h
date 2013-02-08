//
//  PZBinaryTree.h
//  Exercises
//
//  Created by Zhang Studyro on 13-1-30.
//  Copyright (c) 2013年 Studyro Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PZComparableProtocol.h"

typedef struct _TreeNode TreeNode;

struct _TreeNode {
    TreeNode *leftChild;
    TreeNode *rightChild;
    NSInteger height;
    id<PZComparableProtocol> data;
};


@interface PZBinaryTree : NSObject
{
    @protected
    TreeNode *_root;
    NSUInteger _nodesCount;
}

- (BOOL)insertValue:(id<PZComparableProtocol>)value;

- (id<PZComparableProtocol>)valueEqualsToValue:(id<PZComparableProtocol>)value;

- (id<PZComparableProtocol>)minValue;

- (BOOL)removeValueEqualsToValue:(id<PZComparableProtocol>)value;

- (void)removeAllValues;

- (NSUInteger)count;

@end
