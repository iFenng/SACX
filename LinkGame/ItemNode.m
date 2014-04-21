//
//  ItemNode.m
//  LinkGame
//
//  Created by git on 14-4-12.
//  Copyright (c) 2014年 Wang. All rights reserved.
//

#import "ItemNode.h"

@implementation ItemNode


//被点击的动作：微小幅度抖动100次，播放音效
-(void)beTouched
{
    [self runAction:[SKAction playSoundFileNamed:@"link.aac" waitForCompletion:NO]];
    [self shakeTimes:100];
}


//缩小后放大,抖动Node，上下左右随机抖动，抖动幅度为2个像素
-(void)shakeTimes:(NSInteger)times {
    
    self.initialPoint = self.position;
    NSMutableArray * randomActions = [NSMutableArray array];
    SKAction * actionDown = [SKAction scaleTo:0.8 duration:0.3];
    SKAction * actionUp = [SKAction scaleTo:1 duration:0.3];
    [randomActions addObject:actionDown];
    [randomActions addObject:actionUp];
    
    NSInteger amplitudeX = 2;
    NSInteger amplitudeY = 2;
    for (int i=0; i<times; i++) {
        NSInteger randX = self.position.x+arc4random() % amplitudeX - amplitudeX/2;
        NSInteger randY = self.position.y+arc4random() % amplitudeY - amplitudeY/2;
        SKAction *action = [SKAction moveTo:CGPointMake(randX, randY) duration:0.05];
        [randomActions addObject:action];
    }
    
    SKAction *rep = [SKAction sequence:randomActions];
    
    [self runAction:rep completion:^{
        self.position = self.initialPoint;
    }];
}

//消除Node,动画1秒：旋转180度，缩小到%50，淡出同时执行
-(void)eliminate
{
    SKAction *actionRotate = [SKAction rotateByAngle:M_PI duration:1];
    SKAction *actionScale = [SKAction scaleBy:0.5 duration:1];
    SKAction *actionFadeOut = [SKAction fadeOutWithDuration:1];
    SKAction *rep = [SKAction group:@[actionRotate,actionScale,actionFadeOut]];
    [self runAction:rep];
    [self setHidden:YES];
}

//停止所有动画并恢复动画开始前的位置
-(void)reset
{
    [self removeAllActions];
    [self setPosition:self.initialPoint];
}


@end
