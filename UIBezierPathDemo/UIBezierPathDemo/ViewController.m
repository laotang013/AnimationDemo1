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
    
    
    CARoutationView *rotationView = [[CARoutationView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
//    rotationView.frame = CGRectMake(0, 0, 80, 80);
    rotationView.center = self.view.center;
    [self.view addSubview:rotationView];
    
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
