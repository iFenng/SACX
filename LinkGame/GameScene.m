//
//  MyScene.m
//  LinkGame
//
//  Created by git on 3/7/14.
//  Copyright (c) 2014 Wang. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        self.itemsArray = [[NSMutableArray alloc] init];
        self.mapArray = [[NSMutableArray alloc] init];
        [self startGameWithItems:6 row:6 colume:8 empty:2];
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

-(void)readyGofinish:(void (^)())block
{
    CountDownLabel *label3 = [[CountDownLabel alloc]initWithString:@"3" playSound:@"row7.aac" ];
    [self addChild:label3];
    [label3 runActionWithFinishEvent:^{
        CountDownLabel *label2 = [[CountDownLabel alloc]initWithString:@"2" playSound:@"row11.aac" ];
        [self addChild:label2];
        [label2 runActionWithFinishEvent:^{
            CountDownLabel *label1 = [[CountDownLabel alloc]initWithString:@"1" playSound:@"row17.aac" ];
            [self addChild:label1];
            [label1 runActionWithFinishEvent:^{
                CountDownLabel *labelGo = [[CountDownLabel alloc]initWithString:@"Go!!!" playSound:@"readygo.aac" ];
                [self addChild:labelGo];
                [labelGo runActionWithFinishEvent:^{
                    block();
                }];
            }];
        }];
    }];
}


//生成ietm数组
-(void)generateItemArray:(int)itemNum
{
    //  从item0~24中随机选取itemNum个图片
    while ([self.itemsArray count]<itemNum) {
        NSString * itemName = [NSString stringWithFormat:@"item%d",arc4random() % 24];
        BOOL has = NO;
        for (NSString *imgName in self.itemsArray) {
            if ([imgName isEqualToString:itemName]) {
                has = YES;
                break;
            }
        }
        if (!has) {
            [self.itemsArray addObject:itemName];
        }
    }
}

//生成地图数组
-(void)generateMapArray:(int)itemNum row:(int)row colume:(int)colume empty:(int)emptyNum
{
    //    先生成一半
    for (int i= 0; i<row/2; i++) {
        for (int j=0; j<colume; j++) {
            int value = arc4random() % itemNum;            
            ItemNode *itmeNode = [ItemNode spriteNodeWithImageNamed:[NSString stringWithFormat:@"item%d",value]];
            itmeNode.name = [self.itemsArray objectAtIndex:value];
            itmeNode.point = CGPointMake(i, j);
            if (row*colume/2-(i*colume + j) <= emptyNum) {
                itmeNode.hidden = YES;
            }
            [self.mapArray addObject:itmeNode];
        }
    }
    //    复制上一半
    for (int i= row/2; i<row; i++) {
        for (int j=0; j<colume; j++) {
            ItemNode *temp = (ItemNode *)[self.mapArray objectAtIndex:(i-row/2)*colume +j];
            
            ItemNode *itmeNode = [ItemNode spriteNodeWithImageNamed:temp.name];
            itmeNode.name = temp.name;
            itmeNode.point = CGPointMake(i, j);
            itmeNode.hidden = temp.hidden;
            [self.mapArray addObject:itmeNode];
        }
    }
    
    //    打乱顺序
    [self randomInterchange];
    for (ItemNode *temp in self.mapArray) {
        
        NSLog(@"###%@ point(%.0f,%.0f) %d",temp.name,temp.point.x,temp.point.y,temp.hidden);
    }
}


//随机互换数组元素坐标
-(void)randomInterchange
{
    NSInteger count = [self.mapArray count];
    for (int i=0; i<[self.mapArray count]; i++) {
        NSInteger nElements = count - i;
        NSInteger n = (arc4random() % nElements) + i;
        
        ItemNode *itemA = (ItemNode *)[self.mapArray objectAtIndex:i];
        ItemNode *itemB = (ItemNode *)[self.mapArray objectAtIndex:n];
        [self interchangeItemA:itemA itemB:itemB];
    }
    
}

//互换位置
-(void)interchangeItemA:(ItemNode *)itemA itemB:(ItemNode *)itemB
{
    ItemNode *temp = [ItemNode spriteNodeWithImageNamed:itemA.name];
    temp.point = itemA.point;
    itemA.point = itemB.point;
    itemB.point = temp.point;
}

//加载地图
-(void)loadMapArray
{
    int wight = 300/self.mapRow;
    for (ItemNode * itemNode in self.mapArray) {
        itemNode.position = CGPointMake((itemNode.point.x+0.5)*wight+10,(itemNode.point.y+0.5)*wight+(self.size.height-wight*self.mapColume)/2);
        itemNode.size = CGSizeMake(wight, wight);
        [self addChild:itemNode];
    }
    
}

//无解时重新生成地图
-(void)reloadMap
{
    [self randomInterchange];
    [self loadMapArray];
}

-(void)startGameWithItems:(int)itemNum row:(int)row colume:(int)colume empty:(int)emptyNum
{
    [self setBackgroundImg];
    self.mapRow = row;
    self.mapColume = colume;
    [self generateItemArray:itemNum];
    [self generateMapArray:itemNum row:row colume:colume empty:emptyNum];
    
    [self readyGofinish:^{
        [self loadMapArray];
        [self playBgMusic];
    }];
    
}


-(void)playBgMusic
{
    NSError *error;
    NSURL * backgroundMusicURL = [[NSBundle mainBundle] URLForResource:@"bgm_game" withExtension:@"aac"];
    self.backgroundMusicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:backgroundMusicURL error:&error];
    self.backgroundMusicPlayer.numberOfLoops = -1;
    [self.backgroundMusicPlayer prepareToPlay];
    [self.backgroundMusicPlayer play];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    UITouch* touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInNode:self];
    ItemNode* body = (ItemNode *)[self  nodeAtPoint:touchLocation];
    if (body.name && [body.name rangeOfString:@"item"].location != NSNotFound) {
        self.fristTouched = body;
        [body beTouched];
    }
}


-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    
}

@end
