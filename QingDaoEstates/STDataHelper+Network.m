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
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSData *jsonData = [NSData dataWithContentsOfURL:url];
        if (jsonData)
        {
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
            /*存储本地*/
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            [userDefault setObject:jsonDict forKey:@"topicNew"];
            
            STModelHouse *house = [[STModelHouse alloc] init];
            house.houseImg = [jsonDict objectForKey:@"img"];
            house.houseMemo = [jsonDict objectForKey:@"memo"];
            house.houseNid = [jsonDict objectForKey:@"nid"];
            
            STModelTopicNew *topicNew = [[STModelTopicNew alloc] init];
            topicNew.topicNewHouse = house;
            topicNew.topicNewTitle = [jsonDict objectForKey:@"title"];
            /*通知回调*/
            _homeFetchNetworkDataTopicNewBlockOperation = nil;
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationHomeFetchNetworkDataTopicNewCompleted object:topicNew];
        }else {
            /*通知回调*/
            _homeFetchNetworkDataTopicNewBlockOperation = nil;
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationHomeFetchNetworkDataTopicNewFailed object:nil];
        }
    }];
    _homeFetchNetworkDataTopicNewBlockOperation = blockOperation;
    [_operationQueue addOperation:blockOperation];
}

- (void)homeFetchNetworkDataTopicNewCancel
{
    if (!_homeFetchNetworkDataTopicNewBlockOperation.isCancelled)
    {
        [_homeFetchNetworkDataTopicNewBlockOperation cancel];
    }
}
@end