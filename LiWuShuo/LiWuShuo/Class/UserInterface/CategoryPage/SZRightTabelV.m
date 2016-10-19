//
//  SZRightTabelV.m
//  LiWuShuo
//
//  Created by lx on 16/10/15.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import "SZRightTabelV.h"
#import "SZRightCell.h"



#define KCellID @"CellID"






@interface SZRightTabelV ()<UITableViewDelegate , UITableViewDataSource>


@property (nonatomic , assign) NSInteger currentIndex;


@property (nonatomic , strong) NSMutableArray *heightMuArr;


@end





@implementation SZRightTabelV


- (void)awakeFromNib
{
    
    self.currentIndex = 0;
    
    self.delegate = self;
    self.dataSource = self;
    
    self.showsVerticalScrollIndicator = NO;
    self.bounces = NO;
    self.separatorColor = [UIColor clearColor];
    
    [self registerNib:[UINib nibWithNibName:@"SZRightCell" bundle:nil] forCellReuseIdentifier:@"rightCell"];
    
    
    //注册成为左边栏目改变通知的观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(categoryLeftIndexChange:) name:KCategoryLeftIndexChange object:nil];
    
    
}

- (NSMutableArray *)heightMuArr
{

    if (_heightMuArr == nil)
    {
        _heightMuArr = [NSMutableArray array];
    }
    
    
    return _heightMuArr;
}


- (void)setRightModel:(SZDanPinModel *)rightModel
{

    if (_rightModel != rightModel)
    {
        _rightModel = rightModel;
    }
    
    for (SZDanPinCategorieModel *categoryModel in rightModel.categories)
    {

        NSInteger count = categoryModel.subcategories.count;
        
        NSInteger temp = count % 3 ==0? (count / 3):(count / 3 + 1);
        
        [self.heightMuArr addObject:[NSNumber numberWithFloat:[categoryModel.rowHeight floatValue] + (CGFloat)(temp + 1) * 7 + 30 + 5]];
        
    }
    
    NSLog(@"arr = %ld" , self.heightMuArr.count);
    
    [self reloadData];
}

#pragma mark - 通知响应方法
- (void)categoryLeftIndexChange:(NSNotification *)notification
{

    self.currentIndex = [notification.userInfo[@"currentIndex"] integerValue];
    
    [self scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:self.currentIndex inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    
    
    
    
}




#pragma mark - TabelView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.rightModel.categories.count;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SZRightCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rightCell"];

    SZDanPinCategorieModel *category = self.rightModel.categories[indexPath.row];

    
    //设置cell上的分类label
    cell.categoryLabel.text = category.name;
    
    cell.contentCollV.subCategoryMuArr = [category.subcategories mutableCopy];
    

    
    return cell;
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{


    SZDanPinCategorieModel *model = self.rightModel.categories[indexPath.row];
    
//    NSLog(@"rowHeight = %lf" , [model.rowHeight floatValue]);
    
    NSInteger count = model.subcategories.count;
    
    NSInteger temp = count % 3 ==0? (count / 3):(count / 3 + 1);
    
    
    
    
    return [model.rowHeight floatValue] + (temp + 1) * 7 + 30 + 5;

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat offset = scrollView.contentOffset.y;
//    NSLog(@"offset = %lf", offset);
    
//    NSLog(@"height = %lf" , scrollView.contentSize.height);
    
//    CGFloat totalHeight = 0.0;
    
    NSInteger count = self.heightMuArr.count;
    
    CGFloat currentTotalHeight = 0.0;
    
    CGFloat nextTotalHeight = 0.0;
    
    for (int i = 0 ; i < count ; i++)
    {
        
        NSNumber *height = self.heightMuArr[i];
        
        nextTotalHeight = currentTotalHeight + [height floatValue];
        
        
//        if (i < count-1)
//        {
//            
//            nextHeight = self.heightMuArr[i + 1];
//
//        }
//        
//        nextTotalHeight = currentTotalHeight + [nextHeight floatValue];
        
        if (offset >= currentTotalHeight && offset < nextTotalHeight)
        {
            
            NSLog(@"i = %d" , i);
            
            self.currentIndex = i;
            
            //    NSLog(@"currentIndex = %ld" , self.currentIndex);
            
            [[NSNotificationCenter defaultCenter] postNotificationName:KCategoryRightIndexChange
            object:self
            userInfo:@{
                        @"currentIndex" : @(self.currentIndex)
                                                                         
                        }];
            
            
            
        }
        
        currentTotalHeight += [height floatValue];
        
    }
    
    


}



//- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath NS_AVAILABLE_IOS(6_0)
//{
//
//    //记录之前结束显示的索引值
////    static NSInteger previousIndex = 0;
//    
//
//    
//    self.currentIndex = indexPath.row + 1;
//    
////    NSLog(@"currentIndex = %ld" , self.currentIndex);
//    
//    [[NSNotificationCenter defaultCenter] postNotificationName:KCategoryRightIndexChange
//    object:self
//    userInfo:@{
//               
//               @"currentIndex" : @(self.currentIndex)
//                                                                 
//                }];
//
//    
//
//    
//    
//
//    
//    
//}

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//    
//
//    self.currentIndex = indexPath.row;
//    
//    NSLog(@"currentIndex = %ld" , self.currentIndex);
//    
//    [[NSNotificationCenter defaultCenter] postNotificationName:KCategoryRightIndexChange
//    object:self
//    userInfo:@{
//                                                                 
//                @"currentIndex" : @(self.currentIndex)
//                                                                 
//                }];
//    
//    
//}






- (void)dealloc
{

    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}



@end
