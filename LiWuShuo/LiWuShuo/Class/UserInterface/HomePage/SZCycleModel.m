//
//  SZCycleModel.m
//  LiWuShuo
//
//  Created by lx on 16/10/5.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import "SZCycleModel.h"

@implementation SZBannerModel

//模型解档方法
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{

    self = [super init];
    if (self)
    {
        
        self.webp_url = [aDecoder decodeObjectForKey:@"webp_url"];
        self.image_url = [aDecoder decodeObjectForKey:@"image_url"];
        self.target_url = [aDecoder decodeObjectForKey:@"target_url"];
        self.target = [aDecoder decodeObjectForKey:@"target"];
        
        self.request_id = [aDecoder decodeObjectForKey:@"request_id"];
        self.type = [aDecoder decodeObjectForKey:@"type"];
        
        
    }
    
    
    return self;

}

//模型归档方法
- (void)encodeWithCoder:(NSCoder *)aCoder
{

    
    [aCoder encodeObject:self.webp_url forKey:@"webp_url"];
    [aCoder encodeObject:self.image_url forKey:@"image_url"];
    [aCoder encodeObject:self.target_url forKey:@"target_url"];
    [aCoder encodeObject:self.target forKey:@"target"];
    [aCoder encodeObject:self.request_id forKey:@"request_id"];
    [aCoder encodeObject:self.type forKey:@"type"];
    
    
}

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    
    return @{
             
             @"request_id" : @"target_id"
             
             };
}

@end




@implementation SZCycleModel


+ (instancetype)modelWithDictionary:(NSDictionary *)dict
{

    SZCycleModel *model = [[self alloc] init];
    model = [self yy_modelWithDictionary:dict];
    
    
    return model;

}





+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{

    return @{
             
             @"banners" : [SZBannerModel class]
             
             };

}




@end
