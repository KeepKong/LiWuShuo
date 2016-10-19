//
//  NSDictionary+GeneratePropertyCodes.h
//  扩展字典快速生成Model的属性
//
//  Created by lx on 16/9/25.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface NSDictionary (GeneratePropertyCodes)


//当网络请求过来的数据太多的时候，我们只能不断的重复拷贝属性的名字，而且有时候还会担心自己拷贝出错，这种操作比较重复和低级，感觉有点浪费时间，所以我们扩展一个字典类，来帮我们生成这些属性的代码。

- (void)generatePropertyCodes;


@end
