//
//  STNewHouseDetailViewController.h
//  QingDaoEstates
//
//  Created by scott on 13-11-12.
//  Copyright (c) 2013年 scott. All rights reserved.
//

#import "STBaseViewController.h"

@class STModelHouse;
@interface STDetailWebViewController : STBaseViewController
{
    UIWebView *_webView;
    UILabel *_titleLabel;
}
- (void)layoutWithHouse:(STModelHouse *)house;
@end
