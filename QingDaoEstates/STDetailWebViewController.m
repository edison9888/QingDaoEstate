//
//  STNewHouseDetailViewController.m
//  QingDaoEstates
//
//  Created by scott on 13-11-12.
//  Copyright (c) 2013年 scott. All rights reserved.
//

#import "STDetailWebViewController.h"
#import "STBlockButton.h"

@interface STDetailWebViewController ()

@end

@implementation STDetailWebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /*标题*/
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((300-170)/2.0f, 0, 170, 44)];
    [self.navigationItem.titleView addSubview:titleLabel];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:20.0f];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"招商LAVIE公社";
    
    /*加入收藏按钮*/
    STBlockButton *addFavBtn = [STBlockButton buttonWithType:UIButtonTypeCustom];
    [self.navigationItem.titleView addSubview:addFavBtn];
    addFavBtn.frame = CGRectMake(235, (44-30)/2.0f, 68, 30);
    [addFavBtn setBackgroundImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
    [addFavBtn setTitle:@"加入收藏" forState:UIControlStateNormal];
    addFavBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [addFavBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addFavBtn.titleLabel.font = [UIFont boldSystemFontOfSize:12];

    /*webView*/
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.bounds.size.height)];
    [self.view addSubview:webView];
    NSString *urlString = [NSString stringWithFormat:@""];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [webView loadRequest:urlRequest];
}

@end
