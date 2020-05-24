//
//  Level.m
//  sample
//
//  Created by Manish on 6/21/18.
//  Copyright © 2018 Aikya. All rights reserved.
//

#import "Level.h"
#import <sample/sample-Swift.h>

@implementation Level

-(instancetype)init {
    if (self = [super init]) {
        NSLog(@"THE LEVEL WAS INITIALIZED");
        
    }
        return self;
}

- (NSArray<GameCharactor *> *)allGameCharacters {
    return  nil;
}

-(void)firstFunc {
    NSLog(@"First Func");

}
-(void)secondFunc {
    NSLog(@"second Func");
}

@end
