//
//  ItemNode.h
//  LinkGame
//
//  Created by git on 14-4-12.
//  Copyright (c) 2014年 Wang. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface ItemNode : SKSpriteNode

//地图中的坐标点（行，列）
@property (nonatomic) CGPoint point;
//scene中的坐标点（x，y）记录初始位置
@property (nonatomic) CGPoint initialPoint;


//被点击
-(void)beTouched;

//消除
-(void)eliminate;

//恢复常态
-(void)reset;

@end
