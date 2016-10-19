//
//  SZGongLueTabelV.m
//  LiWuShuo
//
//  Created by lx on 16/10/8.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import "SZGongLueTabelV.h"
#import "SZGongLueCell.h"
#import "SZGongLueTowCell.h"




@interface SZGongLueTabelV ()<UITableViewDataSource , UITableViewDelegate>

@end



@implementation SZGongLueTabelV


- (void)awakeFromNib
{

    self.delegate = self;
    self.dataSource  = self;
    

    
    self.separatorColor = [UIColor clearColor];
    
    //设置最后一个单元格下面没有分割视图
    self.contentInset = UIEdgeInsetsMake(0, 0, -10, 0);
    self.bounces = NO;

}

- (void)setGroupModel:(SZChannelGroupModel *)groupModel
{

    if (_groupModel != groupModel)
    {
        _groupModel = groupModel;
    }
    
    
    [self reloadData];


}



#pragma mark - tableViewDelegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 1 + self.groupModel.channel_groups.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    NSString *resueID = @"";
    
    if (indexPath.row == 0)
    {
        
        resueID = @"firstCell";
    }
    else
    {
    
        resueID = @"towCell";
    }
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:resueID];
    
    if (cell == nil)
    {
        
        if ([resueID isEqualToString:@"firstCell"])
        {
        
            cell = (SZGongLueCell *)[[[NSBundle mainBundle] loadNibNamed:@"SZGongLueCell" owner:self options:nil] firstObject];
            
        }
        else
        {
            
            
            cell = (SZGongLueTowCell *)[[[NSBundle mainBundle] loadNibNamed:@"SZGongLueCell" owner:self options:nil] lastObject];
        }
        
 
    }

    
    //通过判断，给cell赋上model
    if ([resueID isEqualToString:@"firstCell"])
    {
        
        SZGongLueCell * gongLueCell = (SZGongLueCell *)cell;
        
        gongLueCell.columnModel = self.columnModel;
        
        
        return gongLueCell;
        
        
    }
    else
    {
        
        
        SZGongLueTowCell *gongLueTowCell = (SZGongLueTowCell *)cell;
        

        gongLueTowCell.channelModel = self.groupModel.channel_groups[indexPath.row - 1];
        
        
        return gongLueTowCell;
        
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.row == 0)
    {
        
        return 321;
        
    }
    else
    {
    
        return 341;
    }
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
