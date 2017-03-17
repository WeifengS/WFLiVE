//
//  WFLiveCell.h
//  WFLiveAPP
//
//  Created by 石伟锋 on 2017/2/27.
//  Copyright © 2017年 石伟锋. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WFLiveItem;
@interface WFLiveCell : UITableViewCell
//@class WFLiveItem;

@property(nonatomic,strong)WFLiveItem * liveModel;

@property (weak, nonatomic) IBOutlet UIImageView *userHeadImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *liveNumLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bigUserImage;
@property (weak, nonatomic) IBOutlet UILabel *zbLabel;

@end
