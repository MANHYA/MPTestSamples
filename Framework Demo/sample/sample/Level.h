//
//  Level.h
//  sample
//
//  Created by Manish on 6/21/18.
//  Copyright © 2018 Aikya. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GameCharactor;

@interface Level : NSObject
@property (copy) GameCharactor *gameCharactor;
- (NSArray<GameCharactor *> *)allGameCharacters;
-(void)firstFunc;
-(void)secondFunc;
@end
