//
//  UIViewController+SLExtension.m
//  XueShengHui
//
//  Created by ALin on 16/4/6.
//  Copyright © 2016年 ALin. All rights reserved.
//

#import "UIViewController+SLExtension.h"
#import "UIImageView+Extension.h"
#import <objc/message.h>


static const void *GifKey = &GifKey;
@implementation UIViewController (SLExtension)
- (UIImageView *)gifView
{
    return objc_getAssociatedObject(self, GifKey);
}

- (void)setGifView:(UIImageView *)gifView
{
    objc_setAssociatedObject(self, GifKey, gifView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// 显示GIF加载动画
- (void)showGifLoding:(NSArray *)images inView:(UIView *)view
{
    if (!images.count) {
        images = @[[UIImage imageNamed:@"hold1_60x72"], [UIImage imageNamed:@"hold2_60x72"], [UIImage imageNamed:@"hold3_60x72"]];
    }
    UIImageView *gifView = [[UIImageView alloc] init];
    if (!view) {
        view = self.view;
    }
    [view addSubview:gifView];
    gifView.frame = CGRectMake((self.view.frame.size.width-60)/2, (self.view.frame.size.height-70)/2, 60, 70);
    self.gifView = gifView;
    [gifView playGifAnim:images];
    
}
// 取消GIF加载动画
- (void)hideGufLoding
{
    [self.gifView stopGifAnim];
    self.gifView = nil;
}

- (BOOL)isNotEmpty:(NSArray *)array
{
    if ([array isKindOfClass:[NSArray class]] && array.count) {
        return YES;
    }
    return NO;
}
@end
