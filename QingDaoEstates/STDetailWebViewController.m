//
//  STNewHouseDetailViewController.m
//  QingDaoEstates
//
//  Created by scott on 13-11-12.
//  Copyright (c) 2013年 scott. All rights reserved.
//

#import "STDetailWebViewController.h"
#import "STBlockButton.h"
#import "STModelHouse.h"

@interface STDetailWebViewController ()

@end

@implementation STDetailWebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /*标题*/
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((300-170)/2.0f, 0, 170, 44)];
    [self.navigationItem.titleView addSubview:_titleLabel];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont boldSystemFontOfSize:20.0f];
    _titleLabel.textColor = [UIColor whiteColor];
    
    /*返回按钮*/
    [self addBackButton];
    
    /*加入收藏按钮*/
    STBlockButton *addFavBtn = [STBlockButton buttonWithType:UIButtonTypeCustom];
    [self.navigationItem.titleView addSubview:addFavBtn];
    addFavBtn.frame = CGRectMake(235, (44-30)/2.0f, 68, 30);
    [addFavBtn setBackgroundImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
    [addFavBtn setTitle:@"加入收藏" forState:UIControlStateNormal];
    addFavBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [addFavBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addFavBtn.titleLabel.font = [UIFont boldSystemFontOfSize:12];

    /*有可能viewDidLoad的时候webView已经存在了,所以在这里做个判断,保证不会内存泄露*/
    if (nil == _webView)
    {
        /*网页加载器*/
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.bounds.size.height)];
        [self.view addSubview:_webView];
    }
}

- (void)layoutWithHouse:(STModelHouse *)house
{
    /*有可能先运行这个方法才会viewDidLoad,所以在这里做个判断，保证webView的存在*/
    if (nil == _webView)
    {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-44-20)];
        [self.view addSubview:_webView];
    }
    /*刷新标题*/
    _titleLabel.text = house.houseName;
    /*加载网页*/
    NSString *urlString = [NSString stringWithFormat:@"http://house.qingdaonews.com/m/loupan.asp?id=%@&app=1", house.houseNid];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:urlRequest];
}
@end
