//
//  WinScreen.m
//  LinkGame
//
//  Created by git on 14-4-18.
//  Copyright (c) 2014年 Wang. All rights reserved.
//

#import "WinScreen.h"

@implementation WinScreen

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        [self setBackgroundImg];
        [self runWinAction];
    }
    return self;
}

-(void)setBackgroundImg
{
    int value = arc4random()%6;
    SKSpriteNode *itmeNode = [SKSpriteNode spriteNodeWithImageNamed:[NSString stringWithFormat:@"gameBG%d",value]];
    itmeNode.position = CGPointMake(self.size.width/2,self.size.height/2);
    itmeNode.size = CGSizeMake(itmeNode.size.width/2, itmeNode.size.height/2);
    [self addChild:itmeNode];
}

-(void)runWinAction
{
    [self runAction:[SKAction playSoundFileNamed:@"win.aac" waitForCompletion:NO]];
    SKSpriteNode *winNode = [[SKSpriteNode alloc] initWithImageNamed:@"shengli-0"];
    winNode.position = CGPointMake(self.size.width/2,self.size.height/2);
    winNode.size = CGSizeMake(358.4, 481.6);//原图0.8
    [self addChild:winNode];
    
    NSMutableArray *winImgs = [[NSMutableArray alloc] init];
    for (int i=0; i<31; i++) {
        NSString *textureName = [NSString stringWithFormat:@"shengli-%d", i];
        SKTexture *temp = [SKTexture textureWithImage:[UIImage imageNamed:textureName]];
        [winImgs addObject:temp];
    }
    SKAction *winAction = [SKAction animateWithTextures:winImgs timePerFrame:0.15];
    [winNode runAction:winAction completion:^{
        SKLabelNode *label = [[SKLabelNode alloc] initWithFontNamed:@"STBaoli-SC-Regular"];
        [label setText:@"继续下一关"];
        [label setPosition:CGPointMake(self.size.width/2, 50)];
        [label setColor:[UIColor greenColor]];
        [label setColorBlendFactor:1];
        [self addChild:label];
    }];
}

@end
