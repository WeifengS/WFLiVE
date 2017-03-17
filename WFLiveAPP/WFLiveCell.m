//
//  WFLiveCell.m
//  WFLiveAPP
//
//  Created by 石伟锋 on 2017/2/27.
//  Copyright © 2017年 石伟锋. All rights reserved.
//

#import "WFLiveCell.h"
#import "WFLiveItem.h"
#import "WFCreatorItem.h"
#define Color(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
@implementation WFLiveCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _userHeadImage.layer.cornerRadius = 5;
    _userHeadImage.layer.masksToBounds = YES;
    _zbLabel.layer.cornerRadius = 5;
    _zbLabel.layer.masksToBounds = YES;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setLiveModel:(WFLiveItem *)liveModel{
    _liveModel = liveModel;
    NSURL * imageUrl = [NSURL URLWithString:liveModel.creator.portrait];
    [self.userHeadImage sd_setImageWithURL:imageUrl completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
    if (liveModel.city.length ==0) {
        self.addressLabel.text = @"火星";
    }else{
        self.addressLabel.text = liveModel.city;
    }
    self.nameLabel.text = liveModel.creator.nick;
    [self.bigUserImage sd_setImageWithURL:imageUrl];
    NSString *fullChaoyang = [NSString stringWithFormat:@"%zd人在看", liveModel.online_users];
    NSRange range = [fullChaoyang rangeOfString:[NSString stringWithFormat:@"%zd", liveModel.online_users]];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:fullChaoyang];
    [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range: range];
    [attr addAttribute:NSForegroundColorAttributeName value:Color(216, 41, 116) range:range];
    self.liveNumLabel.attributedText = attr;

    
    
}
@end
