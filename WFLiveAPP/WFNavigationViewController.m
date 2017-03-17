//
//  WFNavigationViewController.m
//  WFLiveAPP
//
//  Created by 石伟锋 on 2017/3/2.
//  Copyright © 2017年 石伟锋. All rights reserved.
//

#import "WFNavigationViewController.h"

@interface WFNavigationViewController ()

@end

@implementation WFNavigationViewController
+ (void)initialize
{
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBackgroundImage:[UIImage imageNamed:@"navBar_bg_414x70"] forBarMetrics:UIBarMetricsDefault];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    UINavigationBar * bar = self.navigationBar;
//    bar.barStyle = UIBarStyleDefault;
//    bar.translucent = NO;
//    [bar setBackgroundImage:[UIImage imageNamed:@"navBar_bg_414x70"] forBarMetrics:UIBarMetricsDefault];

    // Do any additional setup after loading the view.
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
