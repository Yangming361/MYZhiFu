//
//  ContentModel.h
//  SMY-Zhihu
//
//  Created by qianfeng on 15/9/9.
//  Copyright (c) 2015年 ahnu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContentModel :NSObject
@property (nonatomic,copy) NSNumber *identity;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSNumber *type;
@property (nonatomic,copy) NSArray *images;
@property (nonatomic,copy) NSString *ga_prefix;
@end

