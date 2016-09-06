//
//  CommentCell.h
//  TableviewCellCalculateHeightDemo
//
//  Created by 马浩哲 on 16/8/18.
//  Copyright © 2016年 junanxin. All rights reserved.
//
#define CommentCellIdentifier @"CommentCell"
#import <UIKit/UIKit.h>

@class UITTTAttributedLabel,CommentCellModel;

@interface CommentCell : UITableViewCell

@property (strong,nonatomic) UITTTAttributedLabel *commentLabel;

-(void)configWithComment:(CommentCellModel *)CommentModel;

//-(void)configWithComment:(NSString *)string;

+(CGFloat)cellHeightWithObj:(id)obj;

@end
