//
//  FailScreen.m
//  LinkGame
//
//  Created by git on 14-4-18.
//  Copyright (c) 2014年 Wang. All rights reserved.
//

#import "FailScreen.h"

@implementation FailScreen
-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        self.canTouch = NO;
        [self setBackgroundImg];
        [self runfailAction];
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

-(void)runfailAction
{

    [self runAction:[SKAction waitForDuration:100000]];
    [self runAction:[SKAction playSoundFileNamed:@"fail.aac" waitForCompletion:NO]];
    SKSpriteNode *failNode = [[SKSpriteNode alloc] initWithImageNamed:@"shibai-0"];
    failNode.size = CGSizeMake(258.4, 434.4);//原图0.8
    failNode.position = CGPointMake(self.size.width/2,self.size.height/2+100);
    
    [self addChild:failNode];
    
    NSMutableArray *failImgs = [[NSMutableArray alloc] init];
    for (int i=0; i<12; i++) {
        NSString *textureName = [NSString stringWithFormat:@"shibai-%d", i];
        SKTexture *temp = [SKTexture textureWithImage:[UIImage imageNamed:textureName]];
        [failImgs addObject:temp];
    }
    SKAction *failAction = [SKAction animateWithTextures:failImgs timePerFrame:0.15];
    [failNode runAction:failAction completion:^{
        SKLabelNode *label = [[SKLabelNode alloc] initWithFontNamed:@"STBaoli-SC-Regular"];
        [label setText:@"重新挑战"];
        [label setPosition:CGPointMake(self.size.width/2, 50)];
        [label setColor:[UIColor magentaColor]];
        [label setColorBlendFactor:1];
        [self addChild:label];
        self.canTouch = YES;
    }];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    if (self.canTouch) {
        // Configure the view.
        
        SKView * skView = (SKView *)self.view;
        skView.showsFPS = YES;
        skView.showsNodeCount = YES;
        
        // Create and configure the scene.
        SKScene * scene = [GameScene sceneWithSize:skView.bounds.size];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        
        // Present the scene.
        [skView presentScene:scene];
    }
    
}


@end
