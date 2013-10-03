//
//  ViewController.m
//  Point
//
//  Created by sohu on 13-5-22.
//  Copyright (c) 2013年 Qu. All rights reserved.
//

#import "ViewController.h"
#import "PointView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _pointView = [[PointView alloc] initWithFrame:CGRectMake(0, 100, 300, 300)];
    _pointView.circlePoint = CGPointMake(radius , 0);;
    [self.view addSubview:_pointView];
	// Do any additional setup after loading the view, typically from a nib.
    
}

#pragma mark
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    startPoint = [[touches anyObject] locationInView:_pointView];    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint current = [[touches anyObject] locationInView:_pointView];
    _pointView.circlePoint = current;
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

@end
