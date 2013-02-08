//
//  PZBinaryTree.m
//  Exercises
//
//  Created by Zhang Studyro on 13-1-30.
//  Copyright (c) 2013年 Studyro Studio. All rights reserved.
//

#import "PZBinaryTree.h"

@implementation PZBinaryTree

- (void)dealloc
{
    [self removeAllValues];
    [super dealloc];
}

- (id)init
{
    if (self = [super init]) {
        _nodesCount = 0;
    }
    
    return self;
}

- (BOOL)insertValue:(id<PZComparableProtocol>)value
{
    if (!value)  return NO;
    
    if (_root == NULL) {
        [self _mallocNodeWithValue:value toPointer:&_root];
        return YES;
    }
    
    TreeNode *nextNode = _root;
    TreeNode *finalNode = NULL;
    NSComparisonResult comparisionResult = NSOrderedSame;
    while (nextNode != NULL) {
        finalNode = nextNode;
        comparisionResult = [value comparesToObject:nextNode->data];
        
        if (comparisionResult == NSOrderedSame) {
            break;
        }
        else if (comparisionResult == NSOrderedAscending) nextNode = nextNode->leftChild;
        else if (comparisionResult == NSOrderedDescending) nextNode = nextNode->rightChild;
    }
    
    if (comparisionResult == NSOrderedSame) return NO;
    
    TreeNode *newNode = NULL;
    [self _mallocNodeWithValue:value toPointer:&newNode];
    
    if (comparisionResult == NSOrderedAscending) finalNode->leftChild = newNode;
    else finalNode->rightChild = newNode;
    
    _nodesCount++;
    
    return YES;
}

- (id<PZComparableProtocol>)minValue
{
    TreeNode **minNode = [self _ptrToMinNodeRooted:&_root];
    
    return (*minNode)?(*minNode)->data:nil;
}

- (id<PZComparableProtocol>)valueEqualsToValue:(id<PZComparableProtocol>)value
{
    TreeNode **node = [self _ptrToNodeOfWhomValueEqualsToValue:value];
    
    return (*node)?(*node)->data:nil;
}

- (BOOL)removeValueEqualsToValue:(id<PZComparableProtocol>)value
{
    if (!value) return NO;
    
    TreeNode **ptrToNodePtr = [self _ptrToNodeOfWhomValueEqualsToValue:value];
    TreeNode *nodeToDelete = *ptrToNodePtr;
    if (nodeToDelete == NULL) return NO;
    
//    TreeNode **ptrToReplaceNode = NULL;
    if (nodeToDelete->rightChild != NULL)
        [self _resetValueByRightChildrenForNodePtr:ptrToNodePtr];
    else if (nodeToDelete->leftChild != NULL)
        [self _resetValueByLeftChildrenForNodePtr:ptrToNodePtr];

//    if (ptrToReplaceNode == NULL) *ptrToNodePtr = NULL;
    
    [nodeToDelete->data release];
    free(nodeToDelete);
    _nodesCount--;
    
    return YES;
}

- (NSUInteger)count
{
    return _nodesCount;
}

- (void)removeAllValues
{
    [self _removeTree:_root];
}

- (NSString *)description
{
    return [self _treeDescription:_root];
}

#pragma mark - Private Methods

/*  Why these methods return the type of '**'?
       Cuz I want to get the exactly raw 'father->leftChild' pointer.
 
    I do always need 'pointer to pointer'
 */
- (TreeNode **)_ptrToMinNodeRooted:(TreeNode **)r
{
    if (r == NULL) return NULL;
    
    TreeNode **ptrToLeftNode = r;
    while (1) {
        if ((*ptrToLeftNode)->leftChild != NULL)
            ptrToLeftNode = &((*ptrToLeftNode)->leftChild);
        else
            break;
    }
    
    return ptrToLeftNode;
}

- (TreeNode **)_ptrToMaxNodeRooted:(TreeNode **)r
{
    if (r == NULL) return NULL;
    
    TreeNode **ptrToRightNode = r;
    while ((*ptrToRightNode)->rightChild != NULL) {
        if ((*ptrToRightNode)->rightChild != NULL)
            ptrToRightNode = &((*ptrToRightNode)->rightChild);
        else
            break;
    }
    
    return ptrToRightNode;
}

- (TreeNode **)_ptrToNodeOfWhomValueEqualsToValue:(id<PZComparableProtocol>)value
{
    TreeNode **ptrToNode = &_root;
    TreeNode **ptrToResult = NULL;
    
    while (*ptrToNode != NULL) {
        ptrToResult = ptrToNode;
        NSComparisonResult comparisionResult = [value comparesToObject:(*ptrToNode)->data];
        
        if (comparisionResult == NSOrderedSame) break;
        else if (comparisionResult == NSOrderedAscending) ptrToNode = &((*ptrToNode)->leftChild);
        else if (comparisionResult == NSOrderedDescending) ptrToNode = &((*ptrToNode)->rightChild);
    }
    
    return ptrToResult;
}

- (void)_resetValueByRightChildrenForNodePtr:(TreeNode **)nodePtr
{
    TreeNode **minNodePtr = [self _ptrToMinNodeRooted:&((*nodePtr)->rightChild)];
    
    TreeNode *tempMinNode = *minNodePtr;
    *minNodePtr = tempMinNode->rightChild;
    tempMinNode->leftChild = (*nodePtr)->leftChild;
    tempMinNode->rightChild = (*nodePtr)->rightChild;
    *nodePtr = tempMinNode;
}

- (void)_resetValueByLeftChildrenForNodePtr:(TreeNode **)nodePtr
{
    TreeNode **maxNoePtr = [self _ptrToMaxNodeRooted:&((*nodePtr)->rightChild)];
    
    TreeNode *tempMaxNode = *maxNoePtr;
    *maxNoePtr = tempMaxNode->leftChild;
    tempMaxNode->rightChild = (*nodePtr)->rightChild;
    tempMaxNode->leftChild = (*nodePtr)->leftChild;
    *nodePtr = tempMaxNode;
}

- (void)_mallocNodeWithValue:(id<PZComparableProtocol>)value toPointer:(TreeNode **)node
{
    *node = malloc(sizeof(TreeNode));
    (*node)->data = [value retain];
    (*node)->leftChild = NULL;
    (*node)->rightChild = NULL;
}

- (void)_removeTree:(TreeNode *)node
{
    if (node == NULL) return;
    
    [self _removeTree:node->leftChild];
    [self _removeTree:node->rightChild];
    
    [node->data release];
    free(node);
}

- (NSString *)_treeDescription:(TreeNode *)node
{
    if (node == NULL) return @"";
    
    NSMutableString *mutableString = [NSMutableString stringWithFormat:@"%@", [node->data description]];
    if (node->leftChild || node->rightChild) {
        [mutableString appendFormat:@"("];
        if (node->leftChild) [mutableString appendFormat:@"L:%@  ", [self _treeDescription:node->leftChild]];
        if (node->rightChild) [mutableString appendFormat:@"R:%@", [self _treeDescription:node->rightChild]];
        [mutableString appendFormat:@")"];
    }
    
    return mutableString;
}

@end
