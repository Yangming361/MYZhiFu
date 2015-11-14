//
//  DetailModel.h
//  SMY-Zhihu
//
//  Created by qianfeng on 15/9/10.
//  Copyright (c) 2015年 ahnu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailModel :NSObject
@property (nonatomic,copy) NSString *image_source;
@property (nonatomic,copy) NSString *ga_prefix;
@property (nonatomic,copy) NSNumber *identity;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *image;
@property (nonatomic,copy) NSArray *css;
@property (nonatomic,copy) NSNumber *type;
@property (nonatomic,copy) NSString *body;
@property (nonatomic,copy) NSString *share_url;
@property (nonatomic,copy) NSString *js;
@property (nonatomic,copy) NSArray *recommenders;

@property (nonatomic,copy) NSDictionary *theme;



@end
