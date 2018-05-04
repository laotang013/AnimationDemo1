


//
//  HETMyInteralHeadSendView.m
//  CSleepDolphin
//
//  Created by Start on 2018/5/2.
//  Copyright © 2018年 HET. All rights reserved.
//

#import "HETMyInteralHeadSendView.h"
#define margin 8
@interface HETMyInteralHeadSendView()
/**UILabel*/
@property(nonatomic,strong)UILabel *label;
@end
@implementation HETMyInteralHeadSendView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.label =[[UILabel alloc]initWithFrame:CGRectMake(margin*2,margin, self.bounds.size.width-margin*2, self.bounds.size.height-margin*2)];
//        self.label.textColor = [UIColor redColor];
//        self.label.font = [UIFont systemFontOfSize:12.0f];
//        self.label.text = @"啊的发生";
//        [self addSubview:self.label];
    }
    return self;
}
-(void)setSendViewColor:(UIColor *)sendViewColor
{
    _sendViewColor = sendViewColor;
    [self setNeedsDisplay];
}
-(void)drawRect:(CGRect)rect
{
  
    //画外边框 画文字
    [self.sendViewColor set];
    UIBezierPath *berierPath = [UIBezierPath bezierPath];
    berierPath.lineWidth = 1.0;
    berierPath.lineCapStyle = kCGLineCapRound; //线条拐角
    berierPath.lineJoinStyle = kCGLineJoinRound; //终点处理
    [berierPath moveToPoint:CGPointMake(margin, margin)];
    [berierPath addLineToPoint:CGPointMake(self.bounds.size.width*0.5-margin, margin)];
    [berierPath addLineToPoint:CGPointMake(self.bounds.size.width*0.5, 0)];
    [berierPath addLineToPoint:CGPointMake(self.bounds.size.width*0.5+margin,margin)];
    [berierPath addLineToPoint:CGPointMake(self.bounds.size.width-margin, margin)];
   
    [berierPath addQuadCurveToPoint:CGPointMake(self.bounds.size.width-margin, self.bounds.size.height-margin) controlPoint:CGPointMake(self.bounds.size.width+6,self.bounds.size.height*0.5)];
    [berierPath addLineToPoint:CGPointMake(margin, self.bounds.size.height-margin)];
    [berierPath addQuadCurveToPoint:CGPointMake(margin, margin) controlPoint:CGPointMake(-6, self.bounds.size.height*0.5)];
    [berierPath closePath];
    [berierPath fill];
    [berierPath stroke];
    NSString *string = self.sendViewStr;
    NSDictionary *dict  =@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor whiteColor]};
    [string drawInRect:CGRectMake((self.bounds.size.width-4*margin)/2,(self.bounds.size.height-margin*2)/2, self.bounds.size.width, self.bounds.size.height) withAttributes:dict];
    
   
    
  
   
}
@end
