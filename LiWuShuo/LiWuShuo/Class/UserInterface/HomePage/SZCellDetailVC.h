//
//  SZCellDetailVC.h
//  LiWuShuo
//
//  Created by lx on 16/10/13.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SZCellDetailVC : UIViewController


@property (weak, nonatomic) IBOutlet UILabel *loveLable;


@property (weak, nonatomic) IBOutlet UILabel *shareLabel;






@property (weak, nonatomic) IBOutlet UILabel *commentLabel;



@property (weak, nonatomic) IBOutlet UIWebView *detailWebView;


@property (weak, nonatomic) IBOutlet UIView *buttomView;



/**
 *  保存post_id，用于webView的显示
 */
@property (nonatomic , strong) NSNumber *post_id;



@end
