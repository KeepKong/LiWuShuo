//
//  SZDataBase.m
//  LiWuShuo
//
//  Created by lx on 16/10/11.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import "SZDataBase.h"

#import <FMDB/FMDB.h>


static FMDatabase *dataBase;
static FMDatabase *topDataBase;

@implementation SZDataBase




+ (void)initialize
{

    //获取到沙盒中Library下的Caches文件目录，目的是缓存程序运行过程中网络请求下来的图片等模型信息。
    NSArray *arr = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    
    NSString *path = [arr.firstObject stringByAppendingPathComponent:@"dataBase.db"];
    
//    NSLog(@"path = %@" , path);

    
    //开始创建数据库
    
    dataBase = [FMDatabase databaseWithPath:path];
    
    if (![dataBase open])
    {
//        NSLog(@"数据库打开失败!!");
    }
    else
    {
//        NSLog(@"数据库打开成功!!");
    }
    
    [dataBase executeUpdate:@"CREATE TABLE IF NOT EXISTS sz_first_column_db(id integer PRIMARY KEY , model blob NOT NULL , column_id text NOT NULL , type text NOT NULL);"];
    
    /**
     *  创建榜单页面数据库
     */
    NSString *topPath = [arr.firstObject stringByAppendingPathComponent:@"topDataBase.db"];
//    NSLog(@"topPath = %@" , topPath);

    
    topDataBase = [FMDatabase databaseWithPath:topPath];
    if ([topDataBase open])
    {
        NSLog(@"榜单页面数据库打开成功");
    }
    else
    {
    
        NSLog(@"榜单页面数据库打开失败");
    }
    
    [topDataBase executeUpdate:@"CREATE TABLE IF NOT EXISTS sz_top_page_db(id integer PRIMARY KEY , model blob NOT NULL , column_id text NOT NULL , type text NOT NULL);"];
    

    

    
}

#pragma mark - 在数据库中对轮播数据的操作

+ (void)addFirstColumnCycleModel:(SZBannerModel *)model
{

    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
    
    [dataBase executeUpdateWithFormat:@"INSERT INTO sz_first_column_db(model , column_id , type) VALUES(%@ , %@ , %@);" , data , [NSString stringWithFormat:@"%ld" , model.columnNumber] , @"cycle"];
    
    
}

//从数据库中获取到轮播模型数据
+ (NSMutableArray *)gainCycleModel
{

    FMResultSet *set = [dataBase executeQuery:@"SELECT * FROM sz_first_column_db WHERE type='cycle';"];
    
    NSMutableArray *modelsMuArr = [NSMutableArray array];
    
    
    while ([set next])
    {
        
        
//        NSString * modelStr =[set stringForColumn:@"model"];
        NSData *data = [set dataForColumn:@"model"];
//        NSData *data = [modelStr dataUsingEncoding:NSUTF8StringEncoding];
        
        SZBannerModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        [modelsMuArr addObject:model];

        
    }
//    NSLog(@"目前数据库中的轮播数据个数为%ld" , modelsMuArr.count);
    return modelsMuArr;
    
    
}

/**
 *  刷新当前表视图上的数据，如果当前表示图上的数据有超过20条的，例如上拉加载了更多数据，那么这个时候数据库中肯定保存了不止20条的数据，所以我们应该用新刷新得到的20条，覆盖掉之前加载过来的所有数据。
 *
 */
+ (void)refreshCycleModelData:(NSMutableArray *)bannerModelsMuArr
{
    
    
    //首先要拿到数据库中已存在的轮播数据模型，然后进行删除
    [dataBase executeStatements:@"DELETE FROM sz_first_column_db WHERE type='cycle';"];
    
    //将最新的模型数据存入数据库中
    for (SZBannerModel *model in bannerModelsMuArr)
    {
        
        model.columnNumber = 0;
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
        
        [dataBase executeUpdateWithFormat:@"INSERT INTO sz_first_column_db(model , column_id , type) VALUES(%@ , %@ , %@);" , data , [NSString stringWithFormat:@"%ld" , model.columnNumber] , @"cycle"];
        
    }
    //    NSLog(@"更新了数据库中的轮播数据");
    
    
    
}




#pragma mark - 在数据库中对轮播下方数据的操作

+ (void)addSecondModel:(SZSecondBanner *)model
{

    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];

    
    [dataBase executeUpdateWithFormat:@"INSERT INTO sz_first_column_db(model , column_id , type) VALUES(%@ , %@ , %@);" , data , [NSString stringWithFormat:@"%ld" , model.columnNumber] , @"second"];
    
    
    
}
+ (NSMutableArray *)gainSecondModels
{

    NSMutableArray *secondMuArr = [NSMutableArray array];
    
    FMResultSet *set = [dataBase executeQuery:@"SELECT * FROM sz_first_column_db WHERE type='second';"];
    
    while ([set next])
    {
        
        NSData *data = [set dataForColumn:@"model"];
        SZSecondBanner *banner = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        [secondMuArr addObject:banner];
        
        
    }
    
//    NSLog(@"目前数据库中的广告模型个数为%ld" , secondMuArr.count);
    return secondMuArr;
    
    
}

