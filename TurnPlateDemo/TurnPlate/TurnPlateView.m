//
//  TurnPlateView.m
//  TurnplateDemo
//
//  Created by 王刚 on 2017/12/11.
//  Copyright © 2017年 Thunder. All rights reserved.
//

#import "TurnPlateView.h"

#define widthOfScreen self.window.bounds.size.width
#define heightOfScreen self.window.bounds.size.height

@interface TurnPlateView()<CAAnimationDelegate>
{
    UIImageView                 * imgVFile;                         //转盘内核
    UIButton                    * btnPlay;                          //开始转盘按钮
    NSInteger turnAngle;                                            //6个奖励分别对应的角度
    NSArray * colors;                                               //颜色数组
}

@end

@implementation TurnPlateView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        turnAngle = 0;
        colors = @[[UIColor whiteColor],[UIColor redColor],[UIColor orangeColor],[UIColor yellowColor],[UIColor greenColor],[UIColor blueColor]];
        [self setupViews];
    }
    return self;
}

-(void)setupViews{
    
    
    imgVFile = [[UIImageView alloc] initWithFrame:CGRectMake((widthOfScreen-320)/2, 48, 320, 320)];
    imgVFile.layer.cornerRadius = 160;
    imgVFile.layer.masksToBounds = YES;
    imgVFile.center = self.center;
    imgVFile.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:imgVFile];
    
    UIButton * btnArrow = [UIButton buttonWithType:UIButtonTypeCustom];
    btnArrow.frame = CGRectMake(imgVFile.frame.origin.x+160-15, imgVFile.frame.origin.y-25, 30, 30);
    btnArrow.layer.masksToBounds = YES;
    btnArrow.layer.cornerRadius = 15.0;
    btnArrow.backgroundColor = [UIColor redColor];
    [self addSubview:btnArrow];
    
    btnPlay = [UIButton buttonWithType:UIButtonTypeCustom];
    btnPlay.frame = CGRectMake(0, 0, 60, 60);
    btnPlay.center = imgVFile.center;
    btnPlay.layer.cornerRadius = 30;
    btnPlay.layer.masksToBounds = YES;
    btnPlay.center = imgVFile.center;
    btnPlay.backgroundColor = [UIColor redColor];
    [btnPlay addTarget:self action:@selector(btnPlay:) forControlEvents:UIControlEventTouchUpInside];
    [btnPlay setTitle:@"开始" forState:UIControlStateNormal];
    btnPlay.tintColor = [UIColor whiteColor];
    [self addSubview:btnPlay];
}

-(void)setupPrize{
    for (int i = 0; i<6; i++) {
        float centerX;
        float centerY;
        UIImageView * imgV = [[UIImageView alloc] initWithFrame:CGRectMake(30, 10, 60, 72)];
        imgV.layer.masksToBounds = YES;
        imgV.layer.cornerRadius = 60.0/2;
        imgV.backgroundColor = colors[i];
        [imgVFile addSubview:imgV];
        
        switch (i) {
            case 0:
                centerX = 35*2+60+60/2;//位置----1
                centerY = 10+72/2;
                break;
            case 1:
                centerX = 35*3+60*2+60/2;//位置--2
                centerY = 10+65+72/2;
                break;
            case 2:
                centerX = 35*3+60*2+60/2;//位置--3
                centerY = 10*3+75*2+72/2;
                break;
            case 3:
                centerX = 30*2+66+33;//位置----4
                centerY = 320-10-72/2;
                break;
            case 4:
                centerX = 35+33;//位置-5
                centerY = 10*3+75*2+72/2;
                break;
            case 5:
                centerX = 35+33;//位置-6
                centerY = 10+65+72/2;
            default:
                centerX = 35+33;//位置-6
                centerY = 10+65+72/2;
                break;
        }
        imgV.center = CGPointMake(centerX, centerY);
        imgV.layer.anchorPoint = CGPointMake(0.5,0.5);//以右下角为原点转，（0,0）是左上角转，（0.5,0,5）心中间转，其它以此类推
        imgV.transform = CGAffineTransformMakeRotation(M_PI/180 * i * (360/colors.count));
    }
}


-(void)btnPlay:(UIButton *)btn{
    NSLog(@"转盘开始");
    NSInteger turnsNum = arc4random()%5+2;//控制圈数
    CGFloat perAngle = M_PI/180.0;

    CABasicAnimation * rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:turnAngle * 60 * perAngle + 360 * perAngle * turnsNum];
    rotationAnimation.duration = 3.0f;
    rotationAnimation.cumulative = YES;
    rotationAnimation.delegate = self;
    //由快变慢
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    rotationAnimation.fillMode = kCAFillModeForwards;
    rotationAnimation.removedOnCompletion = NO;
    [imgVFile.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
    turnAngle++;
    if (turnAngle == 6) {
        turnAngle = 0;
    }
}

#pragma mark --CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    //显示结果提示框
    NSString * msg = [[NSString alloc] init];
    switch (turnAngle) {
        case 1:
            msg = @"白色";
            break;
        case 2:
            msg = @"蓝色";
            break;
        case 3:
            msg = @"绿色";
            break;
        case 4:
            msg = @"黄色";
            break;
        case 5:
            msg = @"橙色";
            break;
        case 0:
            msg = @"红色";
            break;
            
        default:
            break;
    }
    NSLog(@"选中了----->%@",msg);
}
//至此结束


@end
