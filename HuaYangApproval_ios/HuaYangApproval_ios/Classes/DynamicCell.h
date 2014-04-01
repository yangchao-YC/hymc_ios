//
//  DynamicCell.h
//  HuaYangApproval_ios
//
//  Created by jijeMac2 on 14-3-31.
//  Copyright (c) 2014年 huayang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RTLabel;
@class DynamicModel;

@interface DynamicCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *upictureImageView;
@property (weak, nonatomic) IBOutlet UILabel *authornameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateTimeLabel;
@property (strong, nonatomic) RTLabel *contentRTLabel;
@property (weak, nonatomic) IBOutlet UIButton *btnForwarding;
@property (weak, nonatomic) IBOutlet UIButton *btnReply;
@property (weak, nonatomic) IBOutlet UIButton *btnPraise;

- (IBAction)showPop:(id)sender forEvent:(UIEvent *)event;

- (void)setDynamicData:(DynamicModel *)dynamicModel;
- (CGFloat)height;
@end
