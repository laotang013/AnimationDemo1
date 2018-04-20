//
//  TestAnimationLayer.m
//  UIBezierPathDemo
//
//  Created by Start on 2018/4/18.
//  Copyright © 2018年 Start. All rights reserved.
//
//
#import "TestAnimationLayer.h"

@implementation TestAnimationLayer
- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
}

- (void)setPosition:(CGPoint)position
{
    [super setPosition:position];
    
//    if ([self.delegate respondsToSelector:@selector(actionForLayer:forKey:)]) {
//        id obj = [self.delegate actionForLayer:self forKey:@"position"];
//        if (!obj) {
//            // 隐式动画
//        } else if ([obj isKindOfClass:[NSNull class]]) {
//            // 直接重绘（无动画）
//        } else {
//            // 使用obj生成CAAnimation
//            CAAnimation * animation;
//            [self addAnimation:animation forKey:nil];
//        }
//    }
}

- (void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];
}

/*
 原来UIView的center的getter方法只是简单的去获取自己持有的那个layer的position然后返回。
 */
- (CGPoint)position
{
    return [super position];
}

/*
 所以当我们给一个UIView设置frame的时候，这个view首先调用自己layer的setFrame方法，而在layer的setFrame方法里实际上又调用了setBounds和setPosition，说明layer的frame这个属性实际上并没有实例变量，它的setter和getter仅仅是去调用其bounds和position的setter和getter而已，也就是说frame实际上是由bounds和position来决定的（实际上还有anchorPoint，这里没有加到实验中来，大家可以自己试一试）。而UIView的frame并没有调用UIView的center和bounds的setter和getter，它仅仅是去调用其持有的layer的frame的setter和getter而已。
 
 UIView本身负责处理交互事件，其持有一个Layer，用来负责绘制这个View的内容。而我们对UIView的和绘制相关的属性赋值和访问的时候（frame、backgroundColor等）UIView实际上是直接调用其Layer对应的属性（frame对应frame，center对应position等）的getter和setter。
 
 */

/*
 当我们直接对可动画属性赋值的时候，由于有隐式动画存在的可能，CALayer首先会判断此时有没有隐式动画被触发。它会让它的delegate（没错CALayer拥有一个属性叫做delegate）调用actionForLayer:forKey:来获取一个返回值，这个返回值在声明的时候是一个id对象，当然在运行时它可能是任何对象。这时CALayer拿到返回值，将进行判断：如果返回的对象是一个nil，则进行默认的隐式动画；如果返回的对象是一个[NSNull null] ，则CALayer不会做任何动画；如果是一个正确的实现了CAAction协议的对象，则CALayer用这个对象来生成一个CAAnimation，并加到自己身上进行动画。
 */


@end
