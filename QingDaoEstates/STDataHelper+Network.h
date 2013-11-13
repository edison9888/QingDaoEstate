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
#define kNotificationHomeFetchNetworkDataTopicNewCompleted @"kNotificationHomeFetchNetworkDataTopicNewCompleted"
#define kNotificationHomeFetchNetworkDataTopicNewFailed @"kNotificationHomeFetchNetworkDataTopicNewFailed"
@interface STDataHelper (Home)
- (void)homeFetchNetworkDataTopicNewStart;
- (void)homeFetchNetworkDataTopicNewCancel;
@end
