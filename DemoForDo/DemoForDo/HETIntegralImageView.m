//
//  HETIntegralImageView.m
//  DemoForDo
//
//  Created by Start on 2018/5/9.
//  Copyright © 2018年 Start. All rights reserved.
//

#import "HETIntegralImageView.h"

@implementation HETIntegralImageView
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
    self.roundLayer = [CAShapeLayer layer];
    self.roundLayer.bounds = CGRectMake(0, 0, 3, 3);
    self.roundLayer.position = CGPointMake(self.bounds.size.width-3, 1.5);
    UIBezierPath *roundBezi = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 3, 3) cornerRadius:1.5];
    self.roundLayer.path = roundBezi.CGPath;
    self.roundLayer.fillColor = [UIColor redColor].CGColor;
    [self.layer addSublayer:self.roundLayer];
}
@end
