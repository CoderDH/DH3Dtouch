//
//  ViewController.m
//  DH3D Touch
//
//  Created by 董浩 on 16/4/14.
//  Copyright © 2016年 donghao. All rights reserved.
//
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHight [UIScreen mainScreen].bounds.size.height
#import "ViewController.h"
#import "DHTextOneViewController.h"
#import "DHTextTwoViewController.h"
#import "DHChildViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UIViewControllerPreviewingDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *baiduBtn;
@property(nonatomic,copy)NSArray *items;
@property(nonatomic,strong)UIView *picView;
@property(nonatomic, strong) UIViewController  *webController;

// peek && pop 相关
@property (nonatomic, assign) CGRect sourceRect;       // 用户手势点 对应需要突出显示的rect
@property (nonatomic, strong) NSIndexPath *indexPath;  // 用户手势点 对应的indexPath

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    // 处理shortCutItem 通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotoTestVc:) name:@"gototextVC" object:nil];
    
    
    
    
    [self configTableView];
    // 注册Peek和Pop方法
    [self registerForPreviewingWithDelegate:self sourceView:self.view];
    }

- (void)configTableView {
    self.items = @[@"第一条",@"第二条",@"第三条",@"第四条",@"第五条",@"第六条"];
    self.tableView.rowHeight = 50;
}

#pragma mark tableView相关

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text = self.items[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"第%zd个cell被点击/pop了",indexPath.row + 1);
    
    
    //创建
    UIView *picView=[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.picView=picView;
    picView.backgroundColor=[UIColor blackColor];
    [self.view addSubview:picView];
    UIImageView *picImageView=[[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    picImageView.image=[UIImage imageNamed:@"img_01"];
    [picView addSubview:picImageView];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.picView removeFromSuperview];


}
#pragma mark 通知相关


- (void)gotoTestVc:(NSNotification *)noti {
    NSString *type = noti.userInfo[@"type"];
    UIViewController *testVc;
    if ([type isEqualToString:@"1"]) {        // 测试1
        testVc = [[DHTextOneViewController alloc] initWithNibName:@"DHTextOneViewController" bundle:nil];
    } else if ([type isEqualToString:@"2"]) { // 测试2
        testVc = [[DHTextTwoViewController alloc] initWithNibName:@"DHTextTwoViewController" bundle:nil];
    }
    [self presentViewController:testVc animated:YES completion:nil];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/** peek手势  */
- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    
    // 获取用户手势点所在cell的下标。同时判断手势点是否超出tableView响应范围。
    if (![self getShouldShowRectAndIndexPathWithLocation:location]){
        
        //给百度按钮添加一个点击方法
        [self.baiduBtn addTarget:self action:@selector(getBaiduYe) forControlEvents:UIControlEventTouchUpInside];
       return self.webController;
    }else{
    DHChildViewController *childVC = [[DHChildViewController alloc] init];

    previewingContext.sourceRect = self.sourceRect;
    
    // 加个白色背景
    UIView *bgView =[[UIView alloc] initWithFrame:CGRectMake(20, 10, kScreenWidth - 40, kScreenHight - 20 - 64 * 2)];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.cornerRadius = 10;
    bgView.clipsToBounds = YES;
    [childVC.view addSubview:bgView];
    
//    // 加个lable
//    UILabel *lable = [[UILabel alloc] initWithFrame:bgView.bounds];
//    lable.textAlignment = NSTextAlignmentCenter;
//    lable.text = @"有种再按重一点...";
//    [bgView addSubview:lable];
    //加个imageview
    UIImageView *iconView=[[UIImageView alloc]initWithFrame:bgView.bounds];
    
    iconView.image=[UIImage imageNamed:@"img_01"];
    [bgView addSubview:iconView];
    return childVC;
}
}
//实现按钮的点击方法，访问百度
-(void)getBaiduYe{
    UIViewController *webController=[[UIViewController alloc]init];
    self.webController=webController;
    UIWebView *iconWeb=[[UIWebView alloc]initWithFrame:CGRectMake(20, 10, kScreenWidth - 40, kScreenHight - 20 - 64 * 2)];
    [webController.view addSubview:iconWeb];

    NSURL *url=[NSURL URLWithString:@"http://m.baidu.com"];
    
    
    
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    [request setValue:@"iPhone" forHTTPHeaderField:@"User-Agent"];
    //连接
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        //判断请求是否有错误
        if (!connectionError) {
            //把二进制数据转换成NSString类型
            NSString *html=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            
            NSLog(@"%@",html);
            
            //把html加载到webview上
            [iconWeb loadHTMLString:html baseURL:nil];
        }else{
            NSLog(@"连接错误 %@",connectionError);
            
        }
    }];
}

/** pop手势  */
- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
    [self tableView:self.tableView didSelectRowAtIndexPath:self.indexPath];
}

/** 获取用户手势点所在cell的下标。同时判断手势点是否超出tableView响应范围。*/
- (BOOL)getShouldShowRectAndIndexPathWithLocation:(CGPoint)location {
    NSInteger row = (location.y - 20)/50;
    self.sourceRect = CGRectMake(0, row * 50 + 20, kScreenWidth, 50);
    self.indexPath = [NSIndexPath indexPathForItem:row inSection:0];
    // 如果row越界了，返回NO 不处理peek手势
    return row >= self.items.count ? NO : YES;
}

@end
