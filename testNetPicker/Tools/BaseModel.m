//
//  BaseModel.m
//

#import "BaseModel.h"

@implementation BaseModel


#pragma mark - 初始化方法

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    
    if (self) {
        
        // KVC 赋值
        [self setValuesForKeysWithDictionary:dictionary];
    }
    
    return self;
}


#pragma mark - 遍历构造器
+ (instancetype)baseModelWithDictionary:(NSDictionary *)dictionary {
    
    id model = [[[self class] alloc] initWithDictionary:dictionary];
    
    return model;
}

#pragma mark - 数组套字典 -> 数组套model
+ (NSMutableArray *)arrayWithModelByArray:(NSArray *)array {
    // 创建一个可变数组 保存model 返回结果
    NSMutableArray *arr = [NSMutableArray array];
    
    
    // 遍历参数数组
    for (NSDictionary *dictionary in array) {
        
        // 自动释放池
        @autoreleasepool {
            // 创建对象
            id model = [[self class] baseModelWithDictionary:dictionary];
            
            // 添加至数组
            [arr addObject:model];
        }
        
    }
    
    return arr;
}



#pragma mark - KVC容错方法
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (id)valueForUndefinedKey:(NSString *)key {
    return nil;
}

@end
