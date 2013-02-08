//
//  main.m
//  Exercises
//
//  Created by Zhang Studyro on 13-1-30.
//  Copyright (c) 2013年 Studyro Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PZBinaryTree.h"
#import "PZAVLTree.h"
#import "PZObject.h"

void testSwap()
{
    NSString *active = @"active";
    NSString *passive = @"passive";
    
    NSString *temp = active;
    active = passive;
    passive = temp;
    
    NSLog(@"%@ and %@", active, passive);
}

int main(int argc, const char * argv[])
{
    @autoreleasepool {
        /*
        PZAVLTree *binaryTree = [[PZAVLTree alloc] init];
        
        PZObject *valueToDelete = nil;
        
        PZObject *o1 = [[PZObject alloc] init]; o1.amount = 5;
        PZObject *o2 = [[PZObject alloc] init]; o2.amount = 3;
        PZObject *o3 = [[PZObject alloc] init]; o3.amount = 7;
        PZObject *o4 = [[PZObject alloc] init]; o4.amount = 2;
        PZObject *o5 = [[PZObject alloc] init]; o5.amount = 4;
        PZObject *o6 = [[PZObject alloc] init]; o6.amount = 6;
        PZObject *o7 = [[PZObject alloc] init]; o7.amount = 1;
        
        [binaryTree insertValue:o1]; [o1 release];
        NSLog(@"o1 : 5 inserted");
        [binaryTree insertValue:o2]; [o2 release];
        NSLog(@"o2 : 3 inserted");
        [binaryTree insertValue:o3]; [o3 release];
        NSLog(@"o3 : 7 inserted");
        [binaryTree insertValue:o4]; [o4 release];
        NSLog(@"o4 : 2 inserted");
        [binaryTree insertValue:o5]; [o5 release];
        NSLog(@"o5 : 4 inserted");
        [binaryTree insertValue:o6]; [o6 release];
        NSLog(@"o5 : 6 inserted");
        [binaryTree insertValue:o7]; [o7 release];
        NSLog(@"o5 : 1 inserted");
        
        valueToDelete = o1;
        
        NSLog(@"%@", [binaryTree description]);
        NSLog(@"value to delete : %@", [valueToDelete description]);
        [binaryTree removeValueEqualsToValue:valueToDelete];
        NSLog(@"%@", [binaryTree description]);
        
        [binaryTree release];*/
        testSwap();
    }
    return 0;
}