+ (void)refreshSecondModelData:(NSMutableArray *)secondBannersMuArr
{
    
    
    [dataBase executeStatements:@"DELETE FROM sz_first_column_db WHERE type='second'"];
    
    for (SZSecondBanner *banner in secondBannersMuArr)
    {
        
        
        banner.columnNumber = 0;
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:banner];
        
        [dataBase executeUpdateWithFormat:@"INSERT INTO sz_first_column_db(model , column_id , type) VALUES(%@ , %@ , %@);" , data , [NSString stringWithFormat:@"%ld" , banner.columnNumber] , @"second"];

    }
    
    

    
}



#pragma mark - 在数据库中对普通数据模型的操作


/**
 *  保存普通数据模型
 */
+ (void)addNormalModel:(SZItemModel *)model
{

    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
    [dataBase executeUpdateWithFormat:@"INSERT INTO sz_first_column_db(model , column_id , type) VALUES(%@ , %@ , %@);" , data , [NSString stringWithFormat:@"%ld" , model.columnNumber] , @"normal"];
    
    
    

}
/**
 *  获取到普通数据模型
 */
+ (NSMutableArray *)gainNormalModelsWithColumnIndex:(NSInteger)index
{
    
    NSMutableArray *normalMuArr = [NSMutableArray array];
//    SELECT * FROM sz_first_column_db WHERE type='second';
//    FMResultSet *set = [dataBase executeQuery:@"SELECT * FROM sz_first_column_db WHERE type='normal';"];

    FMResultSet *set = [dataBase executeQueryWithFormat:@"SELECT * FROM sz_first_column_db WHERE column_id=%@ and type='normal';" , [NSString stringWithFormat:@"%ld" , index]];
    
//    FMResultSet *set = [dataBase executeQuery:@"SELECT * FROM sz_first_column_db "];
    while ([set next])
    {
        
        NSData *data = [set dataForColumn:@"model"];
        SZItemModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        [normalMuArr addObject:model];
        
        
    }
//    NSLog(@"第%ld个栏目的数量是count = %ld" , index ,normalMuArr.count);
    
    return normalMuArr;
    

}

/**
 *  刷新普通数据模型
 */
+ (void)refreshNormalModelData:(NSMutableArray *)normalModelsMuArr withIndex:(NSInteger)index
{

    //先删除
    [dataBase executeStatements:[NSString stringWithFormat:@"DELETE FROM sz_first_column_db WHERE type='normal' and column_id=%@" , [NSString stringWithFormat:@"%ld" , index]]];
    
    //再添加
    for (SZItemModel *model in normalModelsMuArr)
    {
        model.columnNumber = index;
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
        
        [dataBase executeUpdateWithFormat:@"INSERT INTO sz_first_column_db(model , column_id , type) VALUES(%@ , %@ , %@);" , data , [NSString stringWithFormat:@"%ld" , model.columnNumber] , @"normal"];

        
    }
    
    
    
    
}




#pragma mark - 删除表中的所有数据
/**
 
 *  一旦程序退出，那么就不再需要程序运行过程中加载过来的数据了。因此删除所有栏目中的模型数据
 
 */
+ (void)removeHomePageAllColumnModel
{

    
    [dataBase executeStatements:@"DELETE FROM sz_first_column_db;"];
    
    [dataBase close];

    
    
}


//-------------------------------------------------------
//------------------------------------------------------
/**
 *  榜单页面的数据库操作
 */


/**
 *  保存每个栏目中的顶部图片等数据
 */
+ (void)addTopOtherModel:(SZTopContentModel *)model
{

    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
    
    [topDataBase executeUpdateWithFormat:@"INSERT INTO sz_top_page_db(model , column_id , type) VALUES(%@ , %@ , %@);", data , [NSString stringWithFormat:@"%ld" , model.columnNumber] , @"topHeader"];
    
    
    
}

/**
 *  获取每个栏目中模型中的初级数据，和上面写入的方法对应
 */
+ (SZTopContentModel *)gainTopHeaderModelWithIndex:(NSInteger)index
{

    FMResultSet *set = [topDataBase executeQueryWithFormat:@"SELECT * FROM sz_top_page_db WHERE column_id=%ld and type='topHeader';" , index];
    
    SZTopContentModel *model = nil;
    
    while ([set next])
    {
    
        model = [NSKeyedUnarchiver unarchiveObjectWithData:[set dataForColumn:@"model"]];
//        NSLog(@"获取到了%ld个栏目的头数据,里面的个数是%ld" , index , model.items.count);
    }
    
    return model;
    
    
}
/**
 *  对数据库中榜单页面数据的刷新
 */
+ (void)refreshTopPageData:(SZTopContentModel *)model WithIndex:(NSInteger)index
{

    [topDataBase executeUpdateWithFormat:@"DELETE FROM sz_top_page_db WHERE column_id=%ld and type='topHeader';" , index];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
    [topDataBase executeUpdateWithFormat:@"INSERT INTO sz_top_page_db(model , column_id , type) VALUES(%@ , %@ , %@);" , data , [NSString stringWithFormat:@"%ld" , index] , @"topHeader"];
    

    
}


+ (void)removeTopPageAllData
{
    
    [topDataBase executeStatements:@"DELETE FROM sz_top_page_db;"];

}



@end
