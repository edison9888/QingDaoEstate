//
//  RayButton.h
//  UIButton+Block
//
//  Created by pang on 13-10-20.
//  Copyright (c) 2013年 pang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ActionBlock)(void);

@interface STBlockButton : UIButton
{
    ActionBlock _actionBlock;
}
- (void)handleEvent:(UIControlEvents)event withBlock:(ActionBlock)actionBlock;
@end
