//
//  ListMediaItemCell.h
//  TableviewCellCalculateHeightDemo
//
//  Created by 马浩哲 on 16/9/1.
//  Copyright © 2016年 junanxin. All rights reserved.
//

#define ListMediaItemCellIdentifier @"ListMediaItemCell"

#import <UIKit/UIKit.h>

@interface ListMediaItemCell : UICollectionViewCell

@property (strong, nonatomic) UIImageView *mediaImg;
@property (strong, nonatomic) UIButton *mediaActinBtn;

@property (copy, nonatomic) NSString *mediaImgStr;
+(CGSize)cellSizeWithObje:(id)obj;

@end
