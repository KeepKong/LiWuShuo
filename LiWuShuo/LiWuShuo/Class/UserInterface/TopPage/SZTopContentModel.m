//
//  SZTopContentModel.m
//  LiWuShuo
//
//  Created by lx on 16/10/6.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import "SZTopContentModel.h"

@implementation SZTopItemModel


- (instancetype)initWithCoder:(NSCoder *)aDecoder
{

    if (self = [super init])
    {
        
        
        self.url = [aDecoder decodeObjectForKey:@"url"];
        self.purchase_url = [aDecoder decodeObjectForKey:@"purchase_url"];
        self.purchase_type = [aDecoder decodeObjectForKey:@"purchase_type"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.favorites_count = [aDecoder decodeObjectForKey:@"favorites_count"];
        self.short_description = [aDecoder decodeObjectForKey:@"short_description"];
        self.price = [aDecoder decodeObjectForKey: @"price"];
        self.cover_image_url = [aDecoder decodeObjectForKey:@"cover_image_url"];
        
        
    }
    
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:self.url forKey:@"url"];
    [aCoder encodeObject:self.purchase_url forKey:@"purchase_url"];
    [aCoder encodeObject:self.purchase_type forKey:@"purchase_type"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.favorites_count forKey:@"favorites_count"];
    [aCoder encodeObject:self.short_description forKey:@"short_description"];
    [aCoder encodeObject:self.price forKey:@"price"];
    [aCoder encodeObject:self.cover_image_url forKey:@"cover_image_url"];
    
}



@end



@implementation SZTopContentModel

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{

    self = [super init];
    if (self)
    {
        
        self.paging = [aDecoder decodeObjectForKey:@"paging"];
        self.share_url = [aDecoder decodeObjectForKey:@"share_url"];
        self.cover_image = [aDecoder decodeObjectForKey:@"cover_image"];
        
        //对数组进行归档，里面又是单独的一个模型
        self.items = [aDecoder decodeObjectForKey:@"items"];
        
        
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:self.paging forKey:@"paging"];
    [aCoder encodeObject:self.share_url forKey:@"share_url"];
    [aCoder encodeObject:self.cover_image forKey:@"cover_image"];
    
    [aCoder encodeObject:self.items forKey:@"items"];
    
    
}





+ (instancetype)modelWithDictionary:(NSDictionary *)dict
{

    SZTopContentModel *model = [[self alloc] init];
    
    model = [SZTopContentModel yy_modelWithDictionary:dict];
    
    return model;
    
}



+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{


    return @{
             
             @"items" : [SZTopItemModel class]
             
             };
}


@end
