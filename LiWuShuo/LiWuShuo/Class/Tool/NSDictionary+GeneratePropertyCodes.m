//
//  NSDictionary+GeneratePropertyCodes.m
//  扩展字典快速生成Model的属性
//
//  Created by lx on 16/9/25.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import "NSDictionary+GeneratePropertyCodes.h"

@implementation NSDictionary (GeneratePropertyCodes)

- (void)generatePropertyCodes
{
    
    NSMutableString *codes = [NSMutableString string];

    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull value, BOOL * _Nonnull stop) {
       
//        NSLog(@"key = %@" , key);
        
        NSString *code;

        if ([value isKindOfClass:[NSString class]])
        {
            code = [NSString stringWithFormat:@"@property (nonatomic , copy) NSString *%@;" , key];
        }
        else if ([value isKindOfClass:[NSArray class]])
        {
        
            code = [NSString stringWithFormat:@"@property (nonatomic , strong) NSArray *%@;" , key];
        }
        else if ([value isKindOfClass:[NSDictionary class]])
        {
        
            code = [NSString stringWithFormat:@"@property (nonatomic , strong) NSDictionary *%@;" , key];
        }
        
        //这里的Bool类型判断一定放在NSNumber类型判断之前，因为Bool类型也属于NSNumber类型的子类，如果将Bool类型判断放在后面，那么就不会返回Bool类型的属性代码了，只会返回NSNumber类型的代码。
        else if ([value isKindOfClass:NSClassFromString(@"__NSCFBoolean")])
        {

            code = [NSString stringWithFormat:@"@property (nonatomic , assign) BOOL %@;" , key];
        }
        else if ([value isKindOfClass:[NSNumber class]])
        {
        
            code = [NSString stringWithFormat:@"@property (nonatomic , strong) NSNumber *%@;" , key];
        }
        else
        {
        
            code = [NSString stringWithFormat:@"%@:(NULL)" , key];
        }
        
        [codes appendFormat:@"\n%@\n" , code];
        
    }];
    
    NSLog(@"codes = %@" , codes);
}

@end
