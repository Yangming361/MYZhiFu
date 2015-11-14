//
//  MenuViewController.m
//  SMY-Zhihu
//
//  Created by qianfeng on 15/9/10.
//  Copyright (c) 2015年 ahnu. All rights reserved.
//

//RESideMenu.m 中 _contentViewScaleValue = 1.0f 调整左侧抽屉出来的大小


#import "MenuViewController.h"
#import "RESideMenu.h"
#import "UIViewController+RESideMenu.h"
#import "LoginViewController.h"
#import "ContentListViewController.h"
#import "ConfigViewController.h"
@interface MenuViewController ()<UITableViewDataSource,UITableViewDelegate>
{
  
}
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,copy) NSMutableArray *dataArray;
@property(nonatomic,strong) UIView *headView;
@property(nonatomic,strong) UIView *footView;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self creatTableViewAndLoadData];
    [self configHeadViewAndFooterView];
}

- (void)configHeadViewAndFooterView
{
    CGSize size = [UIScreen mainScreen].bounds.size;
    
    _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width/2, 150)];
    _headView.userInteractionEnabled = YES;
    _headView.backgroundColor = [UIColor clearColor];
    __weak typeof(self) ws = self;
    UIButton *loginButton = [_headView addImageButtonWithFrame:CGRectMake(10, 30, 100, 40) title:@"请登录" image:nil action:^(ZTButton *button) {
        
        LoginViewController *lvc = [[LoginViewController alloc] init];
       
      [ws.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:lvc ]   animated:YES];

        
       [ws.sideMenuViewController hideMenuViewController];
        NSLog(@"进入登陆界面");
        
    }];
    loginButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, -10);
    [loginButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [loginButton setImage:[UIImage imageNamed:@"Dark_Menu_Avatar.png"] forState:UIControlStateNormal];
    loginButton.titleLabel.font = [UIFont systemFontOfSize:15];
    //Dark_Menu_Icon_Collect@2x.png
    //Dark_Menu_Icon_Message@2x.png
    //Dark_Menu_Icon_Setting@2x.png
    
    NSArray *headArray = @[@"收藏",@"消息",@"设置"];
    NSArray *headImages = @[@"Dark_Menu_Icon_Collect.png",@"Dark_Menu_Icon_Message.png",@"Dark_Menu_Icon_Setting.png"];
    double x =20;
    double intervalX = 35;
    double y = 100;
    double w = 20;
    double h =20;
    
    for (int  i=0; i<3; i++) {
        
        UIButton *button = [_headView addImageButtonWithFrame:CGRectMake(x, y, w, h) title:nil image:headImages[i] action:^(ZTButton *button) {
            NSLog(@"tag - %ld",button.tag);
            if (button.tag == 2) {
                ConfigViewController *cvc = [[ConfigViewController alloc] init];
                [ws.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:cvc ]   animated:YES];
                
                
                [ws.sideMenuViewController hideMenuViewController];
                
            }
            
        }];
        button.tag = i;
        
        UILabel *label = [_headView addLabelWithFrame:CGRectMake(x, y+h, 25, 20) title:headArray[i]];
        label.font = [UIFont systemFontOfSize:10];
        label.textColor = [UIColor lightGrayColor];
        
        x+=w+intervalX;
        
    }
    [self.view addSubview: _headView];
    
    //_tableView.tableHeaderView = _headView;
    
    
    //设置尾部视图
    
    _footView = [[UIView alloc] initWithFrame:CGRectMake(0, size.height-60, size.width/2, 60)];
    _footView.userInteractionEnabled = YES;
    _footView.backgroundColor = [UIColor clearColor];
    //Menu_Download@2x.png
    //Menu_Dark@2x.png
    // 和夜间图片
    
    double h_f = 20;
    double w_f = 20;
    NSArray *footImages =@[@"Menu_Download.png",@"Menu_Dark.png"];
   //设置下载按钮图片
    UIButton *downButton = [_footView addImageButtonWithFrame:CGRectMake(20, 5, w_f, h_f) title:nil image:@"Menu_Download.png" action:^(ZTButton *button) {
        
    }];
    
    //设置离线标签
    UILabel *statusLabel = [_footView addLabelWithFrame:CGRectMake(55, 8, 30, h_f) title:@"离线"];
    statusLabel.textColor = [UIColor lightGrayColor];
    statusLabel.font = [UIFont systemFontOfSize:14];
    
    //夜间按钮
    UIButton *nightButton = [_footView addImageButtonWithFrame:CGRectMake(110, 5, 20, 20) title:nil image:@"Menu_Dark.png"
                                     action:^(ZTButton *button) {
                                                            
           
                                    }];
    //设置夜间标签
    UILabel *nightLabel = [_footView addLabelWithFrame:CGRectMake(135, 8, 30, 20) title:@"夜间"];
    nightLabel.textColor = [UIColor lightGrayColor];
    nightLabel.font = [UIFont systemFontOfSize:14];
    
    [self.view addSubview: _footView];
}

- (void)creatTableViewAndLoadData
{
    
    _dataArray = [@[@"首页",@"日常心理学",@"用户推荐日报",@"电影日报",@"不许无聊",@"设计日报",@"大公司日报",@"财经日报",@"互联网安全",@"开始游戏",@"音乐日报",@"动漫日报",@"体育日报"] mutableCopy];
    
    CGSize size = [UIScreen mainScreen].bounds.size;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 150, size.width, size.height-210) style:UITableViewStylePlain];
    
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.opaque = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView = nil;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.bounces = NO;
    [self.view addSubview:_tableView];
    
  
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = _dataArray[indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.imageView.image = [UIImage imageNamed:@"Menu_Follow.png"];
    UIImageView *cellBackView = [[UIImageView alloc] initWithFrame:cell.contentView.frame];
    cellBackView.image = [UIImage imageNamed:@"Dark_Account_Cell_Single.png"];
    cell.selectedBackgroundView = cellBackView;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    cell.backgroundColor = [UIColor blackColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContentListViewController *clvc =  [[ContentListViewController alloc] init];
    
    NSInteger row = indexPath.row;
    
    switch (row) {
        case 0:
            //首页
            clvc.urlString = HomePage_URL;
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc]
                                                                   initWithRootViewController:clvc]  animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 1:
            //日常心理学
            clvc.urlString = UserPsychology_URL;
                  [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:clvc ]   animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 2:
            //用户推荐日报
            clvc.urlString = UserRecommendDaily_URL;
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:clvc ]   animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 3:
            //电影日报
            clvc.urlString = MovieDaily_URL;
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:clvc ]   animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 4:
            //不许无聊
            clvc.urlString = NotBoring_URL;
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:clvc ]   animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 5:
            //设计日报
            clvc.urlString = DesignDaily_URL;
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:clvc ]   animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 6:
            //大公司日报
            clvc.urlString = LargeCompanyDaily_URL;
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:clvc ]   animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 7:
            //财经日报
            clvc.urlString = FinancialDaily_URL;
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:clvc ]   animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 8:
            //互联网安全
            clvc.urlString = InternetSecurity_URL;
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:clvc ]   animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 9:
            //开始游戏
            clvc.urlString = StartGame_URL;
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:clvc ]   animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 10:
            //音乐日报
            clvc.urlString = MusicDaily_URL;
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:clvc ]   animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 11:
            
            //动漫日报
            clvc.urlString = AnimationDaily_URL;
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:clvc ]   animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 12:
            //体育日报
            clvc.urlString = SportsDaily_URL;
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:clvc ]   animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        default:
            break;
    }
    

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
