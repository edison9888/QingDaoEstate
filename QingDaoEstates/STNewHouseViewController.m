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
    SET_TITLE(@"找新房");
    
    /*创建地图按钮和搜索按钮*/
    CREATE_MAP_SEARCH_BUTTONS;
    
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
    CREATE_TOOLS_BAR_WITH_FRAME(0, 0, kScreenWidth, 30);
    
    /*统计的信息栏*/
    _statisticLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, self.view.bounds.size.width, 20)];
    _statisticLabel.textAlignment = NSTextAlignmentCenter;
    _statisticLabel.backgroundColor = [UIColor redColor];
    
    /*列表*/
    CREATE_EGO_TABLEVIEW_WITH_FRAME(0, 0, kScreenWidth, kScreenHeight-64);
    
    /*筛选视图*/
    _selectView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, kScreenWidth, 180)];
    [self.view addSubview:_selectView];
    _selectView.userInteractionEnabled = YES;
    
    _picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 30, kScreenWidth, 150)];
    [_selectView addSubview:_picker];
    _picker.dataSource = self;
    _picker.delegate = self;
    _picker.backgroundColor = [UIColor whiteColor];
    _picker.userInteractionEnabled = YES;
    
    UIView *accessoryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    [_selectView addSubview:accessoryView];
    accessoryView.userInteractionEnabled = YES;
    accessoryView.backgroundColor = [UIColor grayColor];
    
    _pickerCancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [accessoryView addSubview:_pickerCancelBtn];
    _pickerCancelBtn.frame = CGRectMake((30-25)/2.0f, (30-25)/2.0f, 50, 25);
    [_pickerCancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_pickerCancelBtn addTarget:self action:@selector(pickerCancelClicked) forControlEvents:UIControlEventTouchUpInside];
    _pickerCancelBtn.backgroundColor = [UIColor yellowColor];
    
    _pickerConfirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [accessoryView addSubview:_pickerConfirmBtn];
    _pickerConfirmBtn.frame = CGRectMake(kScreenWidth-(30-25)/2.0f-50, (30-25)/2.0f, 50, 25);
    [_pickerConfirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_pickerConfirmBtn addTarget:self action:@selector(pickerConfirmClicked) forControlEvents:UIControlEventTouchUpInside];
    _pickerConfirmBtn.backgroundColor = [UIColor yellowColor];
    
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
        /*刷新上拉刷新视图的位置*/
        _refreshFooterView.frame = CGRectMake(0, _tableView.contentSize.height, _tableView.bounds.size.width, _tableView.bounds.size.height);
    });
}

- (void)newHouseFetchNetworkDataFailed:(NSNotification *)notification
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"无法连接网络" message:@"请检查网络连接，稍后重试." delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
}

#pragma - mark 事件响应
- (void)backButtonClicked
{
    [super backButtonClicked];
    /*如果需要的话,会取消本次线程*/
    [[STDataHelper sharedInstance] newHouseFetchNetworkDataCancel];
}

- (void)mapBtnClicked
{
    
}

- (void)searchBtnClicked
{
    
}

- (void)toolsBarButtonClicked:(UIButton *)btn
{
    if (_pickerIsVisible)
    {
        /*隐藏*/
        [self hidePickerView];
        _tableView.scrollEnabled = YES;
        /*所有cell可以点击*/
        for (int i = 0; i <= _dataArray.count-1; i++)
        {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            UITableViewCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
            cell.userInteractionEnabled = YES;
        }
        /*所有按钮可以点击*/
        for (id obj in _toolsBar.subviews) {
            if ([obj isMemberOfClass:[UIButton class]])
            {
                UIButton *button = (UIButton *)obj;
                button.enabled = YES;
            }
        }
    }else {
        _tableView.scrollEnabled = NO;
        /*所有cell不可点击*/
        for (int i = 0; i <= _dataArray.count-1; i++)
        {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            UITableViewCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
            cell.userInteractionEnabled = NO;
        }
        if (btn == _areaBtn)
        {
            /*区域*/
            _pickerBtnIndex = 0;
            
        }else if (btn == _typeBtn)
        {
            /*类型*/
            _pickerBtnIndex = 1;
            
        }else if (btn == _priceBtn)
        {
            /*价格*/
            _pickerBtnIndex = 2;
        }else {
            /*排序*/
            _pickerBtnIndex = 3;
        }
        /*显示*/
        [self showPickerView];
        /*别的按钮不可点击*/
        for (id obj in _toolsBar.subviews) {
            if ([obj isMemberOfClass:[UIButton class]] && obj != btn)
            {
                UIButton *button = (UIButton *)obj;
                button.enabled = NO;
            }
        }
    }
    _pickerIsVisible = !_pickerIsVisible;
}

