//
//  AFNetworkHandler.h


#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface AFNetworkHandler : NSObject

+ (void)GETWithAFNByURL:(NSString *)urlStr completion:(void(^)(id result))block;

+ (void)GETWithAFNByChinsesURL:(NSString *)urlStr completion:(void(^)(id result))block;
//post
+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;

+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(NSDictionary* responseObj))success failure:(void (^)(NSError *error))failure;

+ (void)GETWithAFNByURL:(NSString *)urlStr completion:(void (^)(id result))block parentView:(UIView *)parentView buttonAction:(SEL)action;



//no
+ (void)GETWithAFNByURL:(NSString *)urlStr completion:(void (^)(id result))success parentView:(UIView *)parentView completion:(void (^)(UIButton *buttonConfirm, UIView *noNetView))failure;
@end
