//
//  STModelHouse.h
//  QingDaoEstates
//
//  Created by scott on 13-11-13.
//  Copyright (c) 2013年 scott. All rights reserved.
//

/* JSON Key:
 area
 img
 map_x
 map_y
 memo
 money
 name
 nid
 status
 type
 */
#import <Foundation/Foundation.h>

@interface STModelHouse : NSObject
@property (nonatomic, strong) NSString *houseNid;
@property (nonatomic, strong) NSString *houseArea; /*城阳区*/
@property (nonatomic, strong) NSString *houseImg;
@property (nonatomic, strong) NSString *houseMapX;
@property (nonatomic, strong) NSString *houseMapY;
@property (nonatomic, strong) NSString *houseMemo; /*黑龙江路与白沙河路交汇处东侧*/
@property (nonatomic, strong) NSString *houseMoney; /*6000*/
@property (nonatomic, strong) NSString *houseName; /*招商LAVIE公社*/
@property (nonatomic, strong) NSString *houseStatus; /*在售*/
@property (nonatomic, strong) NSString *houseType; /*CLUB会所+LOFT+合院*/
@end
