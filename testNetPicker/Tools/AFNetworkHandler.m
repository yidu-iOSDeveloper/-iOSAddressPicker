//
//  AFNetworkHandler.m

#import "AFNetworkHandler.h"
#import "Reachability.h"
#import "AFNetworking.h"


@implementation AFNetworkHandler

//参数1: 网络接口
//参数2: 回调block(返回数据的block)
+ (void)GETWithAFNByURL:(NSString *)urlStr completion:(void (^)(id))block
{
    //网址转码 处理中文字符
    NSString *str = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    // 创建AFN网络请求管理类
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //设置响应解析对象
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //设置数据支持类型
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/css", @"text/plain", nil]];
    //AFN的GET请求
    [manager GET:str parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //请求成功执行的地方
        //responseObject 返回数据为NSData
        if (responseObject) {
            //如果返回数据不为空 则开始JSON解析
            id result = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingMutableContainers) error:nil];
            // 通过block回调数据
            block(result);
        } else {
            NSLog(@"返回数据为空, 请检查");
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
#warning 请求失败
        //请求失败
//        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"加载失败" message:@"亲, 您的网络好像不太给力哦" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//        [al show];
    }];
    
}



+(void)GETWithAFNByChinsesURL:(NSString *)urlStr completion:(void (^)(id))block{
    //网址转码 处理中文字符
    NSString *str = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *uustr = [self cuturlstringWithString:str];
    // 创建AFN网络请求管理类
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //设置响应解析对象
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //设置数据支持类型
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/css", @"text/plain", nil]];
    //AFN的GET请求
    [manager GET:uustr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //请求成功执行的地方
        //responseObject 返回数据为NSData
        if (responseObject) {
            //如果返回数据不为空 则开始JSON解析
            id result = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingMutableContainers) error:nil];
            // 通过block回调数据
            block(result);
        } else {
            NSLog(@"返回数据为空, 请检查");
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
#warning 请求失败
        //请求失败
        //        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"加载失败" message:@"亲, 您的网络好像不太给力哦" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        //        [al show];
    }];
}

+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    AFNetworkHandler *tool = [[AFNetworkHandler alloc]init];
    if ([tool isConnectionAvailable]) {//检查是否有网络
        // 1.获得请求管理者
        AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
        // 2.发送GET请求
        [mgr GET:url parameters:params
         success:^(AFHTTPRequestOperation *operation, id responseObj) {
             if (success) {
                 success(responseObj);
             }
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             if (failure) {
                 failure(error);
             }
         }];
    }else{
        
    }
    
    
}

+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure
{
    
    AFNetworkHandler *tool = [[AFNetworkHandler alloc]init];
    if ([tool isConnectionAvailable]) {//检查是否有网络
        AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
        mgr.responseSerializer = [AFJSONResponseSerializer serializer];
        mgr.requestSerializer = [AFJSONRequestSerializer serializer];
        mgr.requestSerializer.timeoutInterval = 60;
        
        
        [mgr POST:url parameters:params
          success:^(AFHTTPRequestOperation *operation, NSDictionary * responseObj) {
              if (success) {
                  success(responseObj);
              }
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              if (failure) {
                  NSLog(@"error:%@",error.localizedDescription);
                  failure(error);
              }
          }];
    }else{
        
    }
    
    
}
-(BOOL)isConnectionAvailable{
    
    BOOL isExistenceNetwork = YES;
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork = NO;
            //NSLog(@"notReachable");
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            //NSLog(@"WIFI");
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            //NSLog(@"3G");
            break;
    }
    
    if (!isExistenceNetwork) {
        return NO;
    }
    return isExistenceNetwork;
}


+(NSString*)cuturlstringWithString:(NSString *)string{
    NSMutableString *mustr = [string mutableCopy];
    NSString *str =  [mustr substringWithRange:NSMakeRange(0, 3)];
   // NSLog(@"=====%@",str);
    //NSLog(@"=====%@",string);
    if ([str isEqualToString:@"%20"]) {
        [mustr replaceCharactersInRange:NSMakeRange(0, 3) withString:@""];
    }
   // NSLog(@"-----------%@",mustr);
    return [mustr mutableCopy];;
}

@end
