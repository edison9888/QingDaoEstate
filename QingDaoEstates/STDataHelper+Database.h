//
//  STDataHelper+Database.h
//  QingDaoEstates
//
//  Created by scott on 13-11-13.
//  Copyright (c) 2013年 scott. All rights reserved.
//
/*这个类别用于从数据库中取出数据，包装好*/

#import "STDataHelper.h"

@interface STDataHelper (Database)
- (void)insertHouse:(NSDictionary *)dict;
- (void)updateHouse:(NSDictionary *)dict;
@end

/*新房*/
@interface STDataHelper (DatabaseNewHouse)
- (NSMutableArray *)newHouseFetchDatabaseData;
@end