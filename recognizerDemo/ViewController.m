//
//  ViewController.m
//  recognizerDemo
//
//  Created by word on 13-5-3.
//  Copyright (c) 2013年 com. a. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

/*
 UITapGestureRecognizer         Tap（点击）
 UIPinchGestureRecognizer       Pinch（捏合）
 UIRotationGestureRecognizer    Rotation（旋转）
 UISwipeGestureRecognizer       Swipe（滑动，快速移动，是用于监测滑动的方向的）
 UIPanGestureRecognizer         Pan （拖移，慢速移动，是用于监测偏移的量的）
 UILongPressGestureRecognizer   LongPress（长按）
 */

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setFrame:CGRectMake(50, 50, 100, 100)];
    [btn setBackgroundImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateNormal];
    // 拖移的 Recognizer
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self                                               action:@selector(handlePan:)];
    [btn addGestureRecognizer:panGestureRecognizer];
    
    
    UIView *tapView = [[UIView alloc] initWithFrame:CGRectMake(10, 50, 300, 300)];
    [tapView setBackgroundColor:[UIColor redColor]];
    // 单击的 Recognizer
    UITapGestureRecognizer* singleRecognizer;
    singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SingleTap:)];
    //点击的次数
    singleRecognizer.numberOfTapsRequired = 1; // 单击
    //点击的手指数
    singleRecognizer.numberOfTouchesRequired = 2;
    
    //给view添加一个手势监测；
    [tapView addGestureRecognizer:singleRecognizer];
    
    
    // 双击的 Recognizer
    UITapGestureRecognizer* doubleRecognizer;
    doubleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(DoubleTap:)];
    doubleRecognizer.numberOfTapsRequired = 2; // 双击
    //关键语句，给self.view添加一个手势监测；
    [tapView addGestureRecognizer:doubleRecognizer];
    
    // 关键在这一行，双击手势确定监测失败才会触发单击手势的相应操作
    [singleRecognizer requireGestureRecognizerToFail:doubleRecognizer];
    
    // 捏合的 Recognizer
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
    [tapView addGestureRecognizer:pinchGestureRecognizer];
    
    // 旋转的 Recognizer
    UIRotationGestureRecognizer *rotateRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotate:)];
    [tapView addGestureRecognizer:rotateRecognizer];
    
    // 长按的 Recognizer
    UILongPressGestureRecognizer *longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    //设置长按时间间隔
    [longPressRecognizer setMinimumPressDuration:1.0];
    [tapView addGestureRecognizer:longPressRecognizer];
    
    // 滑动的 Recognizer
    UISwipeGestureRecognizer *swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    //设置滑动方向
    [swipeRecognizer setDirection:UISwipeGestureRecognizerDirectionDown];
    [tapView addGestureRecognizer:swipeRecognizer];
    
    
    [self.view addSubview:tapView];
    [self.view addSubview:btn];
}

- (void)handlePan:(UIPanGestureRecognizer*) recognizer
{
    NSLog(@"拖移，慢速移动");
    CGPoint translation = [recognizer translationInView:self.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x, recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointZero inView:self.view];
}

-(void)SingleTap:(UITapGestureRecognizer*)recognizer
{
    //处理单击操作
    NSLog(@"单击");
}

-(void)DoubleTap:(UITapGestureRecognizer*)recognizer
{
    //处理双击操作
    NSLog(@"双击");
    
}

- (void) handlePinch:(UIPinchGestureRecognizer*) recognizer
{
    NSLog(@"捏合, %f", recognizer.scale);
    recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, recognizer.scale, recognizer.scale);
    recognizer.scale = 1;
}

- (void) handleRotate:(UIRotationGestureRecognizer*) recognizer
{
    NSLog(@"旋转, %f", recognizer.rotation);
    recognizer.view.transform = CGAffineTransformRotate(recognizer.view.transform, recognizer.rotation);
    recognizer.rotation = 0;
}

-(void)handleLongPress:(UILongPressGestureRecognizer*)recognizer
{
    //处理长按操作
    NSLog(@"长按, %f", recognizer.minimumPressDuration);
}

-(void)handleSwipe:(UISwipeGestureRecognizer*)recognizer
{
    //处理滑动操作
    NSLog(@"滑动，快速移动");
    CGPoint translation = [recognizer locationInView:self.view];
    NSLog(@"Swipe - start location: %f,%f", translation.x, translation.y);
    //    recognizer.view.transform = CGAffineTransformMakeTranslation(translation.x, translation.y);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
