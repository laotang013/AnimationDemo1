

//
//  CARoutationView.m
//  UIBezierPathDemo
//
//  Created by Start on 2018/4/16.
//  Copyright © 2018年 Start. All rights reserved.
//

#import "CARoutationView.h"
@interface CARoutationView()<CAAnimationDelegate>
@end
@implementation CARoutationView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubViews];
    }
    return self;
}
-(void)setupSubViews
{
    /*
      1.一个圆圈
      2. 一个三角形
      圆圈先出现后消失 消失的时候带着三角形旋转
     */
    //self.backgroundColor = [UIColor grayColor];
    [self drawCircle];
    [self drawTrain];
}
-(void)drawCircle
{
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    UIBezierPath *berzierCirclePath = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
    circleLayer.fillColor = [UIColor clearColor].CGColor;
    circleLayer.strokeColor = [UIColor colorWithRed:0.52f green:0.76f blue:0.07f alpha:1.00f].CGColor;
    circleLayer.lineWidth = 1;
    circleLayer.lineCap=kCALineCapRound;
    circleLayer.path = berzierCirclePath.CGPath;
    circleLayer.bounds = self.bounds;
    circleLayer.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    [self.layer addSublayer:circleLayer];
    circleLayer.transform = CATransform3DMakeRotation(-M_PI/2, 0, 0, 1);
    
    
    
    
    
    //做动画
    CABasicAnimation *circleLayerStart = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    circleLayerStart.duration = 0.7;
    circleLayerStart.fromValue = @(0.0f);
    circleLayerStart.toValue = @(1.0f);
    [circleLayer addAnimation:circleLayerStart forKey:@"strokeStartEnd"];
    
    CABasicAnimation *circleLayerEnd = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    circleLayerStart.duration = 0.7;
    circleLayerStart.fromValue = @(1.0f);
    circleLayerStart.toValue = @(.0f);
    [circleLayer addAnimation:circleLayerEnd forKey:@"strokeEndStart"];
    
    
}
-(void)drawTrain
{
    UIBezierPath *trainBezier = [UIBezierPath bezierPath];
    [trainBezier moveToPoint:CGPointMake(self.center.x-20, self.center.y-20)];
    [trainBezier addLineToPoint:CGPointMake(self.center.x+20, self.center.y-20)];
    [trainBezier addLineToPoint:CGPointMake(self.center.x, self.center.y+20)];
    [trainBezier closePath];
    
    CAShapeLayer *shaper = [CAShapeLayer layer];
    shaper.path = trainBezier.CGPath;
    shaper.fillColor = 
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
}
@end
