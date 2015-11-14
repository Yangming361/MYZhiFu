//
//  DetailViewController.m
//  SMY-Zhihu
//
//  Created by qianfeng on 15/9/9.
//  Copyright (c) 2015年 ahnu. All rights reserved.
//

//攻壳机动队
//编程之禅---编程之道
//硕鼠官网 -- 获取视频下载地址

#define NavigationBarHight 64.0f

#define ImageHight 200.0f

#import "DetailViewController.h"

#import "DetailModel.h"

@interface DetailViewController ()<UIWebViewDelegate>
{
    NSMutableArray *_dataArray;
    
    UIWebView *_webView;
    NSString *_cssString;
    
    UIImageView *_headerImageView;
    
   
}
@property(nonatomic,strong) DetailModel *detailModel;

@end

@implementation DetailViewController


-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
    self.navigationController.toolbarHidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
   // self.navigationController.toolbar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _detailModel = [[DetailModel alloc] init];
    
    [self downLoadData];
    
    [self creatWebView];
    
    [self configNavigationToolBar];
}

- (void)configNavigationToolBar
{
    
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:[self addButtonWithFrame:CGRectMake(0, 0, 50, 50) andImage:@"News_Navigation_Arrow.png" andTarget:self andAction:@selector(dealBackClick:)]];
    UIBarButtonItem *downItem = [[UIBarButtonItem alloc] initWithCustomView:[self addButtonWithFrame:CGRectMake(0, 0, 50, 50) andImage:@"News_Navigation_Next.png" andTarget:self andAction:nil]];
    UIBarButtonItem *voteItem = [[UIBarButtonItem alloc] initWithCustomView:[self addButtonWithFrame:CGRectMake(0, 0, 50, 50) andImage:@"News_Navigation_Vote.png" andTarget:self andAction:nil]];
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithCustomView:[self addButtonWithFrame:CGRectMake(0, 0, 50, 50) andImage:@"News_Navigation_Share.png" andTarget:self andAction:nil]];
    UIBarButtonItem *commentItem = [[UIBarButtonItem alloc] initWithCustomView:[self addButtonWithFrame:CGRectMake(0, 0, 50, 50) andImage:@"News_Navigation_Comment.png" andTarget:self andAction:nil]];
    
    //分开按钮创建特殊的UIBarButtonItem
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    self.toolbarItems =@[backItem,spaceItem,downItem,spaceItem,voteItem,spaceItem,shareItem,spaceItem,commentItem];
}

- (void)dealBackClick:(UIButton *)button
{
    NSLog(@"backItem click");
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (UIButton *)addButtonWithFrame:(CGRect)frame
                        andImage:(NSString *)image
                       andTarget:(id)target
                       andAction: (SEL) action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    
    return button;
}

- (void)creatWebView
{
    
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    //_webView.scrollView.frame =CGRectMake(0, -60, self.view.bounds.size.width, 120);
    _webView.delegate = self;
    
   
    
    
    [self.view addSubview:_webView];
    
    
    
}
- (void)refreshWebData
{
    
   // NSDictionary *dict = _detailModel[];
    _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
  // _headerImageView.contentMode = UIViewContentModeScaleAspectFill;
     //_headerImageView.autoresizesSubviews = YES;
    
//    if (_detailModel.image!=nil) {
//        urlImage = _detailModel.image;
//        NSLog(@"sf");
//    }else
//    {
//        urlImage = _detailModel.theme[@"thumbnail"];
//        
//    }
//    NSLog(@"%@",urlImage);
    NSString *urlImage  = _detailModel.image;
    [_headerImageView setImageWithURL:[NSURL URLWithString:urlImage]];
    
    
    
    
     [_webView.scrollView addSubview:_headerImageView];
    //css 和html组合在一起
    NSString *htmlString = [NSString stringWithFormat:@"<link rel=\"stylesheet\" href=%@ type=\"text/css\" /> %@",[_detailModel.css firstObject],_detailModel.body];
    
   [_webView loadHTMLString:htmlString baseURL:nil];
    
    
    
    
}
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    
//    CGFloat y = scrollView.contentOffset.y+NavigationBarHight;//根据实际选择加不加上NavigationBarHight（44、64 或者没有导航条）
//    if (y < -ImageHight) {
//        CGRect frame = _headerImageView.frame;
//        frame.origin.y = y;
//        frame.size.height =  -y;//contentMode = UIViewContentModeScaleAspectFill时，高度改变宽度也跟着改变
//        _headerImageView.frame = frame;
//    }
//    
//}
//将html里面的图片做缩放--适配手机屏幕
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    double width = _webView.frame.size.width - 10;
    NSString *js = [NSString stringWithFormat:@"var script = document.createElement('script');"
                    "script.type = 'text/javascript';"
                    "script.text = \"function ResizeImages() { "
                    "var myimg,oldwidth;"
                    "var maxwidth=%f;" //缩放系数
                    "for(i=0;i <document.images.length;i++){"
                    "myimg = document.images[i];"
                    "if(myimg.width > maxwidth){"
                    "oldwidth = myimg.width;"
                    "myimg.width = maxwidth;"
                    "myimg.height = myimg.height * (maxwidth/oldwidth)*2;"
                    "}"
                    "}"
                    "}\";"
                    "document.getElementsByTagName('head')[0].appendChild(script);",width];
    [_webView stringByEvaluatingJavaScriptFromString:js];
    
    [_webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
    
}
- (void)downLoadData
{
   // NSString *urlString2= @"http://news-at.zhihu.com/api/4/story/4797414";
    NSString *urlString = [NSString stringWithFormat:DetailPage_URL,_model.identity];
    NSLog(@"%@",urlString);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        [ZJModelTool createModelWithDictionary:dict modelName:@"DetailModel"];
        
        [_detailModel setValuesForKeysWithDictionary:dict];
        _detailModel.identity = dict[@"id"];
        
        [self refreshWebData];
        
       
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    

    
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
