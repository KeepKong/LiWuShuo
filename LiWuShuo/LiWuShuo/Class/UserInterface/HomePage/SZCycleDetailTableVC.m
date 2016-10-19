//
//  SZCycleDetailTableVC.m
//  LiWuShuo
//
//  Created by lx on 16/10/15.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

#import "SZCycleDetailTableVC.h"
#import "SZCycleDetailModel.h"
#import "SZNetWorkingTool.h"
#import "SZDetailCell.h"



@interface SZCycleDetailTableVC ()

@end

@implementation SZCycleDetailTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.navigationController.navigationBar.titleTextAttributes =
    @{
                                                                    
      NSForegroundColorAttributeName : [UIColor whiteColor]
                                                                    
                                                                    
        };
    
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SZDetailCell" bundle:nil] forCellReuseIdentifier:@"cycleDetailCell"];
    
    self.tableView.bounces = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    
    
    /**
     *  设置导航栏按钮
     */
    //左边按钮
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    leftBtn.frame = CGRectMake(0, 0, 25, 25);
    [leftBtn setImage:[UIImage imageNamed:@"back1"] forState:UIControlStateNormal];
    
    leftBtn.tintColor = [UIColor whiteColor];
    
    [leftBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    
    
//    [self.tableView registerClass:[SZDetailCell class] forCellReuseIdentifier:@"cycleDetailCell"];
    
    
    [self _loadCycleDetailPageData];

    
}

#pragma mark - back
- (void)backAction:(UIButton *)sender
{

    [self.navigationController popViewControllerAnimated:YES];
}


- (void)setPostModelMuArr:(NSMutableArray *)postModelMuArr
{

    if (_postModelMuArr != postModelMuArr)
    {
        _postModelMuArr = postModelMuArr;
    }
//    NSLog(@"thread = %@" , [NSThread currentThread]);
    [self.tableView reloadData];
    
}

- (void)setRequest_id:(NSNumber *)request_id
{

    if (_request_id != request_id)
    {
        _request_id = request_id;
    }
    
//    [self _loadCycleDetailPageData];
}

#pragma mark - 请求轮播详情页面的数据
- (void)_loadCycleDetailPageData
{
    NSString *str = nil;
    //拼接URL
    str = [NSString stringWithFormat:@"collections/%ld/posts?limit=20&offset=0" , [self.request_id integerValue]];

        
    
    AFHTTPSessionManager *manager = [SZNetWorkingTool getBaseUrlSessionManager];
    [manager GET:str parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSData *  _Nullable responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        //        NSLog(@"banner_image_url = %@" , dict[@"data"][@"banner_image_url"]);
        //        [dict[@"data"][@"posts"][0] generatePropertyCodes];
        
        SZCycleDetailModel *model = [SZCycleDetailModel modelWithDictionary:dict[@"data"]];
        
        self.postModelMuArr = [model.posts mutableCopy];
        
        
        //设置导航栏的标题
        self.navigationItem.title = model.title;
        
        //刷新表视图
//        NSLog(@"dafsdfs");
//        [self.tableView reloadData];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"点击轮播视图请求URL发生错误");
        
    }];
    
    
    
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

//    NSLog(@"count = %ld" , self.postModelMuArr.count);
    return self.postModelMuArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SZDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cycleDetailCell" forIndexPath:indexPath];
    
//    NSLog(@"cell = %@" , cell);
    
    cell.postModel = self.postModelMuArr[indexPath.row];
    
    
    
    
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 400;
    
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    
    return NO;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
