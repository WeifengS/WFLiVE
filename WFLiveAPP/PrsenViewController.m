//
//  PrsenViewController.m
//  WFLiveAPP
//
//  Created by 石伟锋 on 2017/3/2.
//  Copyright © 2017年 石伟锋. All rights reserved.
//

#import "PrsenViewController.h"

@interface PrsenViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;

@property (weak, nonatomic) IBOutlet UILabel *nameLbel;
@end

@implementation PrsenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.title = @"个人中心";
    self.icon.layer.cornerRadius = self.icon.frame.size.width/2 ;
    self.icon.layer.masksToBounds = YES;
    NSUserDefaults * userD = [NSUserDefaults standardUserDefaults];
    NSString * str = [userD objectForKey:@"icon"];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:nil options:SDWebImageRefreshCached];
    [self.icon setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:str]]]];
    self.nameLbel.text = [userD objectForKey:@"name"];
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
