//
//  STDataHelper+Network.h
//  QingDaoEstates
//
//  Created by scott on 13-11-13.
//  Copyright (c) 2013年 scott. All rights reserved.
//
/*这个类别用于从网络下载数据，存储到数据库中*/

#import "STDataHelper.h"

@interface STDataHelper (Network)

@end

/*首页*/
#define kNotificationHomeFetchNetworkDataCompleted @"kNotificationHomeFetchNetworkDataCompleted"
#define kNotificationHomeFetchNetworkDataFailed @"kNotificationHomeFetchNetworkDataFailed"
@interface STDataHelper (NetworkHome)
- (void)homeFetchNetworkDataStart;
- (void)homeFetchNetworkDataCancel;
@end

/*新房*/
#define kNotificationNewHouseFetchNetworkDataCompleted @"kNotificationNewHouseFetchNetworkDataCompleted"
#define kNotificationNewHouseFetchNetworkDataFailed @"kNotificationNewHouseFetchNetworkDataFailed"
@interface STDataHelper (NetworkNewHouse)
- (void)newHouseFetchNetworkDataStart;
- (void)newHouseFetchNetworkDataCancel;
@end
