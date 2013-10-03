//
//  PointView.m
//  Point
//
//  Created by sohu on 13-5-22.
//  Copyright (c) 2013年 Qu. All rights reserved.
//

#import "PointView.h"
#import <math.h>
#import <QuartzCore/QuartzCore.h>

static int numebrOfcirce = 1;

@implementation PointView
@synthesize circlePoint = _circlePoint;

- (id)initWithFrame:(CGRect)frame
{
    
    frame.size.width = 2 * radius;
    frame.size.height = 2 * radius;
    self = [super initWithFrame:frame];
    if (self) {
        _startAngle = 0.f;
        isStartAgain  = NO;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setCirclePoint:(CGPoint)AcirclePoint
{
    if (numebrOfcirce == 3 && isStartAgain) return;
    
    _circlePoint = AcirclePoint;
    _circlePoint = [self fixPointToCircle];
    [self setNeedsDisplay];
    CGFloat angle = [self getAngleWithPoint:_circlePoint];
    if (angle < 0.2 && angle >=0) {
        isStartAgain  = YES;
    }
    if (angle > 1.8 && angle <=2) {
        if (isStartAgain) {
            if (numebrOfcirce <= 3){
                if (_startAngle <= angle) { //逆序转
                    numebrOfcirce ++;
                }else{
                    numebrOfcirce --;
                }
            }
            isStartAgain = NO;
        }
    }
    _preAngle = angle;
    NSLog(@"%f %d",angle, numebrOfcirce);
}
- (CGFloat)getAngleWithPoint:(CGPoint)point
{
    NSLog(@"ffffff : %f",point.x);
    CGFloat angle = acosf((circleCenter.y - point.y) / radius) / M_PI;
    if (_circlePoint.x - circleCenter.x < 0) {
        angle = 2 - angle;
    }
    return angle;
    NSLog(@"%f %d",angle, numebrOfcirce);

}
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGContextRef context= UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect);
    //绘制透明背景
    CGContextSetFillColorWithColor(context, [[UIColor redColor] CGColor]);
    CGContextFillRect(context, (CGRect){0,0,rect.size});
    
    //绘制箭头
    CGContextSaveGState(context);
    CGContextSetRGBStrokeColor(context, 0/255.f, 0/255, 0/255.f, 1.f);
    CGContextSetLineWidth(context, 2.0);
    CGContextMoveToPoint(context, rect.size.width /2.f, rect.size.height / 2.f);
    CGContextAddLineToPoint(context, _circlePoint.x,_circlePoint.y);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
    
}

- (CGPoint)fixPointToCircle
{
    return [self fixAngleWithPoint:_circlePoint];
}

- (CGPoint)fixAngleWithPoint:(CGPoint)point
{
    return [self fixPoint:point OnTheSameCirleWithFirPoint:CGPointMake(radius, 0)];
}

- (CGPoint)fixPoint:(CGPoint)point OnTheSameCirleWithFirPoint:(CGPoint)firPoint
{
    CGFloat location = sqrtf(
                             (point.y - circleCenter.y) *  (point.y - circleCenter.y) +
                             (point.x - circleCenter.x)  * (point.x - circleCenter.x));
    
    CGFloat firLocation = sqrtf(
                                (firPoint.y - circleCenter.y) * (firPoint.y - circleCenter.y) +
                                (firPoint.x - circleCenter.x) * (firPoint.x - circleCenter.x));
    
    CGFloat scale = firLocation / location;
    CGPoint finalPoint = CGPointZero;
    finalPoint.x = scale * (point.x - circleCenter.x) + radius;
    finalPoint.y = scale * (point.y - circleCenter.y) + radius;
//    NSLog(@"%f %f %f",finalPoint.x , finalPoint.y,
//          sqrt((finalPoint.x - circleCenter.x)*(finalPoint.x - circleCenter.x) + (finalPoint.y - circleCenter.y) * (finalPoint.y - circleCenter.y)));
    return finalPoint;
}

@end
