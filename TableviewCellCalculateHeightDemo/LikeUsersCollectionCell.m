//
//  LikeUsersCollectionCell.m
//  TableviewCellCalculateHeightDemo
//
//  Created by 马浩哲 on 16/9/6.
//  Copyright © 2016年 junanxin. All rights reserved.
//

#define LikeUserAvatarIconWidth 25.0
#define LikeUserAvatarIconHeight LikeUserAvatarIconWidth

#import "LikeUsersCollectionCell.h"
#import "UserModel.h"


@interface LikeUsersCollectionCell ()

@property (nonatomic, strong) UIImageView *userAvatarImgV;

@end

@implementation LikeUsersCollectionCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadSubviews];
    }
    return self;
}

-(void)loadSubviews
{
    if (!self.userAvatarImgV) {
        self.userAvatarImgV = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, LikeUserAvatarIconWidth , LikeUserAvatarIconHeight)];
        self.userAvatarImgV.layer.cornerRadius = LikeUserAvatarIconHeight/2;
        self.userAvatarImgV.layer.borderColor = [UIColor colorWithHex:@"#FFAE03"].CGColor;
        self.userAvatarImgV.layer.borderWidth = 1;
        self.userAvatarImgV.layer.masksToBounds = YES;
        [self.contentView addSubview:self.userAvatarImgV];
    }
}

-(void)configWithUserModel:(UserModel *)userModel
{
    [self.userAvatarImgV sd_setImageWithURL:[NSURL URLWithString:userModel.userAvatarStr]];
}

@end
