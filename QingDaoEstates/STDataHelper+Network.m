//
//  STDataHelper+Network.m
//  QingDaoEstates
//
//  Created by scott on 13-11-13.
//  Copyright (c) 2013年 scott. All rights reserved.
//

#import "STDataHelper+Network.h"
#import "STModelTopicNew.h"
#import "STModelHouse.h"

@implementation STDataHelper (Network)

@end

@implementation STDataHelper (Home)
- (void)homeFetchNetworkDataTopicNewStart
{
    NSString *urlString = @"http://yezhu.qingdaonews.com/htouch/topic_news.php?cate=43133";
    NSURL *url = [NSURL URLWithString:urlString];
    
    [self homeFetchNetworkDataTopicNewCancel];
    _homeFetchNetworkDataTopicNewBlockOperation = [NSBlockOperation blockOperationWithBlock:^{
        
    }];
}

- (void)homeFetchNetworkDataTopicNewCancel
{
    if (!_homeFetchNetworkDataTopicNewBlockOperation.isCancelled)
    {
        [_homeFetchNetworkDataTopicNewBlockOperation cancel];
    }
}
@end