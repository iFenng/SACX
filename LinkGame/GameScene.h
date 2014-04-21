//
//  MyScene.h
//  LinkGame
//

//  Copyright (c) 2014 Wang. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <AVFoundation/AVFoundation.h>
#import "ItemNode.h"
#import "CountDownLabel.h"
@interface GameScene : SKScene
@property (strong,nonatomic) ItemNode *fristTouched;
@property (strong,nonatomic) NSArray *fristTouch;

//item数组
@property (strong,nonatomic) NSMutableArray * mapArray;

//地图数组
@property (strong,nonatomic) NSMutableArray * itemsArray;


@property (nonatomic) AVAudioPlayer * backgroundMusicPlayer;

@property (nonatomic) int mapRow;
@property (nonatomic) int mapColume;

@end
