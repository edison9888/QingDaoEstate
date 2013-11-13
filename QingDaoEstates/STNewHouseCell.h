//
//  STNewHouseCell.h
//  QingDaoEstates
//
//  Created by scott on 13-11-13.
//  Copyright (c) 2013年 scott. All rights reserved.
//

#import <UIKit/UIKit.h>

@class STModelHouse;
@interface STNewHouseCell : UITableViewCell
{
    UIImageView *_photoView;
    UILabel *_titleLabel;
    UILabel *_statusLabel;
    UILabel *_areaLabel;
    UILabel *_priceLabel;
    UILabel *_locationLabel;
    UILabel *_typeLabel;
}
+ (float)cellHeightWithHouse:(STModelHouse *)house;
- (void)layoutWithHouse:(STModelHouse *)house;
@end
