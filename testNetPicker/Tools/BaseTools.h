//
//  BaseTools.h
//  XiaoMei
//
//  Created by PingTou on 15/11/16.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol BaseToolsDelegate <NSObject>


@end

@interface BaseTools : NSObject

@property(assign,nonatomic)id<BaseToolsDelegate> delegate;


+(NSString *)getTime;

+(NSString *)getYear;

+(NSString *)getMonth;

+ (BOOL)isPureNumandCharacters:(NSString *)string;

//提示显示
+(void)showHud:(UIView *)view image:(UIImage *)image text:(NSString *)text;

// 银行卡号 显示模式
+(NSString *)cardNumStyleString:(NSString *)string;
+(NSString *)cardNumHideHeadStyleString:(NSString *)string;

//手机号中间隐藏
+(NSString *)phoneNumHiddenStyle:(NSString *)string;

+ (void)MBProgressTextShowWithView:(UIView *)view returnText:(NSString *)text afterDelay:(NSInteger)afterDelay;

+(NSInteger )getMaxInArray:(NSArray *)array;

+(float)frontSum:(NSArray*)array index:(NSInteger)index;

//获取设备型号
+ (NSString *)deviccePlatform;

//获取坐标 距离
+(double) LantitudeLongitudeDistLo1:(double)lon1 La1:(double)lat1 Lo2:(double)lon2 La2:(double)lat2;

@end
