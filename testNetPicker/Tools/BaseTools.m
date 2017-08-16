//
//  BaseTools.m
//  XiaoMei
//
//  Created by PingTou on 15/11/16.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "BaseTools.h"
#import "sys/utsname.h"


@interface BaseTools()<UIAlertViewDelegate>

@end
@implementation BaseTools

//获取时间
+(NSString *)getTime{
    NSDate *dadate = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:dadate]-8*3600;
    NSDate *ldate = [dadate dateByAddingTimeInterval:interval];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *destDateString = [dateFormatter stringFromDate:ldate];
    return destDateString;
}

+(NSString *)getYear{
    NSDate *dadate = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:dadate]-8*3600;
    NSDate *ldate = [dadate dateByAddingTimeInterval:interval];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *destDateString = [dateFormatter stringFromDate:ldate];
   NSString * strYear = [destDateString substringWithRange:NSMakeRange(0, 4)];
    
    return strYear;
}

+(NSString *)getMonth{
    NSDate *dadate = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:dadate]-8*3600;
    NSDate *ldate = [dadate dateByAddingTimeInterval:interval];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *destDateString = [dateFormatter stringFromDate:ldate];
    NSString *month = [destDateString substringWithRange:NSMakeRange(4, 2)];
    return month;
}

//判断是否是纯数字
+ (BOOL)isPureNumandCharacters:(NSString *)string
{
    unichar c;
    for (int i=0; i<string.length; i++) {
        c=[string characterAtIndex:i];
        if (!isdigit(c)) {
            return NO;
        }
    }
    return YES;
}


// 银行卡号 显示模式
+(NSString *)cardNumStyleString:(NSString *)string{
    NSString *nospace = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSMutableString *codestr = [NSMutableString stringWithString:@""];
    NSInteger len =nospace.length;
    NSInteger part =len/4;
    NSInteger leg = len%4;
    for (int i=0; i<part; i++) {
        if (i==0){
            [codestr appendString:[nospace substringWithRange:NSMakeRange(0, 4)]];
        }else{
            [codestr appendString:[NSString stringWithFormat:@" %@",[nospace substringWithRange:NSMakeRange(i*4, 4)]]];
        }
    }
    [codestr appendString:[NSString stringWithFormat:@" %@",[nospace substringWithRange:NSMakeRange(4*part, leg)]]];
    return [codestr mutableCopy];
}

// 银行卡号 显示模式(前面隐藏)
+(NSString *)cardNumHideHeadStyleString:(NSString *)string{
    
    if (string.length < 4) {
        return @"";
    }
    
    NSString *nospace = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *code = [nospace substringFromIndex:nospace.length - 4];
    
    NSString *str = [NSString stringWithFormat:@"*** **** **** %@", code];
    
    return str;
}

//手机号中间隐藏
+(NSString *)phoneNumHiddenStyle:(NSString *)string{
    if (string.length==11) {
        NSMutableString *codestr = [NSMutableString stringWithString:@""];
        [codestr appendString:[string substringWithRange:NSMakeRange(0, 3)]];
        [codestr appendString:@"****"];
        [codestr appendString:[NSString stringWithFormat:@" %@",[string substringWithRange:NSMakeRange(7, 4)]]];
        return [codestr mutableCopy];
    }
    return @"";
}

+ (void)MBProgressTextShowWithView:(UIView *)view returnText:(NSString *)text afterDelay:(NSInteger)afterDelay
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = text;
    hud.margin = 10.f;
    hud.yOffset = 150.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:afterDelay];
}

+(NSInteger )getMaxInArray:(NSArray *)array{
    
    float  maxd = 0;
    
    if (array.count>=1) {
        maxd = [array[0] floatValue];
        NSInteger max = 0;
        for (NSInteger i = 0; i<array.count; i++) {
            if ([array [i] floatValue]>=maxd) {
                maxd =[array [i] floatValue];
                max = i;
            }
        }
        return max;
    }
    return 0;
}

