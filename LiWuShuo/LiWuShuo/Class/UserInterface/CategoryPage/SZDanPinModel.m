//
//  SZDanPinModel.m
//  LiWuShuo
//
//  Created by lx on 16/10/15.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import "SZDanPinModel.h"
#import <UIKit/UIKit.h>

#define KCellHeight 120

@implementation SZSubcategorieModel



@end

@implementation SZDanPinCategorieModel


- (void)setSubcategories:(NSArray *)subcategories
{

    if (_subcategories != subcategories)
    {
        _subcategories = subcategories;

        
        
        NSInteger count = subcategories.count;
        
        
        
        NSInteger temp = count % 3 ==0? (count / 3):(count / 3 + 1);
        
//        NSLog(@"temp = %ld" , temp);
        
        self.rowHeight = [NSNumber numberWithFloat:(CGFloat)temp * KCellHeight];
        
        

    }
    
}



+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{

    return @{
             
             @"subcategories" : [SZSubcategorieModel class]
             
             };
}

@end



@implementation SZDanPinModel


+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{

    return @{
             
             @"categories" : [SZDanPinCategorieModel class]
             
             
             };
}



+ (instancetype)modelWithDictionary:(NSDictionary *)dict
{

    SZDanPinModel *model = [SZDanPinModel yy_modelWithDictionary:dict];
    
    return model;

}



@end
