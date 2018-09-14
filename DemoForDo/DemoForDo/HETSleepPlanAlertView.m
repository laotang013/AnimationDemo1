//
//  HETSleepPlanAlertView.m
//  CSleepDolphin
//
//  Created by 刘宏扬 on 2018/4/2.
//  Copyright © 2018年 HET. All rights reserved.
//

#import "HETSleepPlanAlertView.h"

typedef void(^continuePlanAction)(void);

@interface HETSleepPlanAlertView ()

//弹窗方框
@property (nonatomic,strong) UIView *alertContainer;

//奖杯图片
@property (nonatomic,strong) UIImageView *trophyImageView;

@property (nonatomic,strong) UIImageView *trophyBgImageView;

//标题
@property (nonatomic,strong) UILabel *titleLabel;

//信息
@property (nonatomic,strong) UILabel *msgInfoLabel;

//完成天数
@property (nonatomic,strong) UILabel *scoresLabel;

//哄我睡
@property (nonatomic,strong) UIButton *continueBtn;


@property (nonatomic,strong) UIButton *cancelBtn;

//已完成时间天数
@property (nonatomic) NSUInteger doneDays;

//计划时间天数
@property (nonatomic) NSUInteger planDays;

//详细信息
@property (nonatomic,assign) NSUInteger scores;

//按钮事件
@property (nonatomic,copy) continuePlanAction continuePlanAction;

@end


@implementation HETSleepPlanAlertView

static HETSleepPlanAlertView *alertView = nil;

+ (void)showPlanAlertWithPlanDays:(NSUInteger)planDays
                         doneDays:(NSUInteger)doneDays
                           scores:(NSUInteger)scores
                  continuePlanAction:(void(^)(void))continuePlanAction{
    //
    if (alertView) {
        [alertView hiddenAlert];
        alertView = nil;
    }
    //
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    alertView = [[HETSleepPlanAlertView alloc] initWithFrame:keyWindow.bounds doneDays:doneDays planDays:planDays scores:scores continuePlanAction:continuePlanAction];
    [keyWindow addSubview:alertView];
    [HETSleepPlanAlertView shakeToShow:alertView.alertContainer];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.25 animations:^{
            alertView.trophyBgImageView.alpha = 1.0f;
        }completion:^(BOOL finished) {
            [HETSleepPlanAlertView shakeAnimationForView:alertView.trophyBgImageView.layer];
        }];
    });
}

+ (void)shakeAnimationForView:(CALayer *)layer {
    [layer removeAllAnimations];
    CGPoint position = [layer position];
    CGPoint position1 = CGPointMake(position.x+2, position.y+2);
    CAKeyframeAnimation *opacity = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    opacity.values = @[@(position),@(position1)];
    
    CAKeyframeAnimation *scale = [CAKeyframeAnimation animationWithKeyPath:@"scale"];
    scale.values = @[@(1.0),@(1.2)];
    scale.fillMode = kCAFillModeForwards;

    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[opacity,scale];
    animationGroup.duration = 0.1;
    animationGroup.autoreverses = NO;
    animationGroup.repeatCount = 3;
    animationGroup.removedOnCompletion = NO;
    
    [layer addAnimation:animationGroup forKey:nil];
}

+ (void)shakeToShow:(UIView*)aView
{
    [aView.layer removeAllAnimations];
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.3;// 动画时间
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    
    [aView.layer addAnimation:animation forKey:nil];
}

+ (void)hiddenPlanAlert{
    [alertView hiddenAlert];
    alertView = nil;
}


- (void)dealloc{
    NSLog(@"HETCourseDoneAlertView Dealloc");
}

- (instancetype)initWithFrame:(CGRect)frame doneDays:(NSUInteger)doneDays planDays:(NSUInteger)planDays scores:(NSUInteger)scores continuePlanAction:(void(^)(void))continuePlanAction{
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.doneDays = doneDays;
        self.planDays = planDays;
        self.scores = scores;
        self.continuePlanAction = continuePlanAction;
        [self createSubViews];
        [self createAlertInfo];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    return [self initWithFrame:frame doneDays:0 planDays:0 scores:0 continuePlanAction:nil];
}

- (void)createSubViews{
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    
    [self addSubview:self.alertContainer];
    [self.alertContainer addSubview:self.trophyBgImageView];
    [self.alertContainer addSubview:self.trophyImageView];
    [self.alertContainer addSubview:self.titleLabel];
    [self.alertContainer addSubview:self.msgInfoLabel];
    [self.alertContainer addSubview:self.scoresLabel];
    [self.alertContainer addSubview:self.continueBtn];
    [self.alertContainer addSubview:self.cancelBtn];
    
    
    //弹窗方框
    [self.alertContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.centerX);
        make.left.equalTo(kWidthAfterScale(33));
        make.right.equalTo(-kWidthAfterScale(33));
        make.centerY.equalTo(self);
        make.height.greaterThanOrEqualTo(260);
    }];
    
    
    //奖杯图片
    [self.trophyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.left.equalTo(20);
        make.right.equalTo(-20);
        make.height.equalTo(112);
    }];
    
    [self.trophyBgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.trophyImageView);
    }];
    
    //标题
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.trophyImageView.bottom).offset(22);
        make.left.right.equalTo(self.trophyImageView);
        make.height.equalTo(20);
    }];
    
    //信息
    [self.msgInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.bottom).offset(18);
        make.centerX.equalTo(self.titleLabel.centerX);
        make.width.equalTo(self.titleLabel.width);
        make.height.greaterThanOrEqualTo(14);
    }];
    
    //分数
    [self.scoresLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.msgInfoLabel.bottom).offset(16);
        make.centerX.equalTo(self.msgInfoLabel.centerX);
        make.width.equalTo(self.msgInfoLabel.width);
        make.height.greaterThanOrEqualTo(32);
    }];
    
    
    //继续
    [self.continueBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scoresLabel.bottom).offset(22);
        make.centerX.equalTo(self.alertContainer);
        make.width.equalTo(176);
        make.height.equalTo(32);
    }];
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.continueBtn.bottom).offset(16);
        make.centerX.equalTo(self.alertContainer);
        make.width.equalTo(176);
        make.height.equalTo(32);
        make.bottom.equalTo(self.alertContainer.bottom).offset(-22);
    }];
}

