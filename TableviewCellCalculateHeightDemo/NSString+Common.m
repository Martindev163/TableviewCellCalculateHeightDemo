//
//  NSString+Common.m
//  TableviewCellCalculateHeightDemo
//
//  Created by 马浩哲 on 16/8/23.
//  Copyright © 2016年 junanxin. All rights reserved.
//

#import "NSString+Common.h"

@implementation NSString (Common)

-(CGSize)getSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size
{
    CGSize resultSize = CGSizeZero;
    if (self.length <= 0) {
        return resultSize;
    }
    resultSize = [self boundingRectWithSize:size options:(NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:font} context:nil].size;
    return resultSize;
}
-(CGFloat)getHeightWithFont:(UIFont *)font constrainedToSize:(CGSize)size
{
    return [self getSizeWithFont:font constrainedToSize:size].height;
}
-(CGFloat)getWidthWithFont:(UIFont *)font constrainedToSize:(CGSize)size
{
    return [self getSizeWithFont:font constrainedToSize:size].width;
}
@end
