//
//  PhotoBrowserVC.h
//  TableviewCellCalculateHeightDemo
//
//  Created by 马浩哲 on 16/9/12.
//  Copyright © 2016年 junanxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoBrowserView.h"

@protocol PhotoBrowserVCDelegate <NSObject>

-(NSURL *)getImageUrlWithImgIndex:(NSInteger)index;

-(UIImage *)getTapImageWithIndex:(NSInteger)index;

@end

@interface PhotoBrowserVC : UIViewController

@property (nonatomic, weak) UIView *sourceImagesContainerView;//当前图片的父视图
@property (nonatomic, assign) NSInteger currentImageIndex;//当前图片下标
@property (nonatomic, assign) NSInteger imageCount;//图片总数
@property (nonatomic, weak) id<PhotoBrowserVCDelegate>delegate;

-(void)show;
@end
