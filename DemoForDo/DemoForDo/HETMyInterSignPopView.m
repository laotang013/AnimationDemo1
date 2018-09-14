



//
//  HETMyInterSignPopView.m
//  CSleepDolphin
//
//  Created by Start on 2018/5/8.
//  Copyright © 2018年 HET. All rights reserved.
//
/*
 弹框思路:
 1.提供一个show方法
 2.提供一个disMiss方法
 3.将这个View加在window上
  3.1 加一个蒙版 用系统自带的毛玻璃效果
  3.2 蒙版上加一个View
  3.3View显示的时候 从小到大进行展示 scale
  3.4 View消失的时候alpha 从1到0后removeFromSuperView
 */
#import "HETMyInterSignPopView.h"
@interface HETMyInterSignPopView()<CAAnimationDelegate>
@property(nonatomic,strong)HETMyInterSignPopView *popView;
@property(nonatomic,strong)UIView *containView;
@end
@implementation HETMyInterSignPopView
-(void)show
{
     UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
     self.popView = [[HETMyInterSignPopView alloc]initWithFrame:keyWindow.bounds];
     [keyWindow addSubview:self.popView];
     [self createSubViews];
}

-(void)dismiss
{
    
    [self.popView.layer removeAllAnimations];
    [self.layer removeAllAnimations];
    [self.popView removeFromSuperview];
    self.popView = nil;
    [self removeFromSuperview];
}
#pragma mark - mehod
-(void)createSubViews
{
    //添加一个手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self.popView action:@selector(tap:)];
    [self.popView addGestureRecognizer:tap];
    //添加一个毛玻璃效果
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc]initWithEffect:effect];
    effectView.frame = self.popView.bounds;
    effectView.alpha = 0.8;
    [self.popView addSubview:effectView];
    [self.popView addSubview:self.containView];
    self.containView.center = self.popView.center;
    [self effectViewForScale:effectView keyName:@"effectViewAni" duration:0.1 bounds:self.popView.frame];
    [self effectViewForScale:self.containView keyName:@"containViewAni" duration:0.25 bounds:CGRectMake(0, 0, 200, 200)];
    [self createImages];
}
-(void)createImages
{
    UIImageView *alertBgImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sleepPlanAlertBg"]];
    [self.containView addSubview:alertBgImageView];
    alertBgImageView.frame = CGRectMake(55, 20, 110, 90);
    UIImageView *courseImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"courseFinishToday"]];
    courseImageView.frame = CGRectMake(45, 30, 90, 70);
    [self.containView addSubview:courseImageView];
    UILabel *label = [[UILabel alloc]init];
    label.font = [UIFont systemFontOfSize:13.0f];
    label.text = @"签到成功";
    label.textColor = [UIColor orangeColor];
    label.frame = CGRectMake(75, 120, self.containView.bounds.size.width, 44);
    [self.containView addSubview:label];
    
}

-(void)tap:(UITapGestureRecognizer *)tapGes
{
    [self dismiss];
}
/**缩放动画*/
-(void)effectViewForScale:(UIView *)effectView keyName:(NSString *)keyName duration:(CGFloat)duration bounds:(CGRect)bounds
{
    effectView.bounds = bounds;
    CABasicAnimation *basicAni = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    basicAni.fromValue = @(0);
    basicAni.duration = duration;
    basicAni.delegate = self;
    [basicAni setValue:keyName forKey:@"keyName"];
    [effectView.layer addAnimation:basicAni forKey:keyName];
}



-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if ([[anim valueForKey:@"keyName"]isEqual: @"containViewAni"]) {
        NSLog(@"containView动画停止");
    }
}
-(UIView *)containView
{
    if (!_containView) {
        _containView = [[UIView alloc]init];
        _containView.backgroundColor  = [UIColor grayColor];
    }
    return _containView;
}
@end
