//
//  RootViewController.m
//  WFLiveAPP
//
//  Created by 石伟锋 on 2017/2/27.
//  Copyright © 2017年 石伟锋. All rights reserved.
//

#import "RootViewController.h"
#import "LiveTableViewController.h"
#import "WFNavigationViewController.h"
#import "PrsenViewController.h"
@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setup];
//    UIButton * button1 = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button1 setTitle:@"我是主播" forState:UIControlStateNormal];
//    [button1 setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
//    button1.frame = CGRectMake(100, 100, self.view.bounds.size.width-200, 100);
//    [self.view addSubview:button1];
//    [button1 addTarget:self action:@selector(button1Clicked) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIButton * button2 = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button2 setTitle:@"直播列表" forState:UIControlStateNormal];
//    [button2 setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
//    button2.frame = CGRectMake(100, 250, self.view.bounds.size.width-200,100);
//    [self.view addSubview:button2];
//    [button2 addTarget:self action:@selector(button2Clicked) forControlEvents:UIControlEventTouchUpInside];
//    // Do any additional setup after loading the view.
}
- (void)setup
{
    [self addChildViewController:[[LiveTableViewController alloc] init] imageNamed:@"toolbar_home"];
    UIViewController *showTime = [[UIViewController alloc] init];
    showTime.view.backgroundColor = [UIColor whiteColor];
    [self addChildViewController:showTime imageNamed:@"toolbar_live"];
    UIStoryboard * mainSB = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    PrsenViewController * prsenVC = [mainSB instantiateViewControllerWithIdentifier:@"PrsenVC"];
    [self addChildViewController:prsenVC imageNamed:@"toolbar_me"];
}
- (void)addChildViewController:(UIViewController *)childController imageNamed:(NSString *)imageName
{
    WFNavigationViewController *nav = [[WFNavigationViewController alloc] initWithRootViewController:childController];
    childController.tabBarItem.image = [UIImage imageNamed:imageName];
    childController.tabBarItem.selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_sel", imageName]];
    // 设置图片居中, 这儿需要注意top和bottom必须绝对值一样大
    childController.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    // 设置导航栏为透明的
    //    if ([childController isKindOfClass:[ProfileController class]]) {
    //        [nav.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //        nav.navigationBar.shadowImage = [[UIImage alloc] init];
    //        nav.navigationBar.translucent = YES;
    //    }
    [self addChildViewController:nav];
}

-(void)button1Clicked{
    
}

-(void)button2Clicked{
    [self.navigationController pushViewController:[[LiveTableViewController alloc]init]  animated:YES];
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
