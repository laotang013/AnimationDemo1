
//
//  CAShapeLayerViewDemo.m
//  UIBezierPathDemo
//
//  Created by Start on 2018/4/19.
//  Copyright © 2018年 Start. All rights reserved.
//

#import "CAShapeLayerViewDemo.h"

@implementation CAShapeLayerViewDemo
/*
 1.图形的世界里 两种图形 位图bitmap 和 矢量图 vector
  位图是通过排列像素点来构造的 像素点的信息包括颜色+透明度(ARGB) 颜色通过一共有4个信息(透明度、R、G、B)
 矢量图是通过多个点进行布局然后按照一定规则进行连线后形成的图形。矢量图的信息总共只有两个:点属性和线属性
 点属性包括 点的坐标 连线顺序 线属性 包括 线宽 描线颜色等
 
*/

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
    shapeLayer.lineWidth = 5;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    //stroke是描线的意思
    //UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 40, 40)];
    //路径的坐标是相对于shapeLayer的左上角 然后把它的CGPath属性赋值给shapeLayer
    shapeLayer.path = [self pathForCircle].CGPath;
    //将shapeLayer加到层级上
    [self.layer addSublayer:shapeLayer];
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"strokeEnd";
    animation.duration = 3;
    animation.fromValue = @0;
    
    [shapeLayer addAnimation:animation forKey:@"startStart"];
    
}

-(UIBezierPath *)pathForCircle
{
//    UIBezierPath *berzierPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(30, 30, 100, 100)];
//    UIBezierPath *subPath = [UIBezierPath bezierPath];
//    [subPath moveToPoint:CGPointMake(80, 130)];
//    [subPath addLineToPoint:CGPointMake(230, 130)];
//    [berzierPath appendPath:subPath];
//    return berzierPath;
    
    
//    UIBezierPath *path = [UIBezierPath bezierPath];
//    [path moveToPoint:CGPointMake(0, 0)];
//    [path addArcWithCenter:CGPointMake(100, 100) radius:100 startAngle:0 endAngle:M_PI clockwise:YES];
//    [path addLineToPoint:CGPointMake(20, 20)];
//    return path;
    
//
//    UIBezierPath *path = [UIBezierPath bezierPath];
//    [path moveToPoint:CGPointMake(0, 0)];
//    [path addQuadCurveToPoint:CGPointMake(200, 120) controlPoint:CGPointMake(100, 200)];
//    return path;
    
    
    
//    CGFloat width = [UIScreen mainScreen].bounds.size.width;
//    CGFloat height = [UIScreen mainScreen].bounds.size.height;
//    UIBezierPath *path = [UIBezierPath bezierPath];
//    [path moveToPoint:CGPointMake(0, height-height/4)];
//    for(int i=1;i<width;i++)
//    {
//        CGFloat y = sin(2*M_PI*i/100);
//        CGPoint point = CGPointMake(i, height-y);
//        [path addLineToPoint:point];
//    }
//    return path;
    
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(200,200) radius:100 startAngle:M_PI_2 endAngle:0 clockwise:YES];
    return path;
    
    
}
-(void)bezierPathTest
{
    /*
     UIBezierPath 封装一个表示抽象贝塞尔曲线的类
     所有的UIBezierPath对象能够通过对其添加子曲线来变得更为复杂。
     一旦移动了moveToPoint就相当于当前绘制点移动到了这个方法的参数指定的点。
     任何贝塞尔曲线都可以随时添加各种子路径。
     //除了move和add 方法来添加新的路径外还可以使用appendPath方法来拼接子路径
     
     CAShapeLayer的可动画属性
        strokeStart 是一个标记为Animatable的属性 它表示描线开始的地方占总路径的百分比 默认是0 取值范围
         [0,1];
        strokeEnd 代表了绘制结束的地方站总路径的百分比默认值是1.取值范围是[0,1]。如果小于等于strokeStart，则绘制不出任何内容。
     
     
     
    */
}

//蒙版
-(void)testMask
{
   //1.如果你要显示一个图层的内容，需要将其加到图层的层级上。
   //2.可以通过将一个CALayer的内容通过位图的形式渲染进coreGraphics绘图上下文来进行一些其他操作。
   //3.CALayer拥有一个叫做mask，作为这个CALayer对象的蒙版。mask本身也是一个CALayer。
    CALayer *layer = [CALayer layer];
    CALayer *maskLayer = [CALayer layer];
    layer.mask = maskLayer;
    //这样的话maskLayer就称为了layer的蒙版。maskLayer类似于一个子图层。相对于父图层布局。但是他却不是一个普通的子图层，maskLayer并不会直接绘制在父图层上，maskLayer并不会直接绘制在父图层之上，它只是定义了父图层的“可视部分”。layer中，只有maskLayer有内容的部分被留下来了。其余部分都被挖走了。
    //蒙版是作用是为一个CALayer（包括其子类）对象抠出某个形状的内容来显示，其满足“被蒙版的图层只留下蒙版不透明部分的内容
    
}

@end
