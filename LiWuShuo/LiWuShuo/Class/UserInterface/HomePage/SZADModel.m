//
//  SZADModel.m
//  LiWuShuo
//
//  Created by lx on 16/10/5.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import "SZADModel.h"


@implementation SZSecondBanner


- (instancetype)initWithCoder:(NSCoder *)aDecoder
{

    if (self = [super init])
    {
        
        self.target_url = [aDecoder decodeObjectForKey:@"target_url"];
        self.image_url = [aDecoder decodeObjectForKey:@"image_url"];
        self.webp_url = [aDecoder decodeObjectForKey:@"webp_url"];
        
        
    }
    
    return self;
    
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:self.target_url forKey:@"target_url"];
    [aCoder encodeObject:self.image_url forKey:@"image_url"];
    [aCoder encodeObject:self.webp_url forKey:@"webp_url"];
    
}



@end


@implementation SZADModel


+ (instancetype)modelWithDictionary:(NSDictionary *)dict
{

    SZADModel *model = [[self alloc] init];
    
    model = [SZADModel yy_modelWithDictionary:dict];
    
    

    return model;
    
    
}



+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{

    return @{
             
             @"secondary_banners" : [SZSecondBanner class]
             
             };
}

@end
