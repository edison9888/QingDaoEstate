//
//  STResoldHouseViewController.m
//  QingDaoEstates
//
//  Created by scott on 13-11-12.
//  Copyright (c) 2013年 scott. All rights reserved.
//

#import "STResoldHouseViewController.h"
#import "STBlockButton.h"
#import "STDetailWebViewController.h"

@implementation STResoldHouseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	/*标题*/
    SET_TITLE(@"二手房");
    
    /*创建地图按钮和搜索按钮*/
    CREATE_MAP_SEARCH_BUTTONS;
    
    /*列表*/
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, kScreenHeight-64) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CELLID"];
}

#pragma - mark UITableView Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELLID"];
    cell.textLabel.text = @"Hello World";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*推入细节页面*/
    STDetailWebViewController *detail = [[STDetailWebViewController alloc] init];
    [self.navigationController pushViewController:detail animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    sectionView.userInteractionEnabled = YES;
    /*四个按钮的工具条*/
    UIImageView *toolsBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 30)];
    [sectionView addSubview:toolsBar];
    toolsBar.userInteractionEnabled = YES;
    toolsBar.image = [UIImage imageNamed:@"LP_mogu_loupanBg.png"];
    NSArray *btnNames = [NSArray arrayWithObjects:@"区域", @"类型", @"价格", @"排序", nil];
    for (int i = 0; i <= 3; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [toolsBar addSubview:btn];
        btn.frame = CGRectMake(i*80, 0, 80, 30);
        [btn setTitle:[btnNames objectAtIndex:i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, -25, 0, 10);
        [btn setImage:[UIImage imageNamed:@"LP_mogu_angel"] forState:UIControlStateNormal];
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, 60, 0, 0);
        [btn addTarget:self action:@selector(toolsBarBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    /*统计的信息栏*/
    UIImageView *statisticBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 30, self.view.bounds.size.width, 20)];
    [sectionView addSubview:statisticBar];
    statisticBar.backgroundColor = [UIColor redColor];
    return sectionView;
}

#pragma - mark 事件响应
- (void)mapBtnClicked
{
    
}

- (void)searchBtnClicked
{
    
}

- (void)toolsBarBtnClick:(UIButton *)btn
{
    
}
@end
