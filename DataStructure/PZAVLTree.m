//
//  PZAVLTree.m
//  Exercises
//
//  Created by Zhang Studyro on 13-1-30.
//  Copyright (c) 2013年 Studyro Studio. All rights reserved.
//

#import "PZAVLTree.h"

@interface PZAVLTree ()

@end

@implementation PZAVLTree

- (void)dealloc
{
    [super dealloc]; // parent class will deal the clear works
}

- (id)init
{
    if (self = [super init]) {
        _root = NULL;
    }
    
    return self;
}

// TODO : try to implement a non-recursive algorithm of insertion and deletion
- (BOOL)insertValue:(id<PZComparableProtocol>)value
{
    return [self _insertValue:value toNode:&_root];
}

- (BOOL)removeValueEqualsToValue:(id<PZComparableProtocol>)value
{
    return [self _removeValue:value toNode:&_root foundNode:NULL];
}

#pragma mark - Private Methods

- (BOOL)_insertValue:(id<PZComparableProtocol>)value toNode:(TreeNode **)node
{
    if (*node == NULL) {
        [self _mallocNodeWithValue:value toPointer:node]; // height is set here
        _nodesCount++;
        return YES;
    }
    
    NSComparisonResult comparisionResult = [value comparesToObject:(*node)->data];
    if (comparisionResult == NSOrderedSame) return NO;
    
    if (comparisionResult == NSOrderedAscending) {
        if (![self _insertValue:value toNode:&((*node)->leftChild)]) return NO;
    }
    else {
        if (![self _insertValue:value toNode:&((*node)->rightChild)]) return NO;
    }
    
    if ([self _heightOfNode:(*node)->leftChild] >= [self _heightOfNode:(*node)->rightChild] + 2) {
        if ((*node)->leftChild->leftChild != NULL)
            [self _singleRotationLeftChild:node];
        else
            [self _doubleRotationLeftChild:node];
    }
    else if ([self _heightOfNode:(*node)->rightChild] >= [self _heightOfNode:(*node)->leftChild] + 2) {
        if ((*node)->rightChild->rightChild != NULL)
            [self _singleRotationRightChild:node];
        else
            [self _doubleRotationRightChild:node];
    }
    
    [self _setHeightOfNode:*node];
    return YES;
}

- (BOOL)_removeValue:(id<PZComparableProtocol>)value toNode:(TreeNode **)node foundNode:(TreeNode **)foundNode
{
    if (node == NULL && foundNode == NULL) return NO;
    
    // do search
    if (foundNode == NULL) {
        NSComparisonResult comparisionResult = [value comparesToObject:(*node)->data];
        if (comparisionResult == NSOrderedAscending) {
            if (![self _removeValue:value toNode:&((*node)->leftChild) foundNode:NULL]) return NO;
        }
        else if (comparisionResult == NSOrderedDescending) {
            if (![self _removeValue:value toNode:&((*node)->rightChild) foundNode:NULL]) return NO;
        }
        else {
            // recursively find min node of right subtree, then remove the foundNode
            if ((*node)->rightChild) [self _removeValue:value toNode:&(*node)->rightChild foundNode:node];
            // one step to remove the foundNode
            else if ((*node)->leftChild) {
                TreeNode *tempLeftChild = (*node)->leftChild;
                [self _freeNodeWithPointer:node];
                *node = tempLeftChild;
            }
            else {
                [self _freeNodeWithPointer:node];
                return YES;
            }
        }
    }
    // do get min node of the foundNode's right sub tree, switch it with foundNode
    else {
        if ((*node)->leftChild) [self _removeValue:value toNode:&((*node)->leftChild) foundNode:foundNode];
        else {
            TreeNode *tempMinNode = *node;
            TreeNode *tempLeftChildOfFound = (*foundNode)->leftChild;
            TreeNode *tempRightChildOfFound = (*foundNode)->rightChild;
            [self _freeNodeWithPointer:foundNode];
            *node = (*node)->rightChild;
            tempMinNode->leftChild = tempLeftChildOfFound;
            tempMinNode->rightChild = tempRightChildOfFound;
            *foundNode = tempMinNode;
            return YES;
        }
    }
    // check the node if it needs to be rotated
    if ([self _heightOfNode:(*node)->leftChild] >= [self _heightOfNode:(*node)->rightChild] + 2) {
        if ((*node)->leftChild->leftChild != NULL)
            [self _singleRotationLeftChild:node];
        else
            [self _doubleRotationLeftChild:node];
    }
    else if ([self _heightOfNode:(*node)->rightChild] >= [self _heightOfNode:(*node)->leftChild] + 2) {
        if ((*node)->rightChild->rightChild != NULL)
            [self _singleRotationRightChild:node];
        else
            [self _doubleRotationRightChild:node];
    }
    // reset height
    [self _setHeightOfNode:*node];
    
    return YES;
}

- (void)_mallocNodeWithValue:(id<PZComparableProtocol>)value toPointer:(TreeNode **)node
{
    *node = malloc(sizeof(TreeNode));
    (*node)->leftChild = NULL;
    (*node)->rightChild = NULL;
    (*node)->data = [value retain];
    [self _setHeightOfNode:*node];
}

- (void)_freeNodeWithPointer:(TreeNode **)node
{
    if (node == NULL) return;
    
    [(*node)->data release];
    free(*node);
    *node = NULL;
}

- (NSInteger)_heightOfNode:(TreeNode *)node
{
    return node == NULL?-1:node->height;
}

- (void)_setHeightOfNode:(TreeNode *)node
{
    if (node == NULL) return;
    
    node->height = MAX([self _heightOfNode:node->leftChild], [self _heightOfNode:node->rightChild]) + 1;
}

- (void)_singleRotationLeftChild:(TreeNode **)node
{
    TreeNode *k1 = (*node)->leftChild;
    (*node)->leftChild = k1->rightChild;
    k1->rightChild = *node;
    [self _setHeightOfNode:*node];
    [self _setHeightOfNode:k1];
    *node = k1;
}

- (void)_singleRotationRightChild:(TreeNode **)node
{
    TreeNode *k1 = (*node)->rightChild;
    (*node)->rightChild = k1->leftChild;
    k1->leftChild = *node;
    [self _setHeightOfNode:*node];
    [self _setHeightOfNode:k1];
    *node = k1;
}

- (void)_doubleRotationLeftChild:(TreeNode **)node
{
    [self _singleRotationRightChild:&((*node)->leftChild)];
    [self _singleRotationLeftChild:node];
}

- (void)_doubleRotationRightChild:(TreeNode **)node
{
    [self _singleRotationLeftChild:&((*node)->rightChild)];
    [self _singleRotationRightChild:node];
}

@end
