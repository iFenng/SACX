//
//  GameController.m
//  LinkGame
//
//  Created by git on 14-4-21.
//  Copyright (c) 2014年 Wang. All rights reserved.
//

#import "GameController.h"

@implementation GameController
+ (id)shared {
    static GameController *gameController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        gameController = [[self alloc] init];
    });
    return gameController;
}

- (id)init {
    if (self = [super init]) {
        
    }
    return self;
}
@end
