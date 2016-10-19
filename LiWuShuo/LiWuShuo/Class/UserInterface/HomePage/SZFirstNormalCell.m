//
//  SZFirstNormalCell.m
//  LiWuShuo
//
//  Created by lx on 16/10/5.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import "SZFirstNormalCell.h"
#import <SDWebImage/UIImageView+WebCache.h>


@implementation SZFirstNormalCell

- (void)awakeFromNib {

    self.userImageV.layer.cornerRadius = self.userImageV.bounds.size.height/2.0;
    self.userImageV.layer.masksToBounds = YES;
    
//    self.typeLabel.layer.cornerRadius = 5.0;
    self.typeBgView.layer.cornerRadius = 3.0;
    self.currentTimeLabel.adjustsFontSizeToFitWidth = YES;
    
    
    
    
}


//- (void)getWeek
//{
//    
//    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
//    NSDate *now;
//    NSDateComponents *comps = [[NSDateComponents alloc] init];
//    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
//    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
//    
//    now=[NSDate date];
//    comps = [calendar components:unitFlags fromDate:[NSDate date]];
//    NSInteger year=[comps year];
//    NSInteger week = [comps weekday];
//    NSInteger month = [comps month];
//    NSInteger day = [comps day];
////    NSInteger hour = [comps hour];
////    NSInteger min = [comps minute];
////    NSInteger sec = [comps second];
//    
//    NSArray * arrWeek=[NSArray arrayWithObjects:@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六", nil];
//    
//    NSLog(@"星期:%@", [NSString stringWithFormat:@"%@",[arrWeek objectAtIndex:[comps weekday] - 1]]);
//}


- (void)_setCurrentAndUpdateTime
{

    //设置当前时间Label和下次更新时间label
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *now;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    now=[NSDate date];
    comps = [calendar components:unitFlags fromDate:[NSDate date]];
    //    NSInteger year=[comps year];
    NSInteger week = [comps weekday];
    NSInteger month = [comps month];
    NSInteger day = [comps day];
    NSInteger hour = [comps hour];
    NSInteger minute = [comps minute];
    NSArray * arrWeek=[NSArray arrayWithObjects:@"日",@"一",@"二",@"三",@"四",@"五",@"六", nil];
    
    
    self.currentTimeLabel.text = [NSString stringWithFormat:@"%ld月%ld日 星期%@" , month , day , [arrWeek objectAtIndex:week-1] ];
//    NSLog(@"%@" , self.currentTimeLabel.text);
//    NSLog(@"hour = %ld , minute = %ld" , hour , minute);
    
    NSString *showTime = @"";
    NSInteger secondValue = hour * 60 * 60 + minute * 60;
    //设置下次更新时间
    /**
     *  [0]	String	"8:00"
     [1]	String	"11:00"
     [2]	String	"17:00"
     [3]	String	"20:00"
     */
    
    
    if (secondValue >= 20 * 3600 || secondValue < 8 * 3600)
    {
        
        showTime = @"8:00";
    }
    else if (secondValue >= 8 * 3600 && secondValue < 11 * 3600)
    {
    
        showTime = @"11:00";
    }
    else if (secondValue >= 11 * 3600 && secondValue < 17 * 3600)
    {
        showTime = @"17:00";
    }
    else if (secondValue >= 17 * 3600 && secondValue < 20 * 3600)
    {
        showTime = @"20:00";
    }
    
    self.updateTime.text = [NSString stringWithFormat:@"下次更新%@" , showTime];

    
    
    
}


- (void)setItemModel:(SZItemModel *)itemModel
{

    if (_itemModel != itemModel)
    {
        _itemModel = itemModel;
    }

    //设置更新时间和当前日期
    [self _setCurrentAndUpdateTime];
    
    
    
    //计算类型文本需要的宽度
    NSMutableParagraphStyle *paragphStyle=[[NSMutableParagraphStyle alloc]init];
    
    paragphStyle.lineSpacing=0;//设置行距为0
    paragphStyle.firstLineHeadIndent=0.0;
    paragphStyle.hyphenationFactor=0.0;
    paragphStyle.paragraphSpacingBefore=0.0;
    
    NSDictionary *dic=@{
                        
                        NSFontAttributeName:[UIFont systemFontOfSize:15], NSParagraphStyleAttributeName:paragphStyle, NSKernAttributeName:@1.0f
                        
                        };
    CGSize size=[itemModel.column.category boundingRectWithSize:CGSizeMake(10000, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
//    NSLog(@"size.width = %lf"  , size.width);
//    NSLog(@"category = %@" , itemModel.column.category);
    self.typeViewWidth.constant = size.width;
    
    //设置类型文本
    self.typeLabel.text = itemModel.column.category;
    
    
    
    //设置栏目标题
    self.columnTitle.text = itemModel.column.title;
    //设置用户图片
    [self.userImageV sd_setImageWithURL:[NSURL URLWithString:itemModel.author.avatar_url] placeholderImage:[UIImage imageNamed:@"giftBgImage"]];

    //设置用户名称
    self.userName.text = itemModel.author.nickname;
    
    //设置内容大图
    [self.contentImageV sd_setImageWithURL:[NSURL URLWithString:itemModel.cover_image_url] placeholderImage:[UIImage imageNamed:@"giftBgImage"]];
    //设置礼物标题
    self.title.text = itemModel.title;
    //设置喜爱数
    self.favoriteLabel.text = [NSString stringWithFormat:@"%ld" , [itemModel.likes_count integerValue]];
    
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
