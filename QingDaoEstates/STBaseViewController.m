//
//  STBaseViewController.m
//  QingDaoEstates
//
//  Created by scott on 13-11-11.
//  Copyright (c) 2013年 scott. All rights reserved.
//

#import "STBaseViewController.h"
#import "STBlockButton.h"

@interface STBaseViewController ()

@end

@implementation STBaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	/*iOS 7*/
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    /*导航栏的titleView,用于自定义*/
    self.navigationItem.titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    /*一律隐藏系统的返回按钮*/
    self.navigationItem.hidesBackButton = YES;
    if (self.navigationController && self.navigationController.viewControllers.count >= 2)
    {
        [self addBackButton];
    }
}

/*添加自定义的返回按钮*/
- (void)addBackButton
{
    STBlockButton *backBtn = [STBlockButton buttonWithType:UIButtonTypeCustom];
    [self.navigationItem.titleView addSubview:backBtn];
    backBtn.frame = CGRectMake(0, (44-32)/2.0f, 47.5, 32.0);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"LPBackBtn.png"] forState:UIControlStateNormal];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"LPBackBtn_sel.png"] forState:UIControlStateHighlighted];
    [backBtn handleEvent:UIControlEventTouchUpInside withBlock:^{
        [self backButtonClicked];
    }];
}

- (void)backButtonClicked
{
    if (self.navigationController && self.navigationController.viewControllers.count >= 2)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
