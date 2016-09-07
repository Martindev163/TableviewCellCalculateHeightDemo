//
//  UserModel.m
//  TableviewCellCalculateHeightDemo
//
//  Created by 马浩哲 on 16/9/6.
//  Copyright © 2016年 junanxin. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

-(instancetype)configUserModelWithDictionary:(NSDictionary *)dic
{
    if (dic) {
        self.userNameStr = dic[@"userName"];
        self.userAvatarStr = dic[@"userAvatar"];
    }
    return self;
}

@end