- (void)pickerCancelClicked
{
    _pickerSelectedValue = @"";
    
    _tableView.scrollEnabled = YES;
    /*所有cell可以点击*/
    for (int i = 0; i <= _dataArray.count-1; i++)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        UITableViewCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
        cell.userInteractionEnabled = YES;
    }
    /*所有按钮可以点击*/
    for (id obj in _toolsBar.subviews) {
        if ([obj isMemberOfClass:[UIButton class]])
        {
            UIButton *button = (UIButton *)obj;
            button.enabled = YES;
        }
    }
    [self hidePickerView];
}

- (void)pickerConfirmClicked
{
    /*请求数据库*/
    NSArray *btnsArray = [NSArray arrayWithObjects:_areaBtn, _typeBtn, _priceBtn, _sortBtn, nil];
    UIButton *button = [btnsArray objectAtIndex:_pickerBtnIndex];
    if (NO == [button.titleLabel.text isEqualToString:_pickerSelectedValue])
    {
        if (_pickerBtnIndex == 0)
        {
            /*区域*/
            
        }else if (_pickerBtnIndex == 1) {
            /*类型*/
            
        }else if (_pickerBtnIndex == 2) {
            /*价格*/
            
        }else {
            /*排序*/
            
        }
    }
    
    _tableView.scrollEnabled = YES;
    /*所有cell可以点击*/
    for (int i = 0; i <= _dataArray.count-1; i++)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        UITableViewCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
        cell.userInteractionEnabled = YES;
    }
    /*所有按钮可以点击*/
    for (id obj in _toolsBar.subviews) {
        if ([obj isMemberOfClass:[UIButton class]])
        {
            UIButton *button = (UIButton *)obj;
            button.enabled = YES;
        }
    }
    [self hidePickerView];
}

#pragma - mark 辅助函数
- (void)showPickerView
{
    [_picker reloadAllComponents];
    [UIView animateWithDuration:0.5 animations:^{
        _selectView.frame = CGRectMake(0, self.view.bounds.size.height-180, kScreenWidth, 180);
    }];
}

- (void)hidePickerView
{
    [UIView animateWithDuration:0.5 animations:^{
        _selectView.frame = CGRectMake(0, self.view.bounds.size.height, kScreenWidth, 180);
    }];
}

#pragma - mark EGO Header
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view
{
    /*下拉触发*/
    NSLog(@"下拉触发");
}
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view
{
    return _isLoading;
}
- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view
{
    return [NSDate date];
}

#pragma - mark EGO Footer
- (void)egoRefreshTableFooterDidTriggerRefresh:(EGORefreshTableFooterView*)view
{
    /*上拉触发*/
    NSLog(@"上拉触发");
}
- (BOOL)egoRefreshTableFooterDataSourceIsLoading:(EGORefreshTableFooterView*)view
{
    return _isLoading;
}
- (NSDate*)egoRefreshTableFooterDataSourceLastUpdated:(EGORefreshTableFooterView*)view
{
    return [NSDate date];
}

#pragma - mark UIScrollView
EGO_UISCROLLVIEW_DELEGATE

#pragma - mark UIPickerView
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    /*一列*/
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSArray *datasArray = [NSArray arrayWithObjects:GET_AREAS_ARR, GET_TYPES_ARR, GET_PRICES_ARR, GET_ORDERS_ARR, nil];
    return [[datasArray objectAtIndex:_pickerBtnIndex] count];
//    if (_pickerBtnIndex == 0)
//    {
//        return GET_AREAS_ARR.count;
//    }else if (_pickerBtnIndex == 1) {
//        return GET_TYPES_ARR.count;
//    }else if (_pickerBtnIndex == 2) {
//        return GET_PRICES_ARR.count;
//    }else {
//        return GET_ORDERS_ARR.count;
//    }
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    /*列宽固定*/
    return kScreenWidth;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    /*行高固定*/
    return 30;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSArray *datasArray = [NSArray arrayWithObjects:GET_AREAS_ARR, GET_TYPES_ARR, GET_PRICES_ARR, GET_ORDERS_ARR, nil];
    return [[datasArray objectAtIndex:_pickerBtnIndex] objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    /*拿到选中的值*/
    if (_pickerBtnIndex == 0)
    {
        /*区域*/
        _pickerSelectedValue = [GET_AREAS_ARR objectAtIndex:row];
    }else if (_pickerBtnIndex == 1) {
        /*类型*/
        _pickerSelectedValue = [GET_TYPES_ARR objectAtIndex:row];
    }else if (_pickerBtnIndex == 2) {
        /*价格*/
        _pickerSelectedValue = [GET_PRICES_ARR objectAtIndex:row];
    }else {
        /*排序*/
        _pickerSelectedValue = [GET_ORDERS_ARR objectAtIndex:row];
    }
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
    return kScreenHeight-30-44-20;
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
