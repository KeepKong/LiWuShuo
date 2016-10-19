//
//  SZColumnModel.h
//  LiWuShuo
//
//  Created by lx on 16/10/4.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <NSObject+YYModel.h>



@interface SZChannel : NSObject<YYModel>

@property (nonatomic , assign) BOOL editable;

@property (nonatomic , copy) NSString *name;

@property (nonatomic , assign) NSNumber *column_id;



@end



@interface SZColumnModel : NSObject<YYModel>


@property (nonatomic , strong) NSArray *channels;



+ (instancetype)modelWithDictionary:(NSDictionary *)dict;

@end
