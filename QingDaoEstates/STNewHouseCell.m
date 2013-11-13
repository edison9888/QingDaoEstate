//
//  STNewHouseCell.m
//  QingDaoEstates
//
//  Created by scott on 13-11-13.
//  Copyright (c) 2013年 scott. All rights reserved.
//

#import "STNewHouseCell.h"
#import "UIImageView+WebCache.h"
#import "STModelHouse.h"

@implementation STNewHouseCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _photoView = [[UIImageView alloc] init];
        _titleLabel = [[UILabel alloc] init]; //招商LAVIE公社
        _statusLabel = [[UILabel alloc] init]; //在售
        _areaLabel = [[UILabel alloc] init]; //城阳区
        _priceLabel = [[UILabel alloc] init]; //6000元/平
        _locationLabel = [[UILabel alloc] init]; //黑龙江路与白沙河路
        _typeLabel = [[UILabel alloc] init]; //CLUB会所+LOFT+合院
        
        [self.contentView addSubview:_photoView];
        [self.contentView addSubview:_titleLabel];
        [self.contentView addSubview:_statusLabel];
        [self.contentView addSubview:_areaLabel];
        [self.contentView addSubview:_priceLabel];
        [self.contentView addSubview:_locationLabel];
        [self.contentView addSubview:_typeLabel];
    }
    return self;
}

- (void)layoutWithHouse:(STModelHouse *)house
{
//     @property (nonatomic, strong) NSString *houseNid;
//     @property (nonatomic, strong) NSString *houseArea; /*城阳区*/
//    @property (nonatomic, strong) NSString *houseImg;
//    @property (nonatomic, strong) NSString *houseMapX;
//    @property (nonatomic, strong) NSString *houseMapY;
//    @property (nonatomic, strong) NSString *houseMemo; /*黑龙江路与白沙河路交汇处东侧*/
//    @property (nonatomic, strong) NSString *houseMoney; /*6000*/
//    @property (nonatomic, strong) NSString *houseName; /*招商LAVIE公社*/
//    @property (nonatomic, strong) NSString *houseStatus; /*在售*/
//    @property (nonatomic, strong) NSString *houseType; /*CLUB会所+LOFT+合院*/
    
//    _photoView = [[UIImageView alloc] init];
//    _titleLabel = [[UILabel alloc] init]; //招商LAVIE公社
//    _statusLabel = [[UILabel alloc] init]; //在售
//    _blockLabel = [[UILabel alloc] init]; //城阳区
//    _priceLabel = [[UILabel alloc] init]; //6000元/平
//    _locationLabel = [[UILabel alloc] init]; //黑龙江路与白沙河路
//    _typeLabel = [[UILabel alloc] init]; //CLUB会所+LOFT+合院
    
    _photoView.frame = CGRectMake(5, 5, 90, 85);
    [_photoView setImageWithURL:[NSURL URLWithString:house.houseImg]];
    
    _titleLabel.frame = CGRectMake(100, 5, 165, 17);
    _titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.numberOfLines = 1;
    _titleLabel.text = house.houseName;
    _titleLabel.backgroundColor = [UIColor cyanColor];
    
    _statusLabel.frame = CGRectMake(270, 5, 45, 17);
    _statusLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    _statusLabel.textColor = [UIColor blackColor];
    _statusLabel.numberOfLines = 1;
    _statusLabel.text = house.houseStatus;
    _statusLabel.backgroundColor = [UIColor blueColor];
    
    _areaLabel.frame = CGRectMake(100, 27, 105, 17);
    _areaLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    _areaLabel.textColor = [UIColor blackColor];
    _areaLabel.numberOfLines = 1;
    _areaLabel.text = house.houseArea;
    _areaLabel.backgroundColor = [UIColor redColor];
    
    _priceLabel.frame = CGRectMake(210, 27, 105, 17);
    _priceLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    _priceLabel.textColor = [UIColor blackColor];
    _priceLabel.numberOfLines = 1;
    _priceLabel.textAlignment = NSTextAlignmentRight;
    if ([house.houseMoney isEqualToString:@"0"])
    {
        _priceLabel.text = @"待定";
    }else {
        _priceLabel.text = [NSString stringWithFormat:@"%@ 元/平", house.houseMoney];
    }
    _priceLabel.backgroundColor = [UIColor orangeColor];
    
    _locationLabel.frame = CGRectMake(100, 49, 215, 17);
    _locationLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    _locationLabel.textColor = [UIColor blackColor];
    _locationLabel.numberOfLines = 1;
    _locationLabel.text = house.houseMemo;
    _locationLabel.backgroundColor = [UIColor yellowColor];
    
    _typeLabel.frame = CGRectMake(100, 49+17+5, 215, 17);
    _typeLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    _typeLabel.textColor = [UIColor blackColor];
    _typeLabel.numberOfLines = 1;
    _typeLabel.text = house.houseType;
    _typeLabel.backgroundColor = [UIColor yellowColor];
}

+ (float)cellHeightWithHouse:(STModelHouse *)house
{
    return 95;
}

@end
