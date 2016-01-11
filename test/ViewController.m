//
//  ViewController.m
//  test
//
//  Created by 夏桂峰 on 16/1/9.
//  Copyright (c) 2016年 夏桂峰. All rights reserved.
//

#import "ViewController.h"
#import "TestCell.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tbView;
@property(nonatomic,strong)NSMutableArray *dataArray;

@end

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
    [self createTableView];
    
}
/**创建表视图*/
-(void)createTableView
{
    _tbView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, kWidth, kHeight-64) style:UITableViewStylePlain];
    _tbView.delegate=self;
    _tbView.dataSource=self;
    [self.view addSubview:_tbView];
}
/**初始化*/
-(void)setup
{
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"自定义左滑测试";
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    _dataArray=[NSMutableArray array];
    [_dataArray addObjectsFromArray:@[@"测试文字1哈哈😄",@"测试文字2嘿嘿😱",@"测试文字3呵呵😂",@"测试文字4哦哦👻",@"测试文字5额额😁"]];
}
#pragma mark - UITableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *const cid=@"cid";
    TestCell *cell=[tableView dequeueReusableCellWithIdentifier:cid];
    if(!cell)
        cell=[[TestCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cid];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.testLb.text=_dataArray[indexPath.row];
    __weak typeof(self) wkSelf=self;
    __weak typeof(cell) wkCell=cell;
    //取消的回调
    cell.cancelCallBack=^{
        //关闭菜单
        [wkCell closeMenuWithCompletionHandle:^{
            //发送取消关注的请求
            //若请求成功，则从数据源中删除以及从界面删除
            [wkSelf.dataArray removeObjectAtIndex:indexPath.row];
            [wkSelf.tbView reloadData];
 
        }];
    };
    //删除的回调
    cell.deleteCallBack=^{
        //关闭菜单
        [wkCell closeMenuWithCompletionHandle:^{
            //发送删除请求
            //若请求成功，则从数据源中删除以及从界面删除
            [wkSelf.dataArray removeObjectAtIndex:indexPath.row];
            [wkSelf.tbView reloadData];
        }];
    };
    //左右滑动的回调
    cell.swipCallBack=^{
        for(TestCell *tmpCell in tableView.visibleCells)
            [tmpCell closeMenuWithCompletionHandle:nil];
    };
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
@end
