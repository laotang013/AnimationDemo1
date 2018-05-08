

//
//  HETDemoView.m
//  DemoForDo
//
//  Created by Start on 2018/5/4.
//  Copyright © 2018年 Start. All rights reserved.
//

#import "HETDemoView.h"
#define margin 4
@implementation HETDemoView


- (void)drawRect:(CGRect)rect {
    [[UIColor grayColor]set];//设置颜色 填充颜色
    //1.画一个圆角矩形以及一个头尖角
    UIBezierPath *berierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(margin, margin, self.bounds.size.width-2*margin, self.bounds.size.height-2*margin) cornerRadius:11];
    berierPath.lineWidth = 1.0;
    berierPath.lineCapStyle = kCGLineCapRound; //线条拐角
    berierPath.lineJoinStyle = kCGLineJoinRound; //终点处理、
    //顶部尖角
    [berierPath moveToPoint:CGPointMake((self.bounds.size.width)*0.5-margin, margin)];
    [berierPath addLineToPoint:CGPointMake((self.bounds.size.width)*0.5, 0)];
    [berierPath addLineToPoint:CGPointMake((self.bounds.size.width)*0.5+margin, margin)];
    [berierPath fill];//贝塞尔线进行填充
    [berierPath stroke];//贝塞尔线进行画笔填充
    NSString *string = @"送金蛋";
//    NSDictionary *dict  =@{NSFontAttributeName:[UIFont systemFontOfSize:6],NSForegroundColorAttributeName:[UIColor whiteColor]};
//    [string drawInRect:CGRectMake((self.bounds.size.width-4*margin)/2,(self.bounds.size.height-margin*2)/2, self.bounds.size.width, self.bounds.size.height) withAttributes:dict];
    
    
    NSDictionary *dict  =@{NSFontAttributeName:[UIFont systemFontOfSize:(10.0)],NSForegroundColorAttributeName:[UIColor whiteColor]};
    [string drawInRect:CGRectMake((self.bounds.size.width-(30))*0.5,margin, self.bounds.size.width, self.bounds.size.height) withAttributes:dict];
    

}


@end
