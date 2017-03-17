                                                                                              //
//  LivePlayerViewController.m
//  WFLiveAPP
//
//  Created by 石伟锋 on 2017/2/27.
//  Copyright © 2017年 石伟锋. All rights reserved.
//

#import "LivePlayerViewController.h"
#import "WFCreatorItem.h"
#import "WFLiveItem.h"
#import <IJKMediaFramework/IJKMediaFramework.h>
#import "XTLoveHeartView.h"
#import "UIViewController+SLExtension.h"
@interface LivePlayerViewController ()
@property(nonatomic,strong)UIImageView * imageView;
@property(nonatomic,strong)IJKFFMoviePlayerController * player;
/** 直播开始前的占位图片 */
@property(nonatomic, weak) UIImageView *placeHolderView;

@end

@implementation LivePlayerViewController
- (void)loadImage
{

        UIImageView * imageView = [[UIImageView alloc]init];
        // 设置直播占位图片
        NSURL *imageUrl = [NSURL URLWithString:_liveModel.creator.portrait];
        NSLog(@"%@",imageUrl);
        [imageView sd_setImageWithURL:imageUrl placeholderImage:nil];
        imageView.frame = self.view.bounds;
    [self.view addSubview:imageView];

        _placeHolderView = imageView;
        [self showGifLoding:nil inView:self.placeHolderView];
        // 强制布局
        //[_placeHolderView layoutIfNeeded];
  
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    self.imageView = [[UIImageView alloc]init];
//    // 设置直播占位图片
//    NSURL *imageUrl = [NSURL URLWithString:_liveModel.creator.portrait];
//    NSLog(@"%@",imageUrl);
//    [self.imageView sd_setImageWithURL:imageUrl placeholderImage:nil];
//    self.imageView.frame = self.view.bounds;
//    [self.view addSubview:self.imageView];
        [self loadImage];
    // 拉流地址
    NSURL *url = [NSURL URLWithString:_liveModel.stream_addr];
    
    // 创建IJKFFMoviePlayerController：专门用来直播，传入拉流地址就好了
    IJKFFMoviePlayerController *playerVc = [[IJKFFMoviePlayerController alloc] initWithContentURL:url withOptions:nil];
    
    // 准备播放
    [playerVc prepareToPlay];
    
    // 强引用，反正被销毁
    _player = playerVc;
    
    playerVc.view.frame = [UIScreen mainScreen].bounds;
    
    [self.view insertSubview:playerVc.view atIndex:1];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame =CGRectMake(10, 25, 35, 35);
    [self.view addSubview:button];
    [button setImage:[UIImage imageNamed:@"back_bar"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.25 target:self selector:@selector(showLoveHeartView) userInfo:nil repeats:YES];
    [self loadImageView];
//    [self.view addSubview:self.placeHolderView];

    // Do any additional setup after loading the view.
}
- (void)loadImageView{
//    [self loadImage];
    // 监听视频是否播放完成
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinish) name:IJKMPMoviePlayerPlaybackDidFinishNotification object:self.player];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stateDidChange) name:IJKMPMoviePlayerLoadStateDidChangeNotification object:self.player];
}

- (void)stateDidChange
{
    if ((self.player.loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
        if (!self.player.isPlaying) {
            [self.player play];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (_placeHolderView) {
                    [_placeHolderView removeFromSuperview];
                    _placeHolderView = nil;
                   // [self.player.view addSubview:_renderer.view];
                }
                [self hideGufLoding];
            });
        }else{
            // 如果是网络状态不好, 断开后恢复, 也需要去掉加载
            if (self.gifView.isAnimating) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self hideGufLoding];
                });
                
            }
        }
    }else if (self.player.loadState & IJKMPMovieLoadStateStalled){ // 网速不佳, 自动暂停状态
        [self showGifLoding:nil inView:self.player.view];
    }
}

- (void)didFinish
{
    NSLog(@"加载状态...%ld %ld %s", self.player.loadState, self.player.playbackState, __func__);
    // 因为网速或者其他原因导致直播stop了, 也要显示GIF
    if (self.player.loadState & IJKMPMovieLoadStateStalled && !self.gifView) {
        [self showGifLoding:nil inView:self.player.view];
        return;
    }
    //    方法：
    //      1、重新获取直播地址，服务端控制是否有地址返回。
    //      2、用户http请求该地址，若请求成功表示直播未结束，否则结束
    __weak typeof(self)weakSelf = self;
//    [[ALinNetworkTool shareTool] GET:self.live.flv parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"请求成功%@, 等待继续播放", responseObject);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"请求失败, 加载失败界面, 关闭播放器%@", error);
//        [weakSelf.moviePlayer shutdown];
//        [weakSelf.moviePlayer.view removeFromSuperview];
//        weakSelf.moviePlayer = nil;
//        weakSelf.endView.hidden = NO;
//    }];
}

- (void)showLoveHeartView
{
    XTLoveHeartView *heart = [[XTLoveHeartView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [self.view addSubview:heart];
    CGPoint fountainSource = CGPointMake(self.view.frame.size.width - 80, self.view.bounds.size.height - 30 / 2.0 - 10);
    heart.center = fountainSource;
    [heart animateInView:_player.view];
}
-(void)buttonClicked:(UIButton*)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // 界面消失，一定要记得停止播放
    [_player pause];
    [_player stop];
    [_player shutdown];
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
