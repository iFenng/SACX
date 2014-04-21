//
//  CountDownLabel.h
//  LinkGame
//
//  Created by git on 14-4-19.
//  Copyright (c) 2014年 Wang. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface CountDownLabel : SKLabelNode
- (id)initWithString:(NSString *)string playSound:(NSString *)sound;
-(void)runActionWithFinishEvent:(void (^)())block;
@end
