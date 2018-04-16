

//
//  CARoutationView.m
//  UIBezierPathDemo
//
//  Created by Start on 2018/4/16.
//  Copyright © 2018年 Start. All rights reserved.
//

#import "CARoutationView.h"
@interface CARoutationView()<CAAnimationDelegate>
/**cashaplayer*/
@property(nonatomic,strong)CAShapeLayer *shapeLayer;
/**<#name#>*/
@property(nonatomic,strong)CAShapeLayer *trainLayer;
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
    self.shapeLayer = circleLayer;
    [self animationOne];

}
-(void)drawTrain
{
    UIBezierPath *trainBezier = [UIBezierPath bezierPath];
    [trainBezier moveToPoint:CGPointMake(self.center.x-8, self.center.y-8)];
    [trainBezier addLineToPoint:CGPointMake(self.center.x+8, self.center.y-8)];
    [trainBezier addLineToPoint:CGPointMake(self.center.x, self.center.y+8)];
    [trainBezier closePath];
    
    CAShapeLayer *shaper = [CAShapeLayer layer];
    shaper.path = trainBezier.CGPath;
    shaper.lineWidth = 1;
    shaper.fillColor = [UIColor colorWithRed:0.52f green:0.76f blue:0.07f alpha:1.00f].CGColor;
    shaper.strokeColor = [UIColor colorWithRed:0.52f green:0.76f blue:0.07f alpha:1.00f].CGColor;
    [self.layer addSublayer:shaper];
    shaper.bounds = self.bounds;
    shaper.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    self.trainLayer = shaper;
  
}
-(void)animationOne
{
    //做动画
    self.shapeLayer.strokeStart = 0;
    self.shapeLayer.strokeEnd = 0.98;
    CABasicAnimation *circleLayerStart = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    circleLayerStart.duration = 0.7;
    circleLayerStart.fromValue = @(0.0f);
    //    circleLayerStart.toValue = @(1.0f);
    circleLayerStart.delegate = self;
    [circleLayerStart setValue:@"strokeStartEnd" forKey:@"animationName"];
    [self.shapeLayer addAnimation:circleLayerStart forKey:@"strokeStartEnd"];
}
-(void)animationTwo
{
    self.shapeLayer.strokeStart = 0.98;
    CABasicAnimation *circleLayerEnd = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    circleLayerEnd.duration = 0.7;
    circleLayerEnd.fromValue = @(0.0f);
    circleLayerEnd.toValue = @(1.0f);
    circleLayerEnd.delegate = self;
    [circleLayerEnd setValue:@"strokeEndStart" forKey:@"animationName"];
    [self.shapeLayer addAnimation:circleLayerEnd forKey:@"strokeEndStart"];
}
-(void)animationThree
{
    CABasicAnimation *rotationAni = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAni.duration = 0.7;
    rotationAni.fromValue = @(0);
    rotationAni.toValue = @(M_PI*2);
    rotationAni.delegate = self;
    [rotationAni setValue:@"rotation" forKey:@"animationName"];
    [self.trainLayer addAnimation:rotationAni forKey:@"rotation"];
}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if ([[anim valueForKeyPath:@"animationName"] isEqualToString:@"strokeStartEnd"]) {
        [self animationTwo];
        [self animationThree];
    }else if ([[anim valueForKey:@"animationName"]isEqualToString:@"strokeEndStart"])
    {
        [self.layer removeAllAnimations];
        [self.shapeLayer removeAllAnimations];
        [self.trainLayer removeAllAnimations];
        [self animationOne];
    }
}


-(void)layoutSubviews
{
    [super layoutSubviews];
  
}
@end
