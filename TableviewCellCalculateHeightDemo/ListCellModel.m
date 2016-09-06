//
//  ListCellModel.m
//  TableviewCellCalculateHeightDemo
//
//  Created by 马浩哲 on 16/8/18.
//  Copyright © 2016年 junanxin. All rights reserved.
//

#import "ListCellModel.h"
#import "CommentCellModel.h"

@implementation ListCellModel

-(instancetype)makeListCellModelWithDic:(NSDictionary *)dic
{
    self.headIconStr = dic[@"headIcon"];
    self.userNameStr = dic[@"userName"];
    self.publishTimeStr = dic[@"publishTime"];
    self.contentStr = dic[@"content"];
//    self.likeNumStr = dic[@"likeNum"];
//    self.commentNumStr = dic[@"commentNum"];
    self.pictures = dic[@"pictures"];
    
    NSArray *commentListArr = dic[@"commentList"];
    NSMutableArray *modelCommentArr = [[NSMutableArray alloc] init];
    for (NSDictionary *commentDic in commentListArr ) {
        CommentCellModel *model = [[CommentCellModel alloc] init];
        model = [model makeCommentCellModelWithDic:commentDic];
        [modelCommentArr addObject:model];
    }
    self.comment_list = [NSArray arrayWithArray:modelCommentArr];
    return self;
}

@end
