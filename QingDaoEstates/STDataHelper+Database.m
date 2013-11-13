//
//  STDataHelper+Database.m
//  QingDaoEstates
//
//  Created by scott on 13-11-13.
//  Copyright (c) 2013年 scott. All rights reserved.
//

#import "STDataHelper+Database.h"
#import "FMDatabase.h"
#import "STModelHouse.h"

@implementation STDataHelper (Database)
- (void)insertHouse:(NSDictionary *)dict
{
    NSString *cacheDBPath = [NSString stringWithFormat:@"%@/Library/Caches/SQLite3.db", NSHomeDirectory()];
    FMDatabase *database = [FMDatabase databaseWithPath:cacheDBPath];
    if ([database open])
    {
        NSString *nid = [dict objectForKey:@"nid"];
        NSString *area = [dict objectForKey:@"area"];
        NSString *img = [dict objectForKey:@"img"];
        NSString *map_x = [dict objectForKey:@"map_x"];
        NSString *map_y = [dict objectForKey:@"map_y"];
        NSString *memo = [dict objectForKey:@"memo"];
        NSString *money = [dict objectForKey:@"money"];
        NSString *name = [dict objectForKey:@"name"];
        NSString *status = [dict objectForKey:@"status"];
        NSString *type = [dict objectForKey:@"type"];
        
        BOOL isExist = NO;
        FMResultSet *resultSet = [database executeQuery:@"select * from House where nid=?;", nid];
        while ([resultSet next])
        {
            isExist = YES;
            break;
        }
        if (isExist)
        {
            /*更新*/
            
        }else {
            /*插入*/
            [database executeUpdate:@"insert into House values(?,?,?,?,?,?,?,?,?,?);", nid, area, img, map_x, map_y, memo, money, name, status, type];
        }
    }
    [database close];
}

- (void)updateHouse:(NSDictionary *)dict
{
    NSString *cacheDBPath = [NSString stringWithFormat:@"%@/Library/Caches/SQLite3.db", NSHomeDirectory()];
    FMDatabase *database = [FMDatabase databaseWithPath:cacheDBPath];
    if ([database open])
    {
        NSString *nid = [dict objectForKey:@"nid"];
        NSString *area = [dict objectForKey:@"area"];
        NSString *img = [dict objectForKey:@"img"];
        NSString *map_x = [dict objectForKey:@"map_x"];
        NSString *map_y = [dict objectForKey:@"map_y"];
        NSString *memo = [dict objectForKey:@"memo"];
        NSString *money = [dict objectForKey:@"money"];
        NSString *name = [dict objectForKey:@"name"];
        NSString *status = [dict objectForKey:@"status"];
        NSString *type = [dict objectForKey:@"type"];
        
        BOOL isExist = NO;
        FMResultSet *resultSet = [database executeQuery:@"select * from House where nid=?;", nid];
        while ([resultSet next])
        {
            isExist = YES;
            break;
        }
        if (isExist)
        {
            /*更新*/
            [database executeUpdate:@"update from House set area=?,img=?,map_x=?,map_y=?,memo=?,money=?,name=?,status=?,type=? where nid=?;", area, img, map_x, map_y, memo, money, name, status, type, nid];
        }else {
            /*插入*/
            [database executeUpdate:@"insert into House values(?,?,?,?,?,?,?,?,?,?);", nid, area, img, map_x, map_y, memo, money, name, status, type];
        }
    }
    [database close];
}
@end

@implementation STDataHelper (DatabaseNewHouse)

- (NSMutableArray *)newHouseFetchDatabaseData
{
    NSString *cacheDBPath = [NSString stringWithFormat:@"%@/Library/Caches/SQLite3.db", NSHomeDirectory()];
    FMDatabase *database = [FMDatabase databaseWithPath:cacheDBPath];
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    if ([database open])
    {
        FMResultSet *resultSet = [database executeQuery:@"select * from House;"];
        while ([resultSet next])
        {
            NSString *nid = [resultSet stringForColumn:@"nid"];
            NSString *area = [resultSet stringForColumn:@"area"];
            NSString *img = [resultSet stringForColumn:@"img"];
            NSString *map_x = [resultSet stringForColumn:@"map_x"];
            NSString *map_y = [resultSet stringForColumn:@"map_y"];
            NSString *memo = [resultSet stringForColumn:@"memo"];
            NSString *money = [resultSet stringForColumn:@"money"];
            NSString *name = [resultSet stringForColumn:@"name"];
            NSString *status = [resultSet stringForColumn:@"status"];
            NSString *type = [resultSet stringForColumn:@"type"];
            
            STModelHouse *house = [[STModelHouse alloc] init];
            house.houseNid = nid;
            house.houseArea = area;
            house.houseImg = img;
            house.houseMapX = map_x;
            house.houseMapY = map_y;
            house.houseMemo = memo;
            house.houseMoney = money;
            house.houseName = name;
            house.houseStatus = status;
            house.houseType = type;
            
            [resultArray addObject:house];
        }
    }
    [database close];
    if (0 == resultArray.count)
    {
        return nil;
    }
    return resultArray;
}
@end