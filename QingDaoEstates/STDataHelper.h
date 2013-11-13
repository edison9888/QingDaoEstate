//
//  STDataHelper.h
//  QingDaoEstates
//
//  Created by scott on 13-11-13.
//  Copyright (c) 2013年 scott. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STDataHelper : NSObject
{
    NSOperationQueue *_operationQueue;
    /*首页*/
    NSBlockOperation *_homeFetchNetworkDataTopicNewBlockOperation;
}
+ (id)sharedInstance;
@end
