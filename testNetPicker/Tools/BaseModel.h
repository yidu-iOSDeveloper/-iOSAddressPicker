//
//  BaseModel.h
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

// 初始化
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

// 便利构造器
+ (instancetype)baseModelWithDictionary:(NSDictionary *)dictionary;

// 转化方法  数组套字典 -> 数组套model
+ (NSMutableArray *)arrayWithModelByArray:(NSArray *)array;

@end
