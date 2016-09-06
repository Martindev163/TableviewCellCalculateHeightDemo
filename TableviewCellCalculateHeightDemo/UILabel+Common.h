//
//  UILabel+Common.h
//  TableviewCellCalculateHeightDemo
//
//  Created by 马浩哲 on 16/8/23.
//  Copyright © 2016年 junanxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Common)

-(void)setLongString:(NSString *)str withFitWidth:(CGFloat)width;

-(void)setLongString:(NSString *)str withFitWidth:(CGFloat)width maxHeight:(CGFloat)maxHeight;

@end
