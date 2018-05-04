


//
//  HETMyInteralHeadLabelView.m
//  CSleepDolphin
//
//  Created by Start on 2018/5/2.
//  Copyright © 2018年 HET. All rights reserved.
//

#import "HETMyInteralHeadLabelView.h"
@interface HETMyInteralHeadLabelView()

@end
@implementation HETMyInteralHeadLabelView

-(instancetype)initWithtCornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor fontSize:(CGFloat)fontSize
{
    if (self = [super init]) {
        self.font = [UIFont fontWithName:@"Helvetica-Bold" size:(8.0)];
        self.textAlignment = NSTextAlignmentCenter;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = cornerRadius;
        self.layer.borderColor = borderColor.CGColor;
        self.layer.borderWidth = borderWidth;
    }
    return self;
}

@end