- (void)createAlertInfo{
    //title
    self.titleLabel.text = self.doneDays >= self.planDays?@"本周睡吧计划已完成":[NSString stringWithFormat:@"本周睡吧计划已完成%d天",(int)self.doneDays];
    //完成天数
    self.scoresLabel.text = [NSString stringWithFormat:@"+%d",(int)self.scores];

}

//MARK: - Action

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    if (!CGRectContainsPoint(self.alertContainer.frame, location)) {
        [self hiddenAlert];
    }
}

- (void)btnAction:(UIButton *)sender{
    if (self.continuePlanAction) {
        [self hiddenAlert];
        self.continuePlanAction();
    }
}

- (void)cancelBtnAction:(UIButton *)sender{
    [self hiddenAlert];
}

- (void)hiddenAlert{
    [self hiddenAlertWithCompletion:nil];
}

- (void)hiddenAlertWithCompletion:(void(^)(BOOL finished))completion{
    [self.layer removeAllAnimations];
    [UIView animateWithDuration:0.075 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if (completion) {
            completion(finished);
        }
    }];
}


//MARK: - Getter

//弹窗方框
- (UIView *)alertContainer{
    if (!_alertContainer) {
        _alertContainer = [[UIView alloc] init];
        _alertContainer.backgroundColor = [UIConfig colorFromHexRGB:@"000000" alpha:0.95];
        _alertContainer.layer.cornerRadius = 6;
        _alertContainer.layer.masksToBounds = YES;
    }
    return _alertContainer;
}

//奖杯图片
- (UIImageView *)trophyImageView{
    if (!_trophyImageView) {
        _trophyImageView = [[UIImageView alloc] init];
        _trophyImageView.contentMode = UIViewContentModeScaleAspectFit;
        _trophyImageView.image = [UIImage imageNamed:@"sleepPlanAlertFlower"];
        
        _trophyImageView.layer.shadowColor = [[UIColor yellowColor] CGColor];
        _trophyImageView.layer.shadowOffset = CGSizeMake(0.0f, 5.0f); //[水平偏移, 垂直偏移]
        _trophyImageView.layer.shadowOpacity = 1.0f; // 0.0 ~ 1.0 的值
        _trophyImageView.layer.shadowRadius = 30.0f; // 阴影发散的程度
    }
    return _trophyImageView;
}

- (UIImageView *)trophyBgImageView{
    if (!_trophyBgImageView) {
        _trophyBgImageView = [[UIImageView alloc] init];
        _trophyBgImageView.contentMode = UIViewContentModeScaleAspectFit;
        _trophyBgImageView.image = [UIImage imageNamed:@"sleepPlanAlertBg"];
        _trophyBgImageView.alpha = 0.0f;
    }
    return _trophyBgImageView;
}

//标题
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = [UIColor colorFromHexRGB:@"ffffff" alpha:1.0f];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"本周期的课程已完成";
    }
    return _titleLabel;
}

//信息
- (UILabel *)msgInfoLabel{
    if (!_msgInfoLabel) {
        _msgInfoLabel = [[UILabel alloc] init];
        _msgInfoLabel.font = [UIFont systemFontOfSize:12];
        _msgInfoLabel.textColor = [UIColor whiteColor];
        _msgInfoLabel.numberOfLines = 0;
        _msgInfoLabel.text = @"———— 获得积分奖励 ————";
        _msgInfoLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _msgInfoLabel;
}



//分数
- (UILabel *)scoresLabel{
    if (!_scoresLabel) {
        _scoresLabel = [[UILabel alloc] init];
        _scoresLabel.font = [UIFont boldSystemFontOfSize:30.0f];
        _scoresLabel.textColor = [UIColor colorFromHexRGB:@"FCB94F" alpha:1.0f];
        _scoresLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _scoresLabel;
}

//下周继续睡吧计划
- (UIButton *)continueBtn{
    if (!_continueBtn) {
        _continueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _continueBtn.backgroundColor = [UIColor colorFromHexRGB:@"33c5df" alpha:1.0];
        [_continueBtn setTitle:@"下周继续睡吧计划" forState:UIControlStateNormal];
        [_continueBtn setTitleColor:[UIColor colorFromHexRGB:@"ffffff" alpha:1] forState:UIControlStateNormal];
        _continueBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _continueBtn.layer.cornerRadius = 16;
//        _continueBtn.layer.borderWidth = 0.5;
//        _continueBtn.layer.borderColor = [UIColor colorFromHexRGB:@"33c5df" alpha:1].CGColor;
        _continueBtn.layer.masksToBounds = YES;
        
        [_continueBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _continueBtn;
}

- (UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setTitle:@"暂时不要" forState:UIControlStateNormal];
        [_cancelBtn setTintColor:[UIConfig colorFromHexRGB:@"000000" alpha:0.95]];
        [_cancelBtn setTitleColor:[UIColor colorFromHexRGB:@"ffffff" alpha:0.3] forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_cancelBtn addTarget:self action:@selector(cancelBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}



@end
