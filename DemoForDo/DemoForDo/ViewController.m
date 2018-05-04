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
@interface ViewController ()
/**label*/
@property(nonatomic,strong)HETMyInteralHeadLabelView *label;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    
    HETDemoView *demoView = [[HETDemoView alloc]initWithFrame:CGRectMake(100, 300, 100, 44)];
    [self.view addSubview:demoView];
    demoView.backgroundColor = [UIColor clearColor];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
