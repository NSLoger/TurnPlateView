//
//  ViewController.m
//  TurnPlateDemo
//
//  Created by 王刚 on 2018/1/29.
//  Copyright © 2018年 Admin. All rights reserved.
//

#import "ViewController.h"
#import "TurnPlateView.h"

@interface ViewController ()
@property (nonatomic, strong)TurnPlateView * turnPlateView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //转盘对象
    //依旧是测试，然而我把上面的删了
    //现在轮到我删除了
    self.turnPlateView = [[TurnPlateView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    [self.turnPlateView setupPrize];
    [self.view addSubview:self.turnPlateView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
