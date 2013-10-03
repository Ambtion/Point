//
//  PointView.h
//  Point
//
//  Created by sohu on 13-5-22.
//  Copyright (c) 2013年 Qu. All rights reserved.
//

#import <UIKit/UIKit.h>

#define radius 150.f
#define circleCenter    ((CGPoint){radius,radius})

@interface PointView : UIView
{
    CGPoint _circlePoint;
    CGPoint _prePoint;
    CGFloat _startAngle;
    CGFloat _preAngle;
    BOOL isStartAgain;
}
@property(nonatomic,assign)CGPoint circlePoint;
- (CGPoint)fixPoint:(CGPoint)point OnTheSameCirleWithFirPoint:(CGPoint)firPoint;
@end
