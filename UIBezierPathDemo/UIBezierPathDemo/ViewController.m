//
//  ViewController.m
//  UIBezierPathDemo
//
//  Created by Start on 2018/4/16.
//  Copyright © 2018年 Start. All rights reserved.
//

#import "ViewController.h"
#import "DrawTrianglePath.h"
#import "CAShapeLayerView.h"
#import "CARoutationView.h"
#import "TestAnimationView.h"
#import "CAShapeLayerViewDemo.h"
#import "CAShapeLayerAnimationView.h"
@interface ViewController ()
/**画布*/
@property(nonatomic,strong)DrawTrianglePath *trainPathView;
@end

@implementation ViewController
{
   NSInteger index ;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//     UIBezierPath *path = [UIBezierPath bezierPath];
//    self.trainPathView = [[DrawTrianglePath alloc]initWithFrame:CGRectMake(30, 60, 200, 200)];
//    self.trainPathView.bezierPath = path;
//    [self.view addSubview:self.trainPathView];
//    index = 18;
   //[self.trainPathView drawTrianglePath];
    
//    CAShapeLayerView *button = [[CAShapeLayerView alloc]init];
//    button.frame=CGRectMake(0, 0, 130, 50);
//    button.center=self.view.center;
//    [self.view addSubview:button];
//    
//
//    CARoutationView *rotationView = [[CARoutationView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
//    rotationView.center = self.view.center;
//    [self.view addSubview:rotationView];
    [self test1];
    
}

- (IBAction)add:(id)sender {
    index+=10;
    self.trainPathView.point = CGPointMake(index, 0);
    NSLog(@"%ld",(long)index);
    [self performSelector:@selector(newClick) withObject:nil afterDelay:3];
}
-(void)newClick
{
        [self.trainPathView setNeedsDisplay];
}

-(void)test
{
    TestAnimationView *view = [[TestAnimationView alloc]init];
    view.layer.position = CGPointMake(80, 80);
    NSLog(@"%@",NSStringFromCGPoint(view.center));
    view.backgroundColor = [UIColor blueColor];
    [self.view addSubview:view];
    [UIView animateWithDuration:5 animations:^{
        view.center = self.view.center;
        
    }completion:^(BOOL finished) {
        NSLog(@"aaa");
    }];
}
/*
 如果这个CALayer被一个UIView所持有，那么这个CALayer的delegate就是持有它的那个View
 既然UIView就是CALayer的delegate，那么actionForLayer:forKey:方法就是由UIView来实现的。所以UIView可以相当灵活的控制动画的产生。
 */


-(void)test1
{

    CAShapeLayerAnimationView *shapeDemo = [[CAShapeLayerAnimationView alloc]init];
    shapeDemo.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    shapeDemo.center = self.view.center;
    shapeDemo.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:shapeDemo];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
