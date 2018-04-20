//
//  GoodSliderMenu.m
//  AnimationDemo2
//
//  Created by Start on 2018/4/20.
//  Copyright © 2018年 Start. All rights reserved.
//

#import "GoodSliderMenu.h"
#define buttonSpace 30
#define menuBlankWidth 50
#define menuWidth  self.frame.size.width
#define menuHeight self.frame.size.height
@interface GoodSliderMenu()
@property (nonatomic,strong) CADisplayLink *displayLink;
@property  NSInteger animationCount; // 动画的数量
@end
@implementation GoodSliderMenu
{
    UIVisualEffectView *effectView;
    UIView *helperSideView;
    UIView *helperCenterView;
    UIWindow *keyWindow;
    BOOL triggered;
    CGFloat diff;
    UIColor *_menuColor;
    CGFloat menuButtonHeight;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
      [self setupSubViews];
    }
    return self;
}
#pragma mark - 初始化
-(void)setupSubViews
{
    keyWindow = [UIApplication sharedApplication].keyWindow;
    //1.添加毛玻璃效果
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.alpha = 0.0f;
    effectView.frame = keyWindow.frame;
    _menuColor = [UIColor lightGrayColor];
    //设置frame
    self.frame = CGRectMake(-keyWindow.frame.size.width/2 - menuBlankWidth, 0, keyWindow.frame.size.width/2+menuBlankWidth, keyWindow.frame.size.height);
    self.backgroundColor = [UIColor orangeColor];
    
    //设置两个View
    helperSideView = [[UIView alloc]initWithFrame:CGRectMake(-40, 0, 40, 40)];
    helperSideView.backgroundColor = [UIColor redColor];
    [keyWindow addSubview:helperSideView];
    
    helperCenterView = [[UIView alloc]initWithFrame:CGRectMake(-40, menuHeight*0.5-20, 40, 40)];
    helperCenterView.backgroundColor = [UIColor yellowColor];
    [keyWindow addSubview:helperCenterView];
    
    
}
-(void)drawRect:(CGRect)rect
{
    //划线
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(menuWidth-menuBlankWidth, 0)];
    [path addQuadCurveToPoint:CGPointMake(menuWidth-menuBlankWidth, menuHeight) controlPoint:CGPointMake(keyWindow.frame.size.width/2+diff,menuHeight*0.5)];
    [path addLineToPoint:CGPointMake(0, menuHeight)];
    [path closePath];
    
    //填充颜色
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddPath(context, path.CGPath);
    [_menuColor set];
    CGContextFillPath(context);
}



//显示
-(void)show
{
    if (!triggered) {
        [keyWindow insertSubview:effectView belowSubview:self];
        [keyWindow insertSubview:self aboveSubview:keyWindow];
        [UIView animateWithDuration:0.25 animations:^{
            self.frame = self.bounds;
        }];
        [self beforeAnimation];
        [UIView animateWithDuration:0.7 delay:0.0f usingSpringWithDamping:0.5f initialSpringVelocity:0.9 options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionAllowUserInteraction animations:^{
            helperSideView.center = CGPointMake(keyWindow.center.x, helperSideView.frame.size.height*0.5);
        } completion:^(BOOL finished) {
            [self finishAnimation];
        }];
        [UIView animateWithDuration:0.3 animations:^{
            effectView.alpha = 0.35f;
        }];
        [self beforeAnimation];
        [UIView animateWithDuration:0.7 delay:0.0f usingSpringWithDamping:0.8f initialSpringVelocity:2.0f options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction  animations:^{
            helperCenterView.center = keyWindow.center;
        } completion:^(BOOL finished) {
            if (finished) {
                UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGes:)];
                [effectView addGestureRecognizer:tapGes];
                [self finishAnimation];
            }
        }];
        triggered = YES;
    }else
    {
        [self dismiss];
        [self removeFromSuperview];
    }
}
//隐藏
-(void)dismiss
{
    triggered = NO;
    [UIView animateWithDuration:0.3 animations:^{
          self.frame = CGRectMake(-keyWindow.frame.size.width/2-menuBlankWidth, 0, keyWindow.frame.size.width/2+menuBlankWidth, keyWindow.frame.size.height);
    }];
    [self beforeAnimation];
    [UIView animateWithDuration:0.7 delay:0.0f usingSpringWithDamping:0.6f initialSpringVelocity:0.9f options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction animations:^{
        helperSideView.center = CGPointMake(-helperSideView.frame.size.height/2, helperSideView.frame.size.height/2);
    } completion:^(BOOL finished) {
        [self finishAnimation];
    }];
    
    [UIView animateWithDuration:0.3 animations:^{
        effectView.alpha = 0.0f;
    }];
    
    [self beforeAnimation];
    [UIView animateWithDuration:0.7 delay:0.0f usingSpringWithDamping:0.7f initialSpringVelocity:2.0f options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction animations:^{
        helperCenterView.center = CGPointMake(-helperSideView.frame.size.height/2, CGRectGetHeight(keyWindow.frame)/2);
    } completion:^(BOOL finished) {
        [self finishAnimation];
    }];
    
}
//点击事件
-(void)tapGes:(UITapGestureRecognizer *)tap
{
    [self show];
}

//开始动画
-(void)beforeAnimation
{
    if (self.displayLink == nil) {
        self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkAction:)];
        [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    }
    self.animationCount ++;
}

//结束动画
-(void)finishAnimation
{
    self.animationCount--;
    if (self.animationCount == 0) {
        [self.displayLink invalidate];
        self.displayLink = nil;
    }
}

//计算diff
-(void)displayLinkAction:(CADisplayLink *)dis
{
    CALayer *sideHelperPresenttationLayer =  (CALayer *)helperSideView.layer.presentationLayer;
    CALayer *centerHelperPresentationLayer =  (CALayer *)[helperCenterView.layer presentationLayer];
    CGRect centerRect = [[centerHelperPresentationLayer valueForKey:@"frame"] CGRectValue];
    CGRect sideRect = [[sideHelperPresenttationLayer valueForKey:@"frame"] CGRectValue];
    diff = sideRect.origin.x - centerRect.origin.x;
    [self setNeedsDisplay];
}
@end
