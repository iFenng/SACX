//
//  CountDownLabel.m
//  LinkGame
//
//  Created by git on 14-4-19.
//  Copyright (c) 2014年 Wang. All rights reserved.
//

#import "CountDownLabel.h"

@implementation CountDownLabel
- (id)initWithString:(NSString *)string playSound:(NSString *)sound
{
    if (self = [super init])
    {
        [self setColor:[UIColor magentaColor]];
        [self setColorBlendFactor:1];
        [self setFontName:@"Marker Felt"];
        [self setFontSize:60];
        [self runAction:[SKAction playSoundFileNamed:sound waitForCompletion:NO]];
        [self setText:string];
        
    }
    return self;
}


-(void)runActionWithFinishEvent:(void (^)())block{
    [self setPosition:CGPointMake(self.parent.scene.size.width/2, self.parent.scene.size.height/2)];
    SKAction *actionScale = [SKAction scaleBy:4 duration:1.5];
    SKAction *actionFadeOut = [SKAction fadeOutWithDuration:1.5];
    SKAction *rep = [SKAction group:@[actionScale,actionFadeOut]];
    [self runAction:rep completion:^{
        [self setHidden:YES];
        [self removeFromParent];
        block();
    }];
}
@end
