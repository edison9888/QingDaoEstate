//
//  STHomeViewController.m
//  QingDaoEstates
//
//  Created by scott on 13-11-11.
//  Copyright (c) 2013年 scott. All rights reserved.
//

#import "STHomeViewController.h"
#import "STNewHouseViewController.h"
#import "STResoldHouseViewController.h"
#import "STRentHouseViewController.h"
#import "STSearchHouseViewController.h"
#import "STGroupPurchaseViewController.h"

#import "STDataHelper+Network.h"
#import "STModelTopicNew.h"
#import "UIImageView+WebCache.h"
#import "STModelHouse.h"

@implementation STHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    /*导航栏标题*/
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.bounds.size.width-110)/2.0f, 0, 100, 44)];
    [self.navigationItem.titleView addSubview:titleLabel];
    titleLabel.text = @"青岛房产";
    titleLabel.font = [UIFont boldSystemFontOfSize:20.0f];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    /*最底层背景*/
    UIImageView *bgView = [[UIImageView alloc] init];
    [self.view addSubview:bgView];
    bgView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    bgView.image = [UIImage imageNamed:@"LPHomePageBGround.png"];
    bgView.userInteractionEnabled = YES;
    
    /*头条*/
    UIImageView *headerView = [[UIImageView alloc] init];
    [self.view addSubview:headerView];
    headerView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 142);
    
    _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, (142-60)/2.0f, 80, 60)];
    [headerView addSubview:_headerImageView];
    
    _headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(110+5, (142-60)/2.0f, 180, 15)];
    [headerView addSubview:_headerLabel];
    _headerLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    _headerLabel.numberOfLines = 1;
    _headerLabel.textColor = [UIColor blackColor];
//    _headerLabel.backgroundColor = [UIColor yellowColor];
    
    _headerContentTextView = [[UITextView alloc] initWithFrame:CGRectMake(110, (142-60)/2.0f+25, 200, 50)];
    [headerView addSubview:_headerContentTextView];
    _headerContentTextView.font = [UIFont boldSystemFontOfSize:15.0f];
    _headerContentTextView.showsVerticalScrollIndicator = NO;
    _headerContentTextView.editable = NO;
    _headerContentTextView.textColor = [UIColor whiteColor];
    _headerContentTextView.backgroundColor = [UIColor clearColor];
    
    /*9个按钮*/
    NSArray *row0 = [NSArray arrayWithObjects:@"xinfang.png", @"ershou.png", @"zufang.png", nil];
    NSArray *row1 = [NSArray arrayWithObjects:@"zhaofang.png", @"tuan.png", @"kanfang.png", nil];
    NSArray *row2 = [NSArray arrayWithObjects:@"fabu.png", @"wode.png", @"jsq.png", nil];
    NSArray *total = [NSArray arrayWithObjects:row0, row1, row2, nil];
    float leftSpan = (320-(2*5+3*91))/2.0f;
    float btnSpan = 5.0f;
    for (int i = 0; i <= 2; i++)
    {
        for (int j = 0; j <= 2; j++)
        {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [bgView addSubview:btn];
            btn.frame = CGRectMake(leftSpan+j*(91+btnSpan), 150+i*(79+btnSpan), 91, 79);
            NSString *imageName = [[total objectAtIndex:i] objectAtIndex:j];
            [btn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
            btn.tag = 3*i+j;
            [btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    /*加载头条新闻*/
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    if ([userDefault objectForKey:@"topicNew"])
    {
        /*本地*/
        NSDictionary *topicNewDict = [userDefault objectForKey:@"topicNew"];
        STModelHouse *house = [[STModelHouse alloc] init];
        house.houseImg = [topicNewDict objectForKey:@"img"];
        house.houseMemo = [topicNewDict objectForKey:@"memo"];
        house.houseNid = [topicNewDict objectForKey:@"nid"];
        
        STModelTopicNew *topicNew = [[STModelTopicNew alloc] init];
        topicNew.topicNewHouse = house;
        topicNew.topicNewTitle = [topicNewDict objectForKey:@"title"];
        
        [_headerImageView setImageWithURL:[NSURL URLWithString:topicNew.topicNewHouse.houseImg]];
        _headerLabel.text = topicNew.topicNewTitle;
        _headerContentTextView.text = topicNew.topicNewHouse.houseMemo;
        
    }else {
        /*网络*/
        [[STDataHelper sharedInstance] homeFetchNetworkDataStart];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(homeFetchNetworkDataCompleted:) name:kNotificationHomeFetchNetworkDataCompleted object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(homeFetchNetworkDataFailed:) name:kNotificationHomeFetchNetworkDataFailed object:nil];
    }
}
#pragma - mark 通知回调
- (void)homeFetchNetworkDataCompleted:(NSNotification *)notification
{
    /*更新视图*/
    STModelTopicNew *topicNew = [notification object];
    dispatch_async(dispatch_get_main_queue(), ^{
        [_headerImageView setImageWithURL:[NSURL URLWithString:topicNew.topicNewHouse.houseImg]];
        _headerLabel.text = topicNew.topicNewTitle;
        _headerContentTextView.text = topicNew.topicNewHouse.houseMemo;
    });
}

- (void)homeFetchNetworkDataFailed:(NSNotification *)notification
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"无法连接网络" message:@"请检查网络连接，稍后重试." delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
}

#pragma - mark 事件响应

- (void)buttonClicked:(UIButton *)button
{
    switch (button.tag)
    {
        case 0:
        {
            /*新房*/
            STNewHouseViewController *newHouse = [[STNewHouseViewController alloc] init];
            [self.navigationController pushViewController:newHouse animated:YES];
            break;
        }
        case 1:
        {
            /*二手房*/
            STResoldHouseViewController *resoldHouse = [[STResoldHouseViewController alloc] init];
            [self.navigationController pushViewController:resoldHouse animated:YES];
            break;
        }
        case 2:
        {
            /*租房*/
            STRentHouseViewController *rentHouse = [[STRentHouseViewController alloc] init];
            [self.navigationController pushViewController:rentHouse animated:YES];
            break;
        }
        case 3:
        {
            /*找房源*/
            STSearchHouseViewController *searchHouse = [[STSearchHouseViewController alloc] init];
            [self.navigationController pushViewController:searchHouse animated:YES];
            break;
        }
            
        case 4:
        {
            /*团购*/
            STGroupPurchaseViewController *groupPurchase = [[STGroupPurchaseViewController alloc] init];
            [self.navigationController pushViewController:groupPurchase animated:YES];
            break;
        }
        case 5:
        {
            /*看房车*/
            break;
        }
        case 6:
        {
            /*发布信息*/
            break;
        }
        case 7:
        {
            /*我的*/
            break;
        }
        case 8:
        {
            /*计算器*/
            break;
        }
        default: break;
    }
}

@end
