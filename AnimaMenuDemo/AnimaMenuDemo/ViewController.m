//
//  ViewController.m
//  AnimaMenuDemo
//
//  Created by Start on 2018/4/24.
//  Copyright © 2018年 Start. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
/**UIImageView*/
@property(nonatomic,strong)UIImageView *lockScreenView;
/**物理仿真器*/
@property(nonatomic,strong)UIDynamicAnimator *animator;


/**重力行为*/
@property(nonatomic,strong)UIGravityBehavior *gravityBehaviour;
/**推行为*/
@property(nonatomic,strong)UIPushBehavior *pushBehavior;
/**附着行为*/
@property(nonatomic,strong)UIAttachmentBehavior *attachmentBehaviour;
/**动态元素行为*/
@property(nonatomic,strong)UIDynamicItemBehavior *itemBehaviour;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 80)];
    button.center = self.view.center;
    [button setTitle:@"恢复" forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button setBackgroundColor:[UIColor blueColor]];
    [button addTarget:self action:@selector(restore:) forControlEvents:UIControlEventTouchUpInside];
    
    self.lockScreenView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    self.lockScreenView.image = [UIImage imageNamed:@"lockScreen"];
    self.lockScreenView.userInteractionEnabled = YES;
    [self.view addSubview:self.lockScreenView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOnIt:)];
    [self.lockScreenView addGestureRecognizer:tap];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panOnIt:)];
    [self.lockScreenView addGestureRecognizer:pan];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //1.定义一个物理容器
    self.animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    UICollisionBehavior *collisionBehviour = [[UICollisionBehavior alloc]initWithItems:@[self.lockScreenView]];
    [collisionBehviour setTranslatesReferenceBoundsIntoBoundaryWithInsets:UIEdgeInsetsMake(-_lockScreenView.frame.size.height, 0, 0, 0)];
    [self.animator addBehavior:collisionBehviour];
    
    self.gravityBehaviour = [[UIGravityBehavior alloc]initWithItems:@[self.lockScreenView]];
    self.gravityBehaviour.gravityDirection = CGVectorMake(0.0, 1.0f);
    self.gravityBehaviour.magnitude = 2.6f;
    self.gravityBehaviour.angle = M_PI/3;
    [self.animator addBehavior:self.gravityBehaviour];
    
    self.itemBehaviour = [[UIDynamicItemBehavior alloc]initWithItems:@[self.lockScreenView]];
    self.itemBehaviour.elasticity =  0.35f;//1.0 完全弹性碰撞，需要非常久才能恢复；
    [self.animator addBehavior:_itemBehaviour];
    
    
    //推力
    /*
     UIPushBehaviorModeInstantaneous 瞬间的力
     UIPushBehaviorModeContinuous 持续的力
     magnitude 推力的大小
     angle 推力的角度
     */
    self.pushBehavior = [[UIPushBehavior alloc]initWithItems:@[self.lockScreenView] mode:UIPushBehaviorModeInstantaneous];
    self.pushBehavior.magnitude = 2.0f;
    self.pushBehavior.angle = M_PI;
    [self.animator addBehavior:self.pushBehavior];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tapOnIt:(UITapGestureRecognizer*)tapGes
{
    //pushDirection：推理的方向和重力的方向一样
    //active: 当前推力是否可用
    self.pushBehavior.pushDirection = CGVectorMake(0.0f, -80.0f);
    self.pushBehavior.active = YES;
}

-(void)panOnIt:(UIPanGestureRecognizer *)panGes
{
    CGPoint location = CGPointMake(CGRectGetMidX(_lockScreenView.frame), [panGes locationInView:self.view].y);
    if (panGes.state == UIGestureRecognizerStateBegan) {
        [self.animator removeBehavior:self.gravityBehaviour];//移除重力行为
        self.attachmentBehaviour = [[UIAttachmentBehavior alloc]initWithItem:self.lockScreenView attachedToAnchor:location];
        [self.animator addBehavior:_attachmentBehaviour];
    }else if (panGes.state == UIGestureRecognizerStateChanged)
    {
        self.attachmentBehaviour.anchorPoint = location;
        NSLog(@"location:%@",NSStringFromCGPoint(location));
        NSLog(@"length:%f",self.attachmentBehaviour.length);
    }else if (panGes.state == UIGestureRecognizerStateEnded)
    {
        CGPoint velocity = [panGes velocityInView:_lockScreenView];
        NSLog(@"v:%@",NSStringFromCGPoint(velocity));
        [self.animator removeBehavior:self.attachmentBehaviour];
        self.attachmentBehaviour = nil;
        if (velocity.y<-1300.f) {
            [self.animator removeBehavior:self.gravityBehaviour];
            [self.animator removeBehavior:_itemBehaviour];
            _gravityBehaviour = nil;
            _itemBehaviour = nil;
            
            self.gravityBehaviour = [[UIGravityBehavior alloc]initWithItems:@[self.lockScreenView]];
            self.gravityBehaviour.gravityDirection = CGVectorMake(0.0, -1.0);
            self.gravityBehaviour.magnitude = 2.6f;
            [self.animator addBehavior:self.gravityBehaviour];
//
//            //item
            self.itemBehaviour = [[UIDynamicItemBehavior alloc] initWithItems:@[self.lockScreenView]];
            self.itemBehaviour.elasticity = 0.0f;//1.0 完全弹性碰撞，需要非常久才能恢复；
            [self.animator addBehavior:_itemBehaviour];
            
            self.pushBehavior.pushDirection = CGVectorMake(0.0f, -200.0f);
            self.pushBehavior.active = YES;
        }else
        {
            [self restore:nil];
        }
        
    }
}
- (IBAction)restore:(id)sender {
    [_animator removeBehavior:_gravityBehaviour];
    [_animator removeBehavior:_itemBehaviour];
    _gravityBehaviour = nil;
    _itemBehaviour = nil;
    
    //gravity
    self.gravityBehaviour = [[UIGravityBehavior alloc] initWithItems:@[self.lockScreenView]];
    self.gravityBehaviour.gravityDirection = CGVectorMake(0.0, 1.0);
    self.gravityBehaviour.magnitude = 2.6f;
    
    //item
    self.itemBehaviour = [[UIDynamicItemBehavior alloc] initWithItems:@[self.lockScreenView]];
    self.itemBehaviour.elasticity = 0.35f;//1.0 完全弹性碰撞，需要非常久才能恢复；
    [self.animator addBehavior:_itemBehaviour];
    
    [self.animator addBehavior:self.gravityBehaviour];
    
}

/*
 UIAttachmentBehavior：附着行为
 UICollisionBehavior：碰撞行为
 UIGravityBehavior：重力行为
 UIDynamicItemBehavior：动态元素行为
 UIPushBehavior：推行为
 UISnapBehavior：吸附行为

 velocityInView:
 velocityInView 返回指定坐标系统当中拖动的速度，x,y分别代表x轴y轴的拖动速度(矢量)
 */

@end
