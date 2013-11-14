//
//  STNewHouseViewController.h
//  QingDaoEstates
//
//  Created by scott on 13-11-12.
//  Copyright (c) 2013年 scott. All rights reserved.
//

#import "STBaseViewController.h"
#import "EGORefreshTableHeaderView.h"
#import "EGORefreshTableFooterView.h"

@class STBlockButton;
@interface STNewHouseViewController : STBaseViewController <UITableViewDataSource, UITableViewDelegate, EGORefreshTableHeaderDelegate, EGORefreshTableFooterDelegate>
{
    NSMutableArray *_dataArray;
    
    STBlockButton *_discountBtn;
    STBlockButton *_houseCarBtn;
    UIImageView *_toolsBar;
    UILabel *_statisticLabel;
    
    UITableView *_tableView;
    EGORefreshTableHeaderView *_refreshHeaderView;
    EGORefreshTableFooterView *_refreshFooterView;
    BOOL _isLoading;
}
@end
