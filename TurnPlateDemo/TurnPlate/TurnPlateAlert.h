//
//  TurnPlateAlert.h
//  TurnplateDemo
//
//  Created by 王刚 on 2017/12/13.
//  Copyright © 2017年 Thunder. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TurnPlateAlert : UIView

-(instancetype)initWithTitle:(NSString *)title andMessage:(NSString *)msg;

-(void)show;

@end