+(float)frontSum:(NSArray*)array index:(NSInteger)index{
    float sum = 0;
    if (index<array.count) {
        
        for (int i = 0; i<index; i++) {
            sum  += [array[i] floatValue];
        }
        return sum;
    }
    return 0;
}

//获取设备型号
+ (NSString *)deviccePlatform{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone2G(A1203)";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone3G(A1241/A1324)";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone3GS(A1303/A1325)";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone4(A1332)";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone4(A1332)";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone4(A1349)";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone4S(A1387/A1431)";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone5(A1428)";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone5(A1429/A1442)";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone5c(A1456/A1532)";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone5c(A1507/A1516/A1526/A1529)";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone5s(A1453/A1533)";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone5s(A1457/A1518/A1528/A1530)";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone6Plus (A1522/A1524)";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone6(A1549/A1586)";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone6s(A1633/A1634)";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone6sPlus(A1699/A1700)";
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPodTouch1G(A1213)";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPodTouch2G(A1288)";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPodTouch3G(A1318)";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPodTouch4G(A1367)";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPodTouch5G(A1421/A1509)";
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad1G(A1219/A1337)";
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad2(A1395)";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad2(A1396)";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad2(A1397)";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad2(A1395+New Chip)";
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPadMini1G(A1432)";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPadMini1G(A1454)";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPadMini1G(A1455)";
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad3(A1416)";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad3(A1403)";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad3(A1430)";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad4(A1458)";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad4(A1459)";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad4(A1460)";
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPadAir(A1474)";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPadAir(A1475)";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPadAir(A1476)";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPadMini2G(A1489)";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPadMini2G(A1490)";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPadMini2G(A1491)";
    if ([platform isEqualToString:@"i386"])      return @"iPhoneSimulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhoneSimulator";
    return platform;
}


//+(double) LantitudeLongitudeDist(double lon1,double lat1,
//                              double lon2,double lat2)

+(double) LantitudeLongitudeDistLo1:(double)lon1 La1:(double)lat1 Lo2:(double)lon2 La2:(double)lat2
{
    double PI = 3.1415926;
    double er = 6378137; // 6378700.0f;
    //ave. radius = 6371.315 (someone said more accurate is 6366.707)
    //equatorial radius = 6378.388
    //nautical mile = 1.15078
    double radlat1 = PI*lat1/180.0f;
    double radlat2 = PI*lat2/180.0f;
    //now long.
    double radlong1 = PI*lon1/180.0f;
    double radlong2 = PI*lon2/180.0f;
    if( radlat1 < 0 ) radlat1 = PI/2 + fabs(radlat1);// south
    if( radlat1 > 0 ) radlat1 = PI/2 - fabs(radlat1);// north
    if( radlong1 < 0 ) radlong1 = PI*2 - fabs(radlong1);//west
    if( radlat2 < 0 ) radlat2 = PI/2 + fabs(radlat2);// south
    if( radlat2 > 0 ) radlat2 = PI/2 - fabs(radlat2);// north
    if( radlong2 < 0 ) radlong2 = PI*2 - fabs(radlong2);// west
    //spherical coordinates x=r*cos(ag)sin(at), y=r*sin(ag)*sin(at), z=r*cos(at)
    //zero ag is up so reverse lat
    double x1 = er * cos(radlong1) * sin(radlat1);
    double y1 = er * sin(radlong1) * sin(radlat1);
    double z1 = er * cos(radlat1);
    double x2 = er * cos(radlong2) * sin(radlat2);
    double y2 = er * sin(radlong2) * sin(radlat2);
    double z2 = er * cos(radlat2);
    double d = sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2)+(z1-z2)*(z1-z2));
    //side, side, side, law of cosines and arccos
    double theta = acos((er*er+er*er-d*d)/(2*er*er));
    double dist  = theta*er;
    return dist/1000.0;
}


@end
