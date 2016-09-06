//
//  NSString+Common.h
//  TableviewCellCalculateHeightDemo
//
//  Created by 马浩哲 on 16/8/23.
//  Copyright © 2016年 junanxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Common)
-(CGSize)getSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
-(CGFloat)getHeightWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
-(CGFloat)getWidthWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
@end
