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
@interface STNewHouseViewController : STBaseViewController <UITableViewDataSource, UITableViewDelegate, EGORefreshTableHeaderDelegate, EGORefreshTableFooterDelegate, UIPickerViewDataSource, UIPickerViewDelegate>
{
    NSMutableArray *_dataArray;
    
    STBlockButton *_discountBtn;
    STBlockButton *_houseCarBtn;
    
    UIImageView *_toolsBar;
    UIButton *_areaBtn;
    UIButton *_typeBtn;
    UIButton *_priceBtn;
    UIButton *_sortBtn;
    
    UIView *_selectView;
    
    UIPickerView *_picker;
    int _pickerBtnIndex; //0区域,1类型,2价格,3排序
    BOOL _pickerIsVisible;
    UIButton *_pickerCancelBtn;
    UIButton *_pickerConfirmBtn;
    NSString *_pickerSelectedValue;
    
    UILabel *_statisticLabel;
    
    UITableView *_tableView;
    EGORefreshTableHeaderView *_refreshHeaderView;
    EGORefreshTableFooterView *_refreshFooterView;
    BOOL _isLoading;
}
@end
