//
//  ConfigViewController.m
//  SMY-Zhihu
//
//  Created by qianfeng on 15/9/11.
//  Copyright (c) 2015年 ahnu. All rights reserved.
//

#import "ConfigViewController.h"

@interface ConfigViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_dataArray;
    UITableView *_tableView;
    NSArray *_sectionTitle;
}

@end

@implementation ConfigViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _dataArray = [[NSMutableArray alloc] init];
    
    [self configNavigation];
    [self loadData];
    
    [self creatTableView];
    
    
    
}

- (void)configNavigation
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Dark_Setting_Bg3_Top.png"] forBarMetrics:UIBarMetricsDefault];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0,0, 50, 50);
    [button setBackgroundImage:[UIImage imageNamed:@"Back.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(presentLeftMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem =[[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.navigationItem.leftBarButtonItem = backItem;
    
    self.title = @"设置";
    
}

- (void)loadData
{
    
    NSArray *array1 = @[@"我的资料",@"自动离线下载"];
    NSArray *array2 = @[@"移动网络不下载图片",@"大字号",@"消息推送",@"点评分享到微博",@"去好评",@"去吐槽"];
    NSArray*array3 = @[@"清除缓存"];
    
    _sectionTitle = @[@"",@"",@"仅WiFi下可用，自动下载最新内容",@"",@"",@""];
    
    for (int i=0 ; i<array1.count; i++) {
        
        NSMutableArray *subArray = [[NSMutableArray alloc] init];
        [subArray addObject:array1[i]];
        
        [_dataArray addObject:subArray];
        
    }
    
    for (int i =0; i<array2.count; i=i+2) {
        
        NSMutableArray *subArray = [[NSMutableArray alloc] init];
        [subArray addObject:array2[i]];
        [subArray addObject:array2[i+1]];
        
        [_dataArray addObject:subArray];
    }
    for (int i =0; i<array3.count; i++) {
        NSMutableArray *subArray = [[NSMutableArray alloc] init];
        [subArray addObject:array3[i]];
        
        [_dataArray addObject:subArray];
        
    }
    
    NSLog(@"dataArray ---%ld",_dataArray.count);
    
}
- (void)creatTableView
{
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource=self;
    
    _tableView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *subArray = _dataArray[section];
    return subArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    NSArray *subArray = _dataArray[indexPath.section];
    
    cell.textLabel.text = subArray[indexPath.row];
    
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return _sectionTitle[section];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
