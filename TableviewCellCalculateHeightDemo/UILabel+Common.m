//
//  UILabel+Common.m
//  TableviewCellCalculateHeightDemo
//
//  Created by 马浩哲 on 16/8/23.
//  Copyright © 2016年 junanxin. All rights reserved.
//

#import "UILabel+Common.h"
#import "NSString+Common.h"

@implementation UILabel (Common)

-(void)setLongString:(NSString *)str withFitWidth:(CGFloat)width
{
    [self setLongString:str withFitWidth:width maxHeight:CGFLOAT_MAX];
}

-(void)setLongString:(NSString *)str withFitWidth:(CGFloat)width maxHeight:(CGFloat)maxHeight
{
    self.numberOfLines = 0;
    CGSize resultSize = [str getSizeWithFont:self.font constrainedToSize:CGSizeMake(width, CGFLOAT_MAX)];
    CGFloat resultHeight = resultSize.height;
    if (maxHeight >0&&resultHeight > maxHeight) {
        resultHeight = maxHeight;
    }
    CGRect frame = self.frame;
    frame.size.height = resultHeight;
    [self setFrame:frame];
    self.text = str;
}

@end
