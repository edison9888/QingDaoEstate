//
//  STSearchHouseViewController.m
//  QingDaoEstates
//
//  Created by scott on 13-11-12.
//  Copyright (c) 2013年 scott. All rights reserved.
//

#import "STSearchHouseViewController.h"
#import "STBlockButton.h"

@interface STSearchHouseViewController ()

@end

@implementation STSearchHouseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	/*标题*/
    SET_TITLE(@"新房搜索");
    
    /*搜索记录按钮*/
    STBlockButton *searchHistoryBtn = [STBlockButton buttonWithType:UIButtonTypeCustom];
    [self.navigationItem.titleView addSubview:searchHistoryBtn];
    searchHistoryBtn.frame = CGRectMake(235, (44-30)/2.0f, 68, 30);
    [searchHistoryBtn setBackgroundImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
    [searchHistoryBtn setTitle:@"搜索记录" forState:UIControlStateNormal];
    searchHistoryBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [searchHistoryBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    searchHistoryBtn.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    /*3个按钮的工具条*/
    _toolsBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    [self.view addSubview:_toolsBar];
    _toolsBar.userInteractionEnabled = YES;
    NSArray *btnNames = [NSArray arrayWithObjects:@"新房", @"二手房", @"租房", nil];
    for (int i = 0; i <= 2; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_toolsBar addSubview:btn];
        btn.frame = CGRectMake(i*kScreenWidth/3.0f, 0, kScreenWidth/3.0f, 44);
        [btn setBackgroundImage:[UIImage imageNamed:@"LPcollectbutton.png"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"LPcollectbuttonanxia.png"] forState:UIControlStateSelected];
        btn.tag = i;
        [btn addTarget:self action:@selector(toolsBarBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:[btnNames objectAtIndex:i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:20.0f];
        if (0 == i)
        {
            btn.selected = YES;
        }
    }
    /*搜索框*/
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 44, kScreenWidth, 44)];
    [self.view addSubview:searchBar];
    searchBar.placeholder = @"请输入楼盘名称地址等关键字";
    /*底部搜索按钮*/
    UIView *bottomSearchView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-64-44, kScreenWidth, 44)];
    [self.view addSubview:bottomSearchView];
    bottomSearchView.backgroundColor = [UIColor redColor];
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bottomSearchView addSubview:searchBtn];
    searchBtn.frame = CGRectMake((kScreenWidth-300)/2.0f, (44-28)/2.0f, 300, 28);
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"btn_baoming.png"] forState:UIControlStateNormal];
    [searchBtn setTitle:@"搜      索" forState:UIControlStateNormal];
    searchBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20.0f];
}
#pragma - mark 事件响应
- (void)toolsBarBtnClick:(UIButton *)btn
{
    /*设置选中状态，取消其他按钮的选中状态*/
    btn.selected = YES;
    for (id obj in _toolsBar.subviews) {
        if ([obj isMemberOfClass:[UIButton class]] && obj != btn)
        {
            ((UIButton *)obj).selected = NO;
        }
    }
    switch (btn.tag)
    {
        case 0:
        {
            /*新房*/
            break;
        }
        case 1:
        {
            /*二手房*/
            break;
        }
        case 2:
        {
            /*租房*/
            break;
        }
        default: break;
    }
}

@end
