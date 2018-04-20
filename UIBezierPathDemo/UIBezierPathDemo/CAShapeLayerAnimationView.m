//
//  CAShapeLayerAnimationView.m
//  UIBezierPathDemo
//
//  Created by Start on 2018/4/19.
//  Copyright © 2018年 Start. All rights reserved.
//

#import "CAShapeLayerAnimationView.h"
@interface CAShapeLayerAnimationView()
/**height*/
@property(nonatomic,assign)CGFloat height;
@end
@implementation CAShapeLayerAnimationView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupSubViews];
    }
    return self;
}

-(void)setupSubViews
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.fillColor = [UIColor orangeColor].CGColor;
    //shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.lineWidth = 1;
   
    [self.layer addSublayer:shapeLayer];
    //fromPath
        UIBezierPath *berzith =  [UIBezierPath bezierPath];
        [berzith moveToPoint:CGPointMake(0, 0)];
        [berzith addLineToPoint:CGPointMake(0, 300)];
        [berzith addQuadCurveToPoint:CGPointMake([UIScreen mainScreen].bounds.size.width, 300) controlPoint:CGPointMake([UIScreen mainScreen].bounds.size.width/2,400)];
        [berzith addLineToPoint:CGPointMake([UIScreen mainScreen].bounds.size.width, 0)];
        [berzith addLineToPoint:CGPointMake(0, 0)];
        [berzith closePath];
        shapeLayer.path = berzith.CGPath;
    
    
    //toPath
//    UIBezierPath *toBerzith = [UIBezierPath bezierPath];
//    [toBerzith moveToPoint:CGPointMake(0, 0)];
//    [toBerzith addLineToPoint:CGPointMake(0, [UIScreen mainScreen].bounds.size.height)];
//    [toBerzith addQuadCurveToPoint:CGPointMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) controlPoint:CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height-100)];
//    [toBerzith addLineToPoint:CGPointMake([UIScreen mainScreen].bounds.size.width, 0)];
//    [toBerzith closePath];
  
    self.height = 100.0f;
   UIBezierPath *toBerzith =  [self getPathWithHeight:self.height];
    
    //动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.duration = 3;
    animation.fromValue = (__bridge id _Nullable)(berzith.CGPath);
    shapeLayer.path = toBerzith.CGPath;
    [shapeLayer addAnimation:animation forKey:nil];
   

    [UIView animateWithDuration:0.7 delay:0.0f usingSpringWithDamping:0.5f initialSpringVelocity:0.9f options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction animations:^{
        self.height = 0;
        [self getPathWithHeight:self.height];
        [self setNeedsDisplay];
    } completion:^(BOOL finished) {
        [self getPathWithHeight:self.height];
    }];
    
    
 
    
    
}

- (UIBezierPath *)getPathWithHeight:(CGFloat)height{
    UIBezierPath *toBerzith = [UIBezierPath bezierPath];
    [toBerzith moveToPoint:CGPointMake(0, 0)];
    [toBerzith addLineToPoint:CGPointMake(0, [UIScreen mainScreen].bounds.size.height)];
    [toBerzith addQuadCurveToPoint:CGPointMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) controlPoint:CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height-height)];
    [toBerzith addLineToPoint:CGPointMake([UIScreen mainScreen].bounds.size.width, 0)];
        [toBerzith closePath];
    return toBerzith;
}

@end
