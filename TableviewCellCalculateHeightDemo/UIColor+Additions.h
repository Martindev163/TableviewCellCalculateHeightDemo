//
//  UIColor+Additions.h
//  TableviewCellCalculateHeightDemo
//
//  Created by 马浩哲 on 16/8/18.
//  Copyright © 2016年 junanxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Additions)

+ (UIColor*)colorWithHex:(NSString *)hexColor;
+ (UIColor*)colorWithHex:(NSString *)hexColor alpha:(CGFloat)alpha;

@end
