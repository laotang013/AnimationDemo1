//
//  DrawTrianglePath.h
//  UIBezierPathDemo
//
//  Created by Start on 2018/4/16.
//  Copyright © 2018年 Start. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawTrianglePath : UIView
-(void)drawTrianglePath;
/**UIber*/
@property(nonatomic,strong)UIBezierPath *bezierPath;
@property(nonatomic,assign)CGPoint point;
@end
