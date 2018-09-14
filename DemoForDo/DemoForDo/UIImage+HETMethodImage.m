
//
//  UIImage+HETMethodImage.m
//  DemoForDo
//
//  Created by Start on 2018/5/10.
//  Copyright © 2018年 Start. All rights reserved.
//

#import "UIImage+HETMethodImage.h"
#import <objc/runtime.h>
@implementation UIImage (HETMethodImage)
+(void)load
{
    //方法交换
    Method m1 = class_getClassMethod([self class], @selector(imageNamed:));
    Method m2 = class_getClassMethod([self class], @selector(mineImageView:));
    method_exchangeImplementations(m1, m2);

}
+(instancetype)mineImageView:(NSString *)image
{
    NSLog(@"添加方法");
    UIImage *image1 = [self mineImageView:image];
    return image1;
}
@end
