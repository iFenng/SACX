//
//  GameController.h
//  LinkGame
//
//  Created by git on 14-4-21.
//  Copyright (c) 2014年 Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameController : NSObject
+ (id)shared;
-(void)randomInterchange:(NSMutableArray *)array;
@end
