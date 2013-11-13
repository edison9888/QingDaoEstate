//
//  RayButton.m
//  UIButton+Block
//
//  Created by pang on 13-10-20.
//  Copyright (c) 2013年 pang. All rights reserved.
//

#import "STBlockButton.h"

@implementation STBlockButton

- (void)handleEvent:(UIControlEvents)event withBlock:(ActionBlock)actionBlock
{
    _actionBlock = Block_copy(actionBlock);
    [self addTarget:self action:@selector(callActionBlock) forControlEvents:event];
}

- (void)callActionBlock
{
    _actionBlock();
}

- (void)dealloc
{
    Block_release(_actionBlock);
    [super dealloc];
}

@end
