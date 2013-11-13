//
//  STGroupPurchaseViewController.m
//  QingDaoEstates
//
//  Created by scott on 13-11-13.
//  Copyright (c) 2013年 scott. All rights reserved.
//

#import "STGroupPurchaseViewController.h"

@implementation STGroupPurchaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	/*标题*/
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.bounds.size.width-110)/2.0f, 0, 100, 44)];
    [self.navigationItem.titleView addSubview:titleLabel];
    titleLabel.text = @"团购";
    titleLabel.font = [UIFont boldSystemFontOfSize:20.0f];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
}

@end
