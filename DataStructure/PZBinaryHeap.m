//
//  PZBinaryHeap.m
//  Exercises
//
//  Created by Zhang Studyro on 13-2-8.
//  Copyright (c) 2013年 Studyro Studio. All rights reserved.
//

#import "PZBinaryHeap.h"

#define DEFAULT_SIZE 15
#define PARENT_INDEX(x) (x/2)
#define LEFT_CHILD_INDEX(x) (x+x)

@interface PZBinaryHeap ()
{
    id<PZComparableProtocol> *_objArray;
    __block NSUInteger _size;
    NSUInteger _objCount;
}
@end

@implementation PZBinaryHeap

- (void)dealloc
{
    [self _clearHeap];
    free(_objArray);
    [super dealloc];
}

- (id)init
{
    if (self = [super init]) {
        _objArray = malloc(DEFAULT_SIZE * sizeof(*_objArray));
        _objCount = 0;
        _size = DEFAULT_SIZE;
    }
    
    return self;
}

- (instancetype)initWithObjects:(NSArray *)array
{
    if (self = [super init]) {
        _objArray = malloc([array count] * 2 * sizeof(*_objArray));
        [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
            _objArray[idx+1] = [obj retain];
            _objCount++;
        }];
        
        for (int i = (int)_size / 2; i > 0; i--)
            [self _percolateUpObjectAtIndex:i];
    }
    
    return self;
}

- (void)resizeWithNewSize:(NSUInteger)newSize
{
    id<PZComparableProtocol> *newArray = malloc(newSize * sizeof(*_objArray));
    for (int i = 1; i <= _objCount; i++) {
        id<PZComparableProtocol> tempObj = _objArray[i];
        newArray[i] = [tempObj retain];
        [tempObj release];
    }
    free(_objArray);
    _objArray = newArray;
}

- (BOOL)insertValue:(id<PZComparableProtocol>)value
{
    if (value == nil) return NO;
    if (_objCount >= _size) [self resizeWithNewSize:_size * _size];
    
    _objArray[++_objCount] = [value retain];
    [self _percolateUpObjectAtIndex:_objCount];
    return YES;
}

- (id<PZComparableProtocol>)minValue
{
    if ([self count] == 0) return nil;
    id<PZComparableProtocol> minObject = _objArray[1];
    
    return minObject;
}

- (id<PZComparableProtocol>)dequeueMinValue
{
    if ([self count] == 0) return nil;
    id<PZComparableProtocol> minObject = [_objArray[1] retain];
    [self removeMinValue];
    
    return [minObject autorelease];
}

- (BOOL)removeMinValue
{
    if ([self count] == 0) return NO;
    
    [self _freeObjectAtIndex:1];
    [self switchObjectAtIndex:1 withAnotherObjectAtIndex:_objCount--];
    [self _percolateUpObjectAtIndex:1];
    return YES;
}

- (NSUInteger)count
{
    return _objCount;
}

- (void)switchObjectAtIndex:(NSUInteger)index withAnotherObjectAtIndex:(NSUInteger)anotherIndex
{
    id<PZComparableProtocol> tempObj = _objArray[anotherIndex];
    _objArray[anotherIndex] = _objArray[index];
    _objArray[index] = tempObj;
    
}
#pragma mark - Private Methods
- (void)_percolateUpObjectAtIndex:(NSUInteger)index
{
    if (index > _objCount) return;
    
    while (index > 1 && [_objArray[PARENT_INDEX(index)] comparesToObject:_objArray[index]] == NSOrderedDescending) {
        [self switchObjectAtIndex:index withAnotherObjectAtIndex:PARENT_INDEX(index)];
        index = index / 2;
    }
}

- (void)_percolateDownObjectAtIndex:(NSUInteger)index
{
    NSUInteger holeIndex = index;
    while (holeIndex * 2 <= _objCount) {
        NSUInteger childIndex = holeIndex * 2;
        if (childIndex < _objCount && [_objArray[childIndex] comparesToObject:_objArray[childIndex+1]] == NSOrderedAscending)
            childIndex++;
        if ([_objArray[holeIndex] comparesToObject:_objArray[childIndex]] == NSOrderedDescending)
            [self switchObjectAtIndex:holeIndex withAnotherObjectAtIndex:childIndex];
        else
            break;
        
        holeIndex = childIndex;
    }
}

- (void)_freeObjectAtIndex:(NSUInteger)index
{
    [_objArray[index] release];
    _objArray[index] = nil;
}

- (void)_clearHeap
{
    for (int i = 1; i <= _objCount; i++) {
        [self _freeObjectAtIndex:i];
    }
}

@end
