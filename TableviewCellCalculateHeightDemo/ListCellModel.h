//
//  ListCellModel.h
//  TableviewCellCalculateHeightDemo
//
//  Created by 马浩哲 on 16/8/18.
//  Copyright © 2016年 junanxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserModel;
@interface ListCellModel : NSObject

@property (copy, nonatomic) NSString *headIconStr,*userNameStr,*publishTimeStr,*contentStr,*likeNumStr,*commentNumStr;
@property (strong, nonatomic) NSMutableArray *pictures;//媒体图片
@property (strong, nonatomic) NSArray *comment_list,*like_users;//评论，喜欢的人
@property (strong, nonatomic) UserModel *user;
@property (nonatomic, assign) BOOL isLiked;//是否点过赞

-(instancetype)makeListCellModelWithDic:(NSDictionary *)dic;
@end
