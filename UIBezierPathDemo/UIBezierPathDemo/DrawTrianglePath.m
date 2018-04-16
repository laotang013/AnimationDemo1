//
//  DrawTrianglePath.m
//  UIBezierPathDemo
//
//  Created by Start on 2018/4/16.
//  Copyright © 2018年 Start. All rights reserved.
//

#import "DrawTrianglePath.h"

@implementation DrawTrianglePath

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
   
    [self drawSecondBezierPath:self.bezierPath];
}

-(void)drawTrianglePath
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(10, 10)];
    [path addLineToPoint:CGPointMake(50, 10)];
    [path addLineToPoint:CGPointMake(30, 30)];
    [path closePath];
    //设置线宽
    path.lineWidth = 1.5;
    //设置填充的颜色
    UIColor *blueColor = [UIColor blueColor];
    [blueColor set];
    [path fill];
    //设置画笔的颜色
    UIColor *strokeColor = [UIColor redColor];
    [strokeColor set];
    //根据我们设置的各个点连线
    [path stroke];
}

//画二次贝塞尔曲线
-(void)drawSecondBezierPath:(UIBezierPath *)path
{
    [path moveToPoint:CGPointMake(20, self.frame.size.height-20)];
    [path addQuadCurveToPoint:CGPointMake(self.frame.size.width-20, self.frame.size.height - 50) controlPoint:self.point];
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    path.lineWidth = 5.0;
    
    UIColor *strokeColor = [UIColor redColor];
    [strokeColor set];
    [path stroke];

}
@end
