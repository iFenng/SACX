//
//  GameToolKit.m
//  LinkGame
//
//  Created by git on 14-4-12.
//  Copyright (c) 2014年 Wang. All rights reserved.
//

#import "GameToolKit.h"

@implementation GameToolKit

//生成地图数组
-(NSMutableArray *)generateMapArray:(int)itemNum row:(int)row colume:(int)colume empty:(int)emptyNum
{
    NSMutableArray * itemsArray = [[NSMutableArray alloc] init];
    
//  从item0~24中随机选取itemNum个图片
    for (int i = 0; i<itemNum; i++) {
        NSString * itemName = [NSString stringWithFormat:@"item%d",arc4random() % 24];
        BOOL has = NO;
        for (NSString *imgName in itemsArray) {
            if ([imgName isEqualToString:itemName]) {
                has = YES;
                break;
            }
        }
        if (!has) {
            [itemsArray insertObject:itemName atIndex:i];
        }
    }
    
   
    NSMutableArray * mapArray = [[NSMutableArray alloc] init];
//    先生成一半
    for (int i= 0; i<row/2; i++) {
        for (int j=0; j<colume; j++) {
            int value = arc4random() % itemNum;
            
            ItemNode *itmeNode = [ItemNode spriteNodeWithImageNamed:[NSString stringWithFormat:@"daoju%d",value]];
            itmeNode.name = [itemsArray objectAtIndex:value];
            itmeNode.point = CGPointMake(i, j);
            if (i*row + j >= emptyNum) {
                itmeNode.hidden = YES;
            }
            [mapArray insertObject:itmeNode atIndex:(i*row + j)];
        }
    }
//    复制上一半
    for (int i= row/2; i<row; i++) {
        for (int j=0; j<colume; j++) {
            ItemNode *temp = (ItemNode *)[mapArray objectAtIndex:(i-row/2)*row +j];
            
            ItemNode *itmeNode = [ItemNode spriteNodeWithImageNamed:temp.name];
            itmeNode.name = temp.name;
            itmeNode.point = CGPointMake(i, j);
            itmeNode.hidden = temp.hidden;
            [mapArray insertObject:itmeNode atIndex:(i*row + j)];
        }
    }
//    打乱顺序
    [self randomInterchange:mapArray];
    return mapArray;
}


//随机互换数组元素坐标
-(void)randomInterchange:(NSMutableArray *)mapArray
{
    NSInteger count = [mapArray count];
    for (int i=0; i<[mapArray count]; i++) {
        NSInteger nElements = count - i;
        NSInteger n = (arc4random() % nElements) + i;
        
        ItemNode *itemA = (ItemNode *)[mapArray objectAtIndex:i];
        ItemNode *itemB = (ItemNode *)[mapArray objectAtIndex:n];
        [self interchangeItemA:itemA itemB:itemB];
    }

}

-(void)interchangeItemA:(ItemNode *)itemA itemB:(ItemNode *)itemB
{
    ItemNode *temp = [ItemNode spriteNodeWithImageNamed:itemA.name];
    temp.name = itemA.name;
    temp.point = itemA.point;
    temp.hidden = itemA.hidden;
    
    itemA.name = itemB.name;
    itemA.point = itemB.point;
    itemA.hidden = itemB.hidden;
    
    itemB.name = temp.name;
    itemB.point = temp.point;
    itemB.hidden = temp.hidden;
    
}


@end
