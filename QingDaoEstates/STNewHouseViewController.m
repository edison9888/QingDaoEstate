//
//  STNewHouseViewController.m
//  QingDaoEstates
//
//  Created by scott on 13-11-12.
//  Copyright (c) 2013年 scott. All rights reserved.
//

#import "STNewHouseViewController.h"
#import "STBlockButton.h"
#import "STDetailWebViewController.h"
#import "STDataHelper+Network.h"
#import "STDataHelper+Database.h"
#import "STNewHouseCell.h"
#import "STModelHouse.h"

@implementation STNewHouseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    /*初始化数据源*/
    _dataArray = [[NSMutableArray alloc] init];
    
    /*标题*/
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.bounds.size.width-110)/2.0f, 0, 100, 44)];
    [self.navigationItem.titleView addSubview:titleLabel];
    titleLabel.text = @"找新房";
    titleLabel.font = [UIFont boldSystemFontOfSize:20.0f];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    /*地图按钮*/
    STBlockButton *mapBtn = [STBlockButton buttonWithType:UIButtonTypeCustom];
    [self.navigationItem.titleView addSubview:mapBtn];
    mapBtn.frame = CGRectMake(200, (44-30.5)/2.0f, 45, 30.5);
    [mapBtn setBackgroundImage:[UIImage imageNamed:@"LP_mogu_dituBtn.png"] forState:UIControlStateNormal];
    [mapBtn setBackgroundImage:[UIImage imageNamed:@"LP_mogu_dituBtn_sel.png"] forState:UIControlStateHighlighted];
    
    /*搜索按钮*/
    STBlockButton *searchBtn = [STBlockButton buttonWithType:UIButtonTypeCustom];
    [self.navigationItem.titleView addSubview:searchBtn];
    searchBtn.frame = CGRectMake(260, (44-30.5)/2.0f, 45, 30.5);
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"LP_freshHouse_search.png"] forState:UIControlStateNormal];
    
    /*打折优惠按钮*/
    _discountBtn = [STBlockButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_discountBtn];
    _discountBtn.frame = CGRectMake(0, 0, self.view.bounds.size.width, 50);
    [_discountBtn setBackgroundImage:[UIImage imageNamed:@"LP_mogu_loupanBg.png"] forState:UIControlStateNormal];
    [_discountBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    /*看房车按钮*/
    _houseCarBtn = [STBlockButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_houseCarBtn];
    _houseCarBtn.frame = CGRectMake(0, 50, self.view.bounds.size.width, 50);
    [_houseCarBtn setBackgroundImage:[UIImage imageNamed:@"LP_mogu_loupanBg.png"] forState:UIControlStateNormal];
    [_houseCarBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    /*四个按钮的工具条*/
    _toolsBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 30)];
    _toolsBar.userInteractionEnabled = YES;
    _toolsBar.image = [UIImage imageNamed:@"LP_mogu_loupanBg.png"];
    NSArray *btnNames = [NSArray arrayWithObjects:@"区域", @"类型", @"价格", @"排序", nil];
    for (int i = 0; i <= 3; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_toolsBar addSubview:btn];
        btn.frame = CGRectMake(i*80, 0, 80, 30);
        [btn setTitle:[btnNames objectAtIndex:i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, -25, 0, 10);
        [btn setImage:[UIImage imageNamed:@"LP_mogu_angel"] forState:UIControlStateNormal];
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, 60, 0, 0);
        [btn addTarget:self action:@selector(toolsBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    /*统计的信息栏*/
    _statisticLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, self.view.bounds.size.width, 20)];
    _statisticLabel.textAlignment = NSTextAlignmentCenter;
    _statisticLabel.backgroundColor = [UIColor redColor];
    
    /*列表*/
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, kScreenHeight-64) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[STNewHouseCell class] forCellReuseIdentifier:@"CELLID"];
    
    /*加载网络*/
    [[STDataHelper sharedInstance] newHouseFetchNetworkDataStart];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newHouseFetchNetworkDataCompleted:) name:kNotificationNewHouseFetchNetworkDataCompleted object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newHouseFetchNetworkDataFailed:) name:kNotificationNewHouseFetchNetworkDataFailed object:nil];
}

#pragma - mark 通知回调
- (void)newHouseFetchNetworkDataCompleted:(NSNotification *)notification
{
    /*
     打折优惠4  tour_num
     看房车2  showings_num
     共找到1627条信息 total_num
     */
    NSDictionary *updateDict = [notification object];
    NSString *tour_num = [updateDict objectForKey:@"tour_num"];
    NSString *showings_num = [updateDict objectForKey:@"showings_num"];
    NSString *total_num = [updateDict objectForKey:@"total_num"];
    
    [_dataArray addObjectsFromArray:[[STDataHelper sharedInstance] newHouseFetchDatabaseData]];
    dispatch_async(dispatch_get_main_queue(), ^{
        /*刷新tableHeaderView*/
        [_discountBtn setTitle:[NSString stringWithFormat:@"打折优惠（共%@个优惠楼盘）", tour_num] forState:UIControlStateNormal];
        [_houseCarBtn setTitle:[NSString stringWithFormat:@"看 房 车（共%@条看房车路线）", showings_num] forState:UIControlStateNormal];
        UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
        _tableView.tableHeaderView = header;
        [header addSubview:_discountBtn];
        [header addSubview:_houseCarBtn];
        /*刷新统计信息*/
        _statisticLabel.text = [NSString stringWithFormat:@"共找到%@条信息", total_num];

        [_tableView reloadData];
    });
}

- (void)newHouseFetchNetworkDataFailed:(NSNotification *)notification
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"无法连接网络" message:@"请检查网络连接，稍后重试." delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
}

#pragma - mark 事件响应
- (void)toolsBarButtonClicked:(UIButton *)btn
{
    
}

- (void)backButtonClicked
{
    [super backButtonClicked];
}

#pragma - mark UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (0 == _dataArray.count) ? 1:_dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    STNewHouseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELLID"];
    if (0 != _dataArray.count)
    {
        STModelHouse *house = [_dataArray objectAtIndex:indexPath.row];
        [cell layoutWithHouse:house];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (0 != _dataArray.count)
    {
        /*推入细节页面*/
        STModelHouse *house = [_dataArray objectAtIndex:indexPath.row];
        STDetailWebViewController *detail = [[STDetailWebViewController alloc] init];
        [detail layoutWithHouse:house];
        [self.navigationController pushViewController:detail animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (0 == _dataArray.count)
    {
        return 30;
    }
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*动态计算每一个cell的高度*/
    if (0 != _dataArray.count)
    {
        STModelHouse *house = [_dataArray objectAtIndex:indexPath.row];
        return [STNewHouseCell cellHeightWithHouse:house];
    }
    return kScreenHeight-50-3*44-20;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionHeaderView = [[UIView alloc] init];
    sectionHeaderView.userInteractionEnabled = YES;
    [sectionHeaderView addSubview:_toolsBar];
    if (0 == _dataArray.count)
    {
        sectionHeaderView.frame = CGRectMake(0, 0, kScreenWidth, 30);
    }else {
        sectionHeaderView.frame = CGRectMake(0, 0, kScreenWidth, 50);
        [sectionHeaderView addSubview:_statisticLabel];
    }
    return sectionHeaderView;
}

@end
