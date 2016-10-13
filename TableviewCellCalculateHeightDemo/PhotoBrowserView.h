//
//  PhotoBrowserView.h
//  TableviewCellCalculateHeightDemo
//
//  Created by 马浩哲 on 16/9/18.
//  Copyright © 2016年 junanxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoBrowserView : UIView

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, assign) BOOL beginLoadingImg;

-(void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder;

//单击回调
@property (nonatomic, strong) void (^singleTapBlock)(UITapGestureRecognizer *recognizer);
@end
