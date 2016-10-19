//
//  SZNormalCellModel.m
//  LiWuShuo
//
//  Created by lx on 16/10/5.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import "SZNormalCellModel.h"

@implementation SZColumn


- (instancetype)initWithCoder:(NSCoder *)aDecoder
{

    if (self = [super init])
    {
        
        self.cover_image_url = [aDecoder decodeObjectForKey:@"cover_image_url"];
        self.category = [aDecoder decodeObjectForKey:@"category"];
        self.subtitle = [aDecoder decodeObjectForKey:@"subtitle"];
        self.banner_image_url = [aDecoder decodeObjectForKey:@"banner_image_url"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
        
        
    }
    
    
    return self;
}


- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:self.cover_image_url forKey:@"cover_image_url"];
    [aCoder encodeObject:self.category forKey:@"category"];
    [aCoder encodeObject:self.subtitle forKey:@"subtitle"];
    [aCoder encodeObject:self.banner_image_url forKey:@"banner_image_url"];
    [aCoder encodeObject:self.title forKey:@"title"];
}


@end


@implementation SZAuthorModel


- (instancetype)initWithCoder:(NSCoder *)aDecoder
{

    self = [super init];
    if (self)
    {
        
        self.avatar_url = [aDecoder decodeObjectForKey:@"avatar_url"];
        self.nickname = [aDecoder decodeObjectForKey:@"nickname"];
        
        
    }
    
    
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:self.avatar_url forKey:@"avatar_url"];
    [aCoder encodeObject:self.nickname forKey:@"nickname"];
}



@end



@implementation SZItemModel


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{

    return @{
             
             @"post_id" : @"id"
             
             };
}



- (instancetype)initWithCoder:(NSCoder *)aDecoder
{

    self = [super init];
    if (self)
    {
        
        self.cover_image_url = [aDecoder decodeObjectForKey:@"cover_image_url"];
        
        self.introduction = [aDecoder decodeObjectForKey:@"introduction"];
        self.likes_count = [aDecoder decodeObjectForKey:@"likes_count"];
        self.share_msg = [aDecoder decodeObjectForKey:@"share_msg"];
        self.content_url = [aDecoder decodeObjectForKey:@"content_url"];
        self.feature_list = [aDecoder decodeObjectForKey:@"feature_list"];
        self.url = [aDecoder decodeObjectForKey:@"url"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.liked = [aDecoder decodeObjectForKey:@"liked"];
        self.post_id = [aDecoder decodeObjectForKey:@"post_id"];
        
        
        /**
         *  对单独模型的解档处理，只要给author对应的类签订归档解档协议，并实现方法。就行了。
         */
        //独立的模型
        self.author = [aDecoder decodeObjectForKey:@"author"];
        self.column = [aDecoder decodeObjectForKey:@"column"];
        
        
    }
    
    
    return self;
    
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:self.cover_image_url forKey:@"cover_image_url"];
    
    [aCoder encodeObject:self.introduction forKey:@"introduction"];
    [aCoder encodeObject:self.likes_count forKey:@"likes_count"];
    [aCoder encodeObject:self.share_msg forKey:@"share_msg"];
    [aCoder encodeObject:self.content_url forKey:@"content_url"];
    [aCoder encodeObject:self.feature_list forKey:@"feature_list"];
    [aCoder encodeObject:self.url forKey:@"url"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.liked forKey:@"liked"];

    [aCoder encodeObject:self.post_id forKey:@"post_id"];
    
    
    /**
     *  对单独模型的归档处理，只要给author对应的类签订归档解档协议，并实现方法。就行了。
     */
    //独立的模型
    
    [aCoder encodeObject:self.author forKey:@"author"];
    [aCoder encodeObject:self.column forKey:@"column"];
//    self.author = [aDecoder valueForKey:@"author"];
//    self.column = [aDecoder valueForKey:@"column"];
}




@end




@implementation SZNormalCellModel






+ (instancetype)modelWithDictionary:(NSDictionary *)dict
{

    SZNormalCellModel *model = [[self alloc] init];
    
    model = [SZNormalCellModel yy_modelWithDictionary:dict];
    

    return model;
    
}


+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{

    return @{
             
             @"items" : [SZItemModel class]
             
             };

}


@end
