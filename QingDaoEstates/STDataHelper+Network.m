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
#import "STDataHelper+Database.h"

@implementation STDataHelper (Network)

@end

/*首页*/
@implementation STDataHelper (NetworkHome)
- (void)homeFetchNetworkDataStart
{
    NSString *urlString = @"http://yezhu.qingdaonews.com/htouch/topic_news.php?cate=43133";
    NSURL *url = [NSURL URLWithString:urlString];
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSData *jsonData = [NSData dataWithContentsOfURL:url];
        if (jsonData)
        {
            NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
            /*存储本地*/
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            [userDefault setObject:rootDict forKey:@"topicNew"];
            
            STModelHouse *house = [[STModelHouse alloc] init];
            house.houseImg = [rootDict objectForKey:@"img"];
            house.houseMemo = [rootDict objectForKey:@"memo"];
            house.houseNid = [rootDict objectForKey:@"nid"];
            
            STModelTopicNew *topicNew = [[STModelTopicNew alloc] init];
            topicNew.topicNewHouse = house;
            topicNew.topicNewTitle = [rootDict objectForKey:@"title"];
            /*通知回调*/
            _homeFetchNetworkDataBlockOperation = nil;
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationHomeFetchNetworkDataCompleted object:topicNew];
        }else {
            /*通知回调*/
            _homeFetchNetworkDataBlockOperation = nil;
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationHomeFetchNetworkDataFailed object:nil];
        }
    }];
    _homeFetchNetworkDataBlockOperation = blockOperation;
    [_operationQueue addOperation:blockOperation];
}

- (void)homeFetchNetworkDataCancel
{
    if (_homeFetchNetworkDataBlockOperation)
    {
        [_homeFetchNetworkDataBlockOperation cancel];
    }
}
@end

/*新房*/
@implementation STDataHelper (NetworkNewHouse)
- (void)newHouseFetchNetworkDataStart
{
    /*
     http://yezhu.qingdaonews.com/htouch/news_house_list.php?type=&page=1&maxmoney=99999999&area=%CA%D0%B1%B1%C7%F8&characteristic=0&decoration=0&key=&minmoney=0&opentime=0&seq=0
     */
    NSString *urlString = @"http://yezhu.qingdaonews.com/htouch/news_house_list.php?type=&page=1&maxmoney=999999&area=&characteristic=0&decoration=0&key=&minmoney=0&opentime=0&seq=0";
    NSURL *url = [NSURL URLWithString:urlString];
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSData *jsonData = [NSData dataWithContentsOfURL:url];
        if (jsonData)
        {
            NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
            /*
             打折优惠4  tour_num
             看房车2  showings_num
             共找到1627条信息 total_num
             */
            NSArray *List = [rootDict objectForKey:@"List"];
            NSString *tour_num = [rootDict objectForKey:@"tour_num"];
            NSString *showings_num = [rootDict objectForKey:@"showings_num"];
            NSString *total_num = [rootDict objectForKey:@"total_num"];
            
            NSDictionary *updateDict = [NSDictionary dictionaryWithObjects:@[tour_num, showings_num, total_num] forKeys:@[@"tour_num", @"showings_num", @"total_num"]];
            /*存储本地*/
            for (NSDictionary *dict in List) {
                [self insertHouse:dict];
            }
            /*通知回调*/
            _newHouseFetchNetworkDataBlockOperation = nil;
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNewHouseFetchNetworkDataCompleted object:updateDict];
        }else {
            /*通知回调*/
            _newHouseFetchNetworkDataBlockOperation = nil;
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNewHouseFetchNetworkDataFailed object:nil];
        }
    }];
    _newHouseFetchNetworkDataBlockOperation = blockOperation;
    [_operationQueue addOperation:blockOperation];
}

- (void)newHouseFetchNetworkDataCancel
{
    if (_newHouseFetchNetworkDataBlockOperation)
    {
        [_newHouseFetchNetworkDataBlockOperation cancel];
    }
}
@end