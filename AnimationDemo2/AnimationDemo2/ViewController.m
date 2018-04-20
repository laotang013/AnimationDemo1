//
//  ViewController.m
//  AnimationDemo2
//
//  Created by Start on 2018/4/20.
//  Copyright © 2018年 Start. All rights reserved.
//

#import "ViewController.h"
#import "GoodSliderMenu.h"
@interface ViewController ()
/**uibutton*/
@property(nonatomic,strong)UIButton *button;
@end

@implementation ViewController
{
    GoodSliderMenu *_menu;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.button];
    self.button.frame = CGRectMake(300, 600, 100, 40);
    
    _menu = [[GoodSliderMenu alloc]init];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)buttonClick:(UIButton *)button
{
    [_menu show];
}
-(UIButton *)button
{
    if (!_button) {
        _button = [[UIButton alloc]init];
        [_button setTitle:@"点击" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}
@end
