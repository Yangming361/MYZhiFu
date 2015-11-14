//
//  LoginViewController.m
//  SMY-Zhihu
//
//  Created by qianfeng on 15/9/9.
//  Copyright (c) 2015年 ahnu. All rights reserved.
//

#import "LoginViewController.h"
#import "UMSocial.h"
#import "RESideMenu.h"
#import "ZJScreenAdaptationMacro.h"
#import "ZTQuickControl.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    [self creatUI];
    
    [self setNavigation];
}

- (void)setNavigation
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"News_Navigation_Dividing.png"] forBarMetrics:UIBarMetricsDefault];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0,0, 50, 50);
    [button setBackgroundImage:[UIImage imageNamed:@"Back.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(presentLeftMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem =[[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.navigationItem.leftBarButtonItem = backItem;
    
    self.title = @"登录";
}

- (void)dealBack:(UIButton *)button
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    NSLog(@"返回------");
}
- (void)creatUI
{
     UIImageView *backView = [self.view addImageViewWithFrame:self.view.bounds image:@"Login_Background.png"];
    

    UIButton *titleButton =[backView addImageButtonWithFrame:CGRectMake(50, 100, 200, 80) title:@"知乎日报"image:nil action:^(ZTButton *button) {
        
        NSLog(@"点击了之乎日报");
           }];
   
    //@"AppIcon29x29.png"
    [titleButton setImage:[UIImage imageNamed:@"AppIcon29x29.png"] forState:UIControlStateNormal];
    titleButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    
    
    UILabel *hintLabel = [self.view addLabelWithFrame:CGRectMake(120, 300, 200, 40) title:@"使用微博登陆"];
    hintLabel.font = [UIFont boldSystemFontOfSize:14];
    hintLabel.textColor = [UIColor whiteColor];
    
    
    //sinaLoginButton
    __weak typeof(self) ws =self;
    UIButton *sinaButton = [self.view addImageButtonWithFrame:CGRectMake(40, 350, 240, 40) title:@"新浪微博" image:nil action:^(ZTButton *button) {
        
        [ws sinaThirdLogin];
        
    }];
    [sinaButton setBackgroundImage:[UIImage imageNamed:@"Login_Button_Sina.png"] forState:UIControlStateNormal];
    [sinaButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    sinaButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    
    //[sinaButton addTarget:self action:@selector(dealSinaLogin:) forControlEvents:UIControlEventTouchUpInside];
    
    //tencentLoginButton
    
    UIButton *tencentButton = [self.view addImageButtonWithFrame:CGRectMake(40, 410, 240, 40) title:@"腾讯微博" image:nil action:^(ZTButton *button) {
        
        [self tencentThirdLogin];
    }];
    [tencentButton setBackgroundImage:[UIImage imageNamed:@"Login_Button_Tencent.png"] forState:UIControlStateNormal];
    [tencentButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    tencentButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    //[tencentButton addTarget:self action:@selector(dealTencentLogin:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *hintLabel2 = [self.view addLabelWithFrame:CGRectMake(50, self.view.height-50, 240, 40) title:@"知乎日报不会未经同意通过你的微博账号发布任何信息"];
    hintLabel2.textColor = [UIColor cyanColor];
    hintLabel2.font = [UIFont systemFontOfSize:10];
}

- (void)tencentThirdLogin
{
    __weak typeof (self) weakSelf = self;
    
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToTencent];
    
    snsPlatform.loginClickHandler(weakSelf,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            //A.显示基本信息
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
            
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            
            //B.显示用户信息
            //获取accestoken以及新浪用户信息，得到的数据在回调Block对象形参respone的data属性
            [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToSina  completion:^(UMSocialResponseEntity *response){
                
                NSLog(@"SnsInformation is %@",response.data);
                
            }];
           
        }});

}
//"access_token" = "2.00EPCTEG03t9ZI784126b374bjUCGC";
//description = "";
//"favourites_count" = 0;
//"followers_count" = 1;
//"friends_count" = 23;
//gender = 1;
//location = "\U5b89\U5fbd \U829c\U6e56";
//"profile_image_url" = "http://tp3.sinaimg.cn/5562822470/180/0/1";
//"screen_name" = "Guoan_smy";
//"statuses_count" = 0;
//uid = 5562822470;
//verified = 0;
-(void)sinaThirdLogin
{
    __weak typeof (self) weakSelf = self;
    
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
    
    snsPlatform.loginClickHandler(weakSelf,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            //A.显示基本信息
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
            
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            
            //B.显示用户信息
            //获取accestoken以及新浪用户信息，得到的数据在回调Block对象形参respone的data属性
            [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToSina  completion:^(UMSocialResponseEntity *response){
                
                NSLog(@"SnsInformation is %@",response.data);
                
            }];
            
        }});

}
//http://tp.coolmart.net.cn/ulau?uid=867660021952901&os=android&app=coolpad&tm=1441942109918&op=CMCC&mac=ec:5a:86:03:24:c6&osver=19&ver=9.03.011&tk=f63379bd6d0a63737314f44d10f60f07&net=wifi&h=1280&imi=867660021952901&ip=192.168.2.2&w=720&rver=2&mb=15801612239&pm=Coolpad+8297-T01&sdk=1&channel=preset
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [UMSocialSnsService handleOpenURL:url];
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url];
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
