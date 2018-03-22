//
//  TurnPlateView.m
//  TurnplateDemo
//
//  Created by 王刚 on 2017/12/11.
//  Copyright © 2017年 Thunder. All rights reserved.
//

#import "TurnPlateView.h"
#import "TurnPlateAlert.h"

@interface TurnPlateView()<CAAnimationDelegate>
{
    UIImageView                 * imgVFile;                         //转盘内核
    UIButton                    * btnPlay;                          //开始转盘按钮
    UILabel                     * labelTimes;                       //次数
    NSInteger                     numberTimes;                      //剩余次数
    NSMutableArray              * arrayPrize;                       //奖品列表数组
    NSString                    * strMsg;                           //提示消息内容
}

@end

@implementation TurnPlateView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        arrayPrize = [[NSMutableArray alloc] init];
        strMsg = [[NSString alloc] init];
        [self setupViews];
    }
    return self;
}

-(void)setupViews{
    UIImageView * imgVBg = [[UIImageView alloc] initWithFrame:APP_CGRectMake(8, 28, 361, 430)];
    imgVBg.image = [UIImage imageNamed:@"TurnPlateBg"];
    [self addSubview:imgVBg];
    
    imgVFile = [[UIImageView alloc] initWithFrame:APP_CGRectMake(28, 48, 320, 320)];
    imgVFile.image = [UIImage imageNamed:@"TurnPlateFill.png"];
    [self addSubview:imgVFile];
    
    UIImageView * shadowLine = [[UIImageView alloc] initWithFrame:APP_CGRectMake(0, 0, 320, 320)];
    shadowLine.image = [UIImage imageNamed:@"ShadowLine"];
    [imgVFile addSubview:shadowLine];
    
    [imgVFile bringSubviewToFront:shadowLine];
    
    UIImageView * imgVArrow = [[UIImageView alloc] initWithFrame:APP_CGRectMake(161, 0, 62, 72)];
    imgVArrow.image = [UIImage imageNamed:@"TurnPlateArrow"];
    [self addSubview:imgVArrow];
    
    btnPlay = [UIButton buttonWithType:UIButtonTypeCustom];
    btnPlay.frame = APP_CGRectMake(113, 144, 148, 148);
    btnPlay.center = imgVFile.center;
    [btnPlay setBackgroundImage:[UIImage imageNamed:@"TurnPlatePlay"] forState:UIControlStateNormal];
    [btnPlay addTarget:self action:@selector(btnPlay:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnPlay];
    
    labelTimes = [[UILabel alloc] initWithFrame:APP_CGRectMake(0, 85, 148, 17)];
    labelTimes.textColor = [UIColor whiteColor];
    labelTimes.textAlignment = NSTextAlignmentCenter;
    labelTimes.font = [APPFont getSysFont17];
    [btnPlay addSubview:labelTimes];
    
}

-(void)setMsg:(NSDictionary *)dict{
    numberTimes = [dict[@"lottery"] integerValue];
    [labelTimes setText:[NSString stringWithFormat:@"%@次",dict[@"lottery"]]];
}

-(void)setupPrize:(NSMutableArray *)arr{
    arrayPrize = arr;
    for (int i = 0; i<arrayPrize.count; i++) {
        TurnPlateListModel * model = arrayPrize[i];
        float centerX;
        float centerY;
        UIImageView * imgV = [[UIImageView alloc] initWithFrame:APP_CGRectMake(127, 13, 65, 80)];
        
        imgV.backgroundColor = [UIColor clearColor];
        [imgV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.prizeUrl]]];
        [imgVFile addSubview:imgV];
        
        switch (i) {
            case 0:
                centerX = APP_Origin_X(163);//位置----1
                centerY = APP_Origin_Y(53);
                imgV.layer.position = CGPointMake(centerX, centerY);//位置
                break;
            case 1:
                centerX = APP_Origin_X(250);//位置--2
                centerY = APP_Origin_Y(108);
                imgV.layer.position = CGPointMake(centerX, centerY);//位置
                break;
            case 2:
                centerX = APP_Origin_X(250);//位置--3
                centerY = APP_Origin_Y(215);
                imgV.layer.position = CGPointMake(centerX, centerY);//位置
                break;
            case 3:
                centerX = APP_Origin_X(163);//位置----4
                centerY = APP_Origin_Y(267);
                imgV.layer.position = CGPointMake(centerX, centerY);//位置
                break;
            case 4:
                centerX = APP_Origin_X(70);//位置-5
                centerY = APP_Origin_Y(210);
                imgV.layer.position = CGPointMake(centerX, centerY);//位置
                break;
            case 5:
                centerX = APP_Origin_X(70);//位置-6
                centerY = APP_Origin_Y(108);
                imgV.layer.position = CGPointMake(centerX, centerY);//位置
            default:
                centerX = APP_Origin_X(70);//位置-6
                centerY = APP_Origin_Y(108);
                imgV.layer.position = CGPointMake(centerX, centerY);//位置
                break;
        }
        imgV.center = CGPointMake(centerX, centerY);
        imgV.layer.anchorPoint = CGPointMake(0.5,0.5);//以右下角为原点转，（0,0）是左上角转，（0.5,0,5）心中间转，其它以此类推
        imgV.transform = CGAffineTransformMakeRotation(M_PI/180 * i * 60);
    }
}


-(void)btnPlay:(UIButton *)btn{
    DbugLog(@"转盘开始");
    static NSInteger turnAngle;//6个奖励分别对应的角度
    NSInteger turnsNum = arc4random()%5+1;//控制圈数
    CGFloat perAngle = M_PI/180.0;
    
    
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary * dictLocal = [userDefaults objectForKey:keyForLocalUserMsg];
    NSString * uid = dictLocal[@"uid"];
    NSDictionary * dictParams = @{@"userid":uid};
    
    [WGHttpRequest get:TurnPlateResult andParam:dictParams andBaseUrl:GrabBaseUrl finish:^(NSData *data, NSDictionary *obj, NSError *error) {
        if (obj) {
            DbugLog(@"%@",obj);
            NSString * strCode = [NSString stringWithFormat:@"%@",obj[@"errcode"]];
            if ([strCode isEqualToString:@"200"]) {
                
                NSDictionary * dictResult = obj[@"data"];
                NSString * strResultCode = [NSString stringWithFormat:@"%@",dictResult[@"code"]];
                if ([strResultCode isEqualToString:@"0"]) {
                    NSString * resultID = [NSString stringWithFormat:@"%@",dictResult[@"lotteryid"]];
                    for (NSInteger i = 0; i< arrayPrize.count; i++) {
                        TurnPlateListModel * model = arrayPrize[i];
                        if ([model.prizeID isEqualToString:resultID]) {
                            turnAngle = arrayPrize.count - i;
                            strMsg = [NSString stringWithFormat:@"%@",model.prizeName];
                        }
                    }
                    
                    CABasicAnimation* rotationAnimation;
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
                    if (numberTimes == 0) {
                        [btnPlay setBackgroundImage:[UIImage imageNamed:@"TurnPlatePlay_selected"] forState:UIControlStateNormal];
                    }
                }
            }else{
                [[[WGAlertView alloc] initWithTitle:@"" message:obj[@"errmsg"] delegate:self withButtonTitleArray:nil] show];
            }
        }
    }];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    numberTimes--;
    [labelTimes setText:[NSString stringWithFormat:@"%ld次",numberTimes]];
    //显示结果提示框
    [[[TurnPlateAlert alloc] initWithTitle:@"" andMessage:[NSString stringWithFormat:@"恭喜获得%@奖品",strMsg]] show];
}


@end
