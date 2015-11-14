//
//  ContentListViewController.m
//  SMY-Zhihu
//
//  Created by qianfeng on 15/9/9.
//  Copyright (c) 2015年 ahnu. All rights reserved.
//
#define ImageHight 180.0f
#import "ContentListViewController.h"
#import "ZJScreenAdaptationMacro.h"
#import "ZJLoopScrollView.h"
#import "DetailViewController.h"
#import "ContentModel.h"
#import "ContentCell.h"
@interface ContentListViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    
    UIImageView *_headView;
    ZJLoopScrollView *_loopScrollView;
}
@property(copy,nonatomic) NSMutableArray *dataArray;
@property(strong,nonatomic) UITableView *tableView;



@end

@implementation ContentListViewController

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.toolbar.hidden =YES;
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.toolbar.hidden =NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _dataArray = [[NSMutableArray alloc] init];
    
    
    [self creatTableView];
    
    
    [self downLoadData];
    //[self configHeadView];
    
    [self configLoopScrollView];
}

- (void)configLoopScrollView
{
    double w =self.view.bounds.size.width;
    double h =180;
    _headView =[[UIImageView alloc] init ];//WithFrame:CGRectMake(0, 0, self.view.bounds.size.width, ImageHight)];
    _headView.userInteractionEnabled = YES;
    //_headView.image = [UIImage imageNamed:@"xin.jpg"];
    _headView.backgroundColor =[UIColor redColor];

   
    _loopScrollView = [[ZJLoopScrollView alloc] init];
   
    
    
    //设置属性
    _loopScrollView.pageCount = 6;
    _loopScrollView.autoScroll = YES;
    _loopScrollView.showPageControl = YES;
    [_loopScrollView setClickAction:^(UIImageView *imageView, int index) {
        NSLog(@"index = %d",index);
    }];
    
     _loopScrollView.frame = CGRectMake(0, 0, self.view.bounds.size.width, ImageHight);//
    _headView.frame = CGRectMake(0, -ImageHight+20, self.view.frame.size.width, ImageHight);
    _headView.contentMode = UIViewContentModeScaleAspectFill;//重点（不设置那将只会被纵向拉伸）
    self.tableView.contentInset = UIEdgeInsetsMake(ImageHight, 0, 0, 0);

    _headView.autoresizesSubviews = YES;
    
     [_headView addSubview:_loopScrollView];
    
    
    //设置home图标
    __weak typeof(self) ws = self;
    UIButton *iconButton = [_headView addImageButtonWithFrame:CGRectMake(0, 0, 80, 60)  title:nil image:@"iOS6_Home_Icon_Menu_G.png" action:^(ZTButton *button) {
        
        NSLog(@"button clicked");
        //点击图标按钮将左侧抽屉视图拉出来
        [ws performSelector:@selector(presentLeftMenuViewController:) withObject:ws];
    }];
   
    
    [_tableView addSubview:_headView];
    
   //_tableView.tableHeaderView = _headView;
   
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if(scrollView==_tableView)
    {
    CGFloat y = scrollView.contentOffset.y;//根据实际选择加不加上NavigationBarHight（44、64 或者没有导航条）
    if (y < -ImageHight) {
        CGRect frame = _headView.frame;
        frame.origin.y = y;
        frame.size.height =  -y;//contentMode = UIViewContentModeScaleAspectFill时，高度改变宽度也跟着改变
        _headView.frame = frame;
       // _loopScrollView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        //_loopScrollView.scrollView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
       
        for (int i =0; i<_loopScrollView.scrollView.subviews.count; i++) {
            UIView *view = _loopScrollView.scrollView.subviews[i];
            //view.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        }
    }
    }
}

- (void)refreshLoopScrollView
{
    
    for (int i=0; i<6; i++) {
        
        ContentModel *model = _dataArray[i];
        NSString *urlString = [model.images firstObject];
        [_loopScrollView setImageWithUrlString:urlString atIndex:i];
    }
}




- (void)downLoadData
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:_urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *array = dict[@"stories"];
        
        for (NSDictionary *contentDict in array) {
            
            ContentModel *model = [[ContentModel alloc] init];
            [model setValuesForKeysWithDictionary:contentDict];
            model.identity = contentDict[@"id"];
            //NSArray *array = contentDict[@"images"];
           // model.images = array;
            
            [_dataArray addObject:model];
            
        }
        
        [_tableView reloadData];
        
        //当数据下载之后，刷新顶部轮动视图
        [self refreshLoopScrollView];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}



- (void)creatTableView
{
    _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource =self;
        [self.view addSubview:_tableView];
    
   // [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [_tableView registerNib:[UINib nibWithNibName:@"ContentCell" bundle:nil] forCellReuseIdentifier:@"cell"];
   
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    ContentModel *model = _dataArray[indexPath.row];
    cell.titleLabel.text = model.title;
    if([model.images firstObject])
    {
        [cell.iconImageView setImageWithURL:[NSURL URLWithString:[model.images firstObject]]];
    }
    
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return heightEx(100) ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    DetailViewController *dvc =[[DetailViewController alloc] init];
    
    dvc.model = _dataArray[indexPath.row];
    [self.navigationController pushViewController:dvc animated:YES];
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
