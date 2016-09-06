//
//  CommentCellModel.m
//  TableviewCellCalculateHeightDemo
//
//  Created by 马浩哲 on 16/8/18.
//  Copyright © 2016年 junanxin. All rights reserved.
//

#import "CommentCellModel.h"

@implementation CommentCellModel

-(instancetype)makeCommentCellModelWithDic:(NSDictionary *)dic
{
    self.commentStr = dic[@"commnet"];
    return self;
}

@end
