

//
//  CAShapeLayerView.m
//  UIBezierPathDemo
//
//  Created by Start on 2018/4/16.
//  Copyright © 2018年 Start. All rights reserved.
//

#import "CAShapeLayerView.h"
@interface CAShapeLayerView()<CAAnimationDelegate>

@end
@implementation CAShapeLayerView

/*
 1.使用CAShapeLayer与贝塞尔曲线可以实现不在View的drawRect方法中画出一些想要的图形。

 区别:
 DrawRect：DrawRect属于CoreGraphic框架，占用CPU，消耗性能大
 CAShapeLayer：CAShapeLayer属于CoreAnimation框架，通过GPU来渲染图形，节省性能。动画渲染直接提交给手机GPU，不消耗内存

 CAShapeLayer中shape代表形状的意思，所以需要形状才能生效
 贝塞尔曲线可以创建基于矢量的路径
 贝塞尔曲线给CAShapeLayer提供路径，CAShapeLayer在提供的路径中进行渲染。路径会闭环，所以绘制出了Shape
 用于CAShapeLayer的贝塞尔曲线作为Path，其path是一个首尾相接的闭环的曲线，即使该贝塞尔曲线不是一个闭环的曲线

 */

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
    self.backgroundColor = [UIColor colorWithRed:0.98f green:0.81f blue:0.84f alpha:1.00f];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [self addGestureRecognizer:tap];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.layer.cornerRadius = self.frame.size.height*0.5;
}
-(void)tap:(UITapGestureRecognizer*)tapGes
{
    //推荐的做法是先显式地改变 Model Layer 的对应属性，再应用动画。这样一来，我们甚至省去了 toValue。
    self.layer.cornerRadius = 50;
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    basicAnimation.fromValue =@(self.frame.size.height*0.5);
    basicAnimation.delegate = self;
    basicAnimation.duration = 0.5f;
    basicAnimation.timingFunction  = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    basicAnimation.fillMode = kCAFillModeForwards;
    basicAnimation.removedOnCompletion = NO;
    [self.layer addAnimation:basicAnimation forKey:@"cornerRadius"];
}
-(void)animationDidStart:(CAAnimation *)anim
{
    if ([[self.layer animationForKey:@"cornerRadius"] isEqual:anim]) {
        [UIView animateWithDuration:0.6 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:0 animations:^{
            self.bounds = CGRectMake(0, 0, 100, 100);
            self.backgroundColor = [UIColor colorWithRed:1.00f green:0.80f blue:0.56f alpha:1.00f];
        } completion:^(BOOL finished) {
            [self.layer removeAllAnimations];
            [self checkAnimation];
        }];
    }
}

-(void)checkAnimation
{
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(self.frame.size.width/4, self.frame.size.height*0.5)];
    [bezierPath addLineToPoint:CGPointMake(self.frame.size.width/2, self.frame.size.height/4*3)];
    [bezierPath addLineToPoint:CGPointMake(self.frame.size.width/4*3, self.frame.size.height/4)];
    //UIBezierPath只是告诉路径给CAShapeLayer，具体这个shpe什么样子由CAShapeLayer来决定
    //所以一些属于lineWidth，fillColor是在shpe上设置的，在UIBezierPath上设置无效
    shapeLayer.lineWidth = 17;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = [UIColor grayColor].CGColor;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.path = bezierPath.CGPath;
    [self.layer addSublayer:shapeLayer];
    
//    //动画
    CABasicAnimation *shapeAnimation = [ CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    shapeAnimation.duration = 0.5;
    shapeAnimation.fromValue =@(0.0f);
    shapeAnimation.toValue = @(1.0f);
    [shapeLayer addAnimation:shapeAnimation forKey:@"strokeEnd"];

}


@end
