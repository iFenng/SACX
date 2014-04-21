//
//  ViewController.m
//  LinkGame
//
//  Created by git on 3/7/14.
//  Copyright (c) 2014 Wang. All rights reserved.
//

#import "ViewController.h"
#import "GameScene.h"
#import "WinScreen.h"
#import "FailScreen.h"
@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

}


- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    // Create and configure the scene.
    SKScene * scene = [FailScreen sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

//      遍历字体 搜索SC查找添加的中文字体
//    NSArray *familyNames =[[NSArray alloc]initWithArray:[UIFont familyNames]];
//    NSArray *fontNames;
//    NSInteger indFamily, indFont;
//    for(indFamily=0;indFamily<[familyNames count];++indFamily)
//    {
//        NSLog(@"Family name: %@", [familyNames objectAtIndex:indFamily]);
//        fontNames =[[NSArray alloc]initWithArray:[UIFont fontNamesForFamilyName:[familyNames objectAtIndex:indFamily]]];
//        for(indFont=0; indFont<[fontNames count]; ++indFont)
//        {
//            NSLog(@"    Font name: %@",[fontNames objectAtIndex:indFont]);
//        }
//    }
    

}






- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

@end
