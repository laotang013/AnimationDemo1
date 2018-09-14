//
//  ViewController.m
//  DemoForDo
//
//  Created by Start on 2018/5/2.
//  Copyright © 2018年 Start. All rights reserved.
//

#import "ViewController.h"
#import "HETMyInteralHeadLabelView.h"
#import "HETMyInteralHeadSendView.h"
#import "HETDemoView.h"
#import "HETMyInteralHeadSendView.h"
#import "HETMyInterSignPopView.h"
#import "HETIntegralImageView.h"

#import "UIImage+HETMethodImage.h"
@interface ViewController ()
/**label*/
@property(nonatomic,strong)HETMyInteralHeadLabelView *label;
@property (nonatomic, strong) UIImageView *shadowImage;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 50)];
    [self.view addSubview:btn];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(btnShow) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
    // Do any additional setup after loading the view, typically from a nib.
    self.label = [[HETMyInteralHeadLabelView alloc]initWithtCornerRadius:16 borderWidth:1 borderColor:[UIColor blackColor] fontSize:8.0];
    self.label.frame = CGRectMake(50, 50, 32, 32);
    self.label.text = @"ddd";
    [self.view addSubview:_label];

    HETMyInteralHeadSendView *sendView = [[HETMyInteralHeadSendView alloc]initWithFrame:CGRectMake(100, 200, 60, 40)];
    [self.view addSubview:sendView];
    sendView.backgroundColor = [UIColor clearColor];
    sendView.sendViewColor = [UIColor orangeColor];
    sendView.sendViewStr = @"送金蛋";

    HETDemoView *demoView = [[HETDemoView alloc]initWithFrame:CGRectMake(100, 300, 44, 22)];
    [self.view addSubview:demoView];
    demoView.backgroundColor = [UIColor clearColor];
    HETIntegralImageView *interalImageView = [[HETIntegralImageView alloc]initWithFrame:CGRectMake(100, 300, 24, 24)];
    interalImageView.image = [UIImage imageNamed:@"integralShare"];
    interalImageView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:interalImageView];
    interalImageView.roundLayer.hidden = NO;
    
    
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(100, 400, 50, 50)];
    [self.view addSubview:imageV];
    imageV.image = [UIImage imageNamed:@"sleepPlanAlertFlower"];
    
}

-(void)btnShow
{
    HETMyInterSignPopView *popView = [[HETMyInterSignPopView alloc]init];
    [popView show];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSArray *subViews = allSubviews(self.navigationController.navigationBar);
    for (UIView *view in subViews) {
        if ([view isKindOfClass:[UIImageView class]] && view.bounds.size.height<1){
            //实践后发现系统的横线高度为0.333
            self.shadowImage =  (UIImageView *)view;
        }
    }
    self.shadowImage.hidden = YES;

}
NSArray *allSubviews(UIView *aView) {
    NSArray *results = [aView subviews];
    for (UIView *eachView in aView.subviews)
    {
        NSArray *subviews = allSubviews(eachView);
        if (subviews)
            results = [results arrayByAddingObjectsFromArray:subviews];
    }
    return results;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.shadowImage.hidden = NO;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
