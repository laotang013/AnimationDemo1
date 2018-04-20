




//
//  TestAnimationView.m
//  UIBezierPathDemo
//
//  Created by Start on 2018/4/18.
//  Copyright © 2018年 Start. All rights reserved.
//

#import "TestAnimationView.h"

@interface TestAnimationView()
/**layer*/
//@property(nonatomic,strong)TestAnimationLayer *testAnimationLayer;
@end
@implementation TestAnimationView


- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
/*
 ==> 调用顺序
 
     -[UIView init]
     -[UIView initWithFrame:]
     UIViewCommonInitWithFrame
     -[UIView _createLayerWithFrame:]
     -[TestAnimationLayer setBounds:]
     -[TestAnimationView setFrame:]
  1. 先创建layer 然后给layer的bounds赋值 最后才给自己的frame赋值。
  2.设置frame后去调用center 说明UIView的frame 实际上是由center和bounds来决定的。
 */
- (CGPoint)center
{
    return [super center];
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
}
- (void)setCenter:(CGPoint)center
{
    [super setCenter:center];
}
- (void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];
}

+(Class)layerClass
{
    return [TestAnimationLayer class];
}



/*
 一开始断点会疯狂的进入actionForLayer方法 因为我们调用initWithFrame的时候view会调用
 createLayerWithFrame 如果大家打印event参数，会发现在createLayerWithFrame:方法中，系统会依次给layer的以下几个属性赋值：bounds, opaque, contentsScale, rasterizationScale, position，所以actionForLayer:forKey:方法会被调用5次，这5次是在动画block外面调用的，所以我们会发现obj打印出来都是NSNull。
 */
-(id<CAAction>)actionForLayer:(CALayer *)layer forKey:(NSString *)event
{
    id<CAAction>obj = [super actionForLayer:layer forKey:event];
    NSLog(@"obj:%@",obj);
    NSLog(@"event:%@",event);
    return obj;
}



@end
/*
 - (void)setPosition:(CGPoint)position
 {
 //    [super setPosition:position];
 if ([self.delegate respondsToSelector:@selector(actionForLayer:forKey:)]) {
 id obj = [self.delegate actionForLayer:self forKey:@"position"];
 if (!obj) {
 // 隐式动画
 } else if ([obj isKindOfClass:[NSNull class]]) {
 // 直接重绘（无动画）
 } else {
 // 使用obj生成CAAnimation
 CAAnimation * animation;
 [self addAnimation:animation forKey:nil];
 }
 }
 // 隐式动画
 }
 */


//说明:
/*
  1.UIView 负责几乎所有界面展示和用户交互。
  2.CALayer 负责绘制
    我们访问和设置UIView的这些负责显示的属性实际上访问和设置的都是这个CALayer对应的属性。UIView只是将其封装起来了
 */
