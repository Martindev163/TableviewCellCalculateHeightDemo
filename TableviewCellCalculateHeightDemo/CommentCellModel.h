//
//  CommentCellModel.h
//  TableviewCellCalculateHeightDemo
//
//  Created by 马浩哲 on 16/8/18.
//  Copyright © 2016年 junanxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentCellModel : NSObject

@property (copy, nonatomic) NSString *commentStr;

-(instancetype)makeCommentCellModelWithDic:(NSDictionary *)dic;
@end
