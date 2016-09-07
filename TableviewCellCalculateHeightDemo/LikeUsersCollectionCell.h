//
//  LikeUsersCollectionCell.h
//  TableviewCellCalculateHeightDemo
//
//  Created by 马浩哲 on 16/9/6.
//  Copyright © 2016年 junanxin. All rights reserved.
//

#define LikeUserCellIdentifier @"LikeUsersCollectionCell"

#import <UIKit/UIKit.h>

@class UserModel;
@interface LikeUsersCollectionCell : UICollectionViewCell

-(void)configWithUserModel:(UserModel *)userModel;

@end
