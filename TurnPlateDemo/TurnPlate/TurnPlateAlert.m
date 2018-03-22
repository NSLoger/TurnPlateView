//
//  TurnPlateAlert.m
//  TurnplateDemo
//
//  Created by 王刚 on 2017/12/13.
//  Copyright © 2017年 Thunder. All rights reserved.
//

#import "TurnPlateAlert.h"
#import "BaseAllDefine.h"

@interface TurnPlateAlert()
{
    UILabel * labelSign;
}

@end

@implementation TurnPlateAlert

-(instancetype)initWithTitle:(NSString *)title andMessage:(NSString *)msg{
    self = [super init];
    if (self) {
        self.frame = APP_CGRectMake(0, 0, 375, 667);
        self.backgroundColor = [UIColor clearColor];
        [self setupTitle:title andMsg:msg];
    }
    return self;
}

-(void)setupTitle:(NSString *)title andMsg:(NSString *)msg{
    UIImageView * imgVLogo = [[UIImageView alloc] init];
    [imgVLogo setFrame:APP_CGRectMake(62, 170, 250, 290)];
    [imgVLogo setImage:[UIImage imageNamed:@"TipMessage"]];
    imgVLogo.userInteractionEnabled = YES;
    [self addSubview:imgVLogo];
    
    labelSign = [[UILabel alloc] initWithFrame:APP_CGRectMake(0, 180, 250, 18)];
    labelSign.text = msg;
    labelSign.textColor = [UIColor blackColor];
    labelSign.textAlignment = NSTextAlignmentCenter;
    labelSign.font = [APPFont getSysFont18];
    labelSign.backgroundColor = [UIColor clearColor];
    [imgVLogo addSubview:labelSign];
    
    UIImageView * imgVCoinBox = [[UIImageView alloc] initWithFrame:APP_CGRectMake(180, 201, 109, 99)];
    imgVCoinBox.image = [UIImage imageNamed:@"CoinsBoxLogo"];
    [imgVLogo addSubview:imgVCoinBox];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissss)];
    [self addGestureRecognizer:tap];
}

-(void)show{
    UIWindow * keyWindow = [[[UIApplication sharedApplication] delegate] window];
    if (![keyWindow.subviews containsObject:self]) {
        CGRect frameKeyWindow = keyWindow.frame;
        
        UIView * view_overlay = [[UIView alloc] initWithFrame:keyWindow.bounds];
        view_overlay.backgroundColor = [UIColor clearColor];
        view_overlay.userInteractionEnabled = YES;
        
        UIView * bgView_alert = [[UIView alloc] initWithFrame:frameKeyWindow];
        bgView_alert.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
        [view_overlay addSubview:bgView_alert];
        
        [keyWindow addSubview:view_overlay];
        
        [view_overlay addSubview:self];
        
        [self setNeedsLayout];
        
        [UIView animateWithDuration:0.3 animations:^{
            self.alpha = 1.0;
            bgView_alert.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        }];
    }
}

//alertView消失
-(void)dismissss{
    //self先滑到底部消失
    UIWindow * keyWindow = [[UIApplication sharedApplication] keyWindow];
    //底部视图
    UIView * view_overlay = [keyWindow.subviews lastObject];
    [UIView animateWithDuration:0.1 animations:^{
        view_overlay.alpha = 0.0;
    } completion:^(BOOL finished) {
        [view_overlay removeFromSuperview];
    }];
}

@end
