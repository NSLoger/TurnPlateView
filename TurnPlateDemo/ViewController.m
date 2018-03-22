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
    //这里只是我做的测试
    self.turnPlateView = [[TurnPlateView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    [self.turnPlateView setupPrize];
    [self.view addSubview:self.turnPlateView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
