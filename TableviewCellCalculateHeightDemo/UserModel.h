//
//  UserModel.h
//  TableviewCellCalculateHeightDemo
//
//  Created by 马浩哲 on 16/9/6.
//  Copyright © 2016年 junanxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property (strong, nonatomic) NSString *userNameStr,*userAvatarStr;//用户名，用户头像
-(instancetype)configUserModelWithDictionary:(NSDictionary *)dic;
@end
