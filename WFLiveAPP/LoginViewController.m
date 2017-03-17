//
//  LoginViewController.m
//  WFLiveAPP
//
//  Created by 石伟锋 on 2017/2/28.
//  Copyright © 2017年 石伟锋. All rights reserved.
//

#import "LoginViewController.h"
#import "RootViewController.h"
#import <ShareSDKExtension/SSEThirdPartyLoginHelper.h>
@interface LoginViewController ()

@end

@implementation LoginViewController
- (IBAction)sinaButtonClicked:(UIButton *)sender {

   // 解除授权
    
    [ShareSDK cancelAuthorize:SSDKPlatformTypeSinaWeibo];

    
    [ShareSDK getUserInfo:SSDKPlatformTypeSinaWeibo
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         NSLog(@"11");
         if (state == SSDKResponseStateSuccess)
         {
             
             NSLog(@"uid=%@",user.uid);
             NSLog(@"%@",user.credential);
             NSLog(@"token=%@",user.credential.token);
             NSLog(@"nickname=%@",user.nickname);
            RootViewController * rootVC = [[RootViewController alloc]init];
             [self presentViewController:rootVC animated:YES completion:^{
                 
             }];
         }
         
         else
         {
             NSLog(@"%@",error);
         }
         
     }];
    
}
- (IBAction)qqButtonClicked:(id)sender {
    
    
    
   [ShareSDK cancelAuthorize:SSDKPlatformTypeQQ];
    [ShareSDK getUserInfo:SSDKPlatformTypeQQ
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {
             dispatch_async(dispatch_get_main_queue(), ^{
                 RootViewController * rootVC = [[RootViewController alloc]init];
                 [self presentViewController:rootVC animated:YES completion:^{
                     
                 }];
             });
//             RootViewController * rootVC = [[RootViewController alloc]init];
//             [self presentViewController:rootVC animated:YES completion:^{
//                 
//             }];

             NSLog(@"uid=%@",user.uid);
             NSLog(@"uid=%@",user.icon);
             NSLog(@"%@",user.credential);
             NSLog(@"token=%@",user.credential.token);
             NSLog(@"nickname=%@",user.nickname);
             NSUserDefaults * userD = [NSUserDefaults standardUserDefaults];
             [userD setValue:user.icon forKey:@"icon"];
             [userD setValue:user.nickname forKey:@"name"];
             
             
         }
         
         else
         {
             NSLog(@"%@",error);
         }
         
     }];

}
- (IBAction)weChatButton:(UIButton *)sender {
    RootViewController * rootVC = [[RootViewController alloc]init];
    [self presentViewController:rootVC animated:YES completion:^{
        
    }];

}

- (void)viewDidLoad {
    [super viewDidLoad];
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
