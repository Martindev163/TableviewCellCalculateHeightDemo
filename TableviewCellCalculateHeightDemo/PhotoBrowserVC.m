//
//  PhotoBrowserVC.m
//  TableviewCellCalculateHeightDemo
//
//  Created by 马浩哲 on 16/9/12.
//  Copyright © 2016年 junanxin. All rights reserved.
//

#import "PhotoBrowserVC.h"
#import "PhotoBrowserConfig.h"

@interface PhotoBrowserVC ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollview;
@property (nonatomic, assign) BOOL hasShowPhotoBrowser;
@property (nonatomic, strong) UILabel *indexLabel;


@end

@implementation PhotoBrowserVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!_hasShowPhotoBrowser) {
        [self showPhotoBrowser];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _hasShowPhotoBrowser = NO;
    [self loadScrollView];
    [self setUpFrames];
    self.view.backgroundColor = [UIColor blackColor];
}

#pragma mark - 添加scrollview
-(void)loadScrollView
{
    _scrollview = [[UIScrollView alloc] init];
    _scrollview.frame = self.view.bounds;
    _scrollview.delegate = self;
    _scrollview.showsVerticalScrollIndicator = NO;
    _scrollview.showsHorizontalScrollIndicator = NO;
    _scrollview.pagingEnabled = YES;
    _scrollview.hidden = YES;
    [self.view addSubview:_scrollview];
    
    for (int i = 0; i < self.imageCount; i++) {
        PhotoBrowserView *view = [[PhotoBrowserView alloc] init];
        
        view.imageView.tag = i;
        
        //处理单击事件
        __weak __typeof(self)weakSelf = self;
        view.singleTapBlock = ^(UITapGestureRecognizer *recognizer)
        {
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            [strongSelf hidePhotoBrowser:recognizer];
        };
        [_scrollview addSubview:view];
    }
    [self setupImageOfImageViewForIndex:self.currentImageIndex];
}

#pragma mark - 加在网络图片
-(void)setupImageOfImageViewForIndex:(NSInteger)index
{
    PhotoBrowserView *view = _scrollview.subviews[index];
    if (view.beginLoadingImg) return;
    [view setImageWithURL:[self getImageUrlForIndex:index] placeholderImage:[UIImage new]];
    view.beginLoadingImg = YES;
}

#pragma mark - 获取图片链接
-(NSURL *)getImageUrlForIndex:(NSInteger)index
{
    if ([self.delegate respondsToSelector:@selector(getImageUrlWithImgIndex:)]) {
         return [self.delegate getImageUrlWithImgIndex:index];
    }
    return nil;
}

#pragma mark - 设置各个控件Frame
-(void)setUpFrames
{
    CGRect rect = self.view.bounds;
    rect.size.width += kPhotoBrowserImageViewMargin*2;
    _scrollview.bounds = rect;
    _scrollview.center = CGPointMake(kDeviceWidth*0.5, kDeviceHeight*0.5);
    
    CGFloat y = 0;
    __block CGFloat w = kDeviceWidth;
    CGFloat h = kDeviceHeight;
    
    //设置所有PhotoVrowserView的frame
    [_scrollview.subviews enumerateObjectsUsingBlock:^(PhotoBrowserView *obj, NSUInteger idx, BOOL *stop) {
        CGFloat x = kPhotoBrowserImageViewMargin + idx*(kPhotoBrowserImageViewMargin *2 + w);
        obj.frame = CGRectMake(x, y, w, h);
    }];
    _scrollview.contentSize = CGSizeMake(_scrollview.subviews.count*_scrollview.frame.size.width, kDeviceHeight);
    _scrollview.contentOffset = CGPointMake(self.currentImageIndex*_scrollview.frame.size.width, 0);
}

#pragma mark - UIScrollVoew Delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int index = (scrollView.contentOffset.x + _scrollview.frame.size.width * 0.5)/_scrollview.bounds.size.width;
    long left = index - 2;
    long right = index + 2;
    left = left>0 ? left : 0;
    right = right>self.imageCount?self.imageCount:right;
    
    //预加载三张图片
    for (long i = left; i< right; i++) {
        [self setupImageOfImageViewForIndex:i];
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger autualIndex = scrollView.contentOffset.x/_scrollview.bounds.size.width;
    self.currentImageIndex = autualIndex;
    
    for (PhotoBrowserView *view in scrollView.subviews) {
        if (view.imageView.tag != autualIndex) {
            view.scrollView.zoomScale = 1.0;
        }
    }
}

#pragma mark - 弹出图片浏览器
-(void)show
{
    [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:self animated:NO completion:nil];
}

#pragma mark - 单击隐藏图片浏览器
-(void)hidePhotoBrowser:(UITapGestureRecognizer *)recognizer
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 显示图片浏览器
-(void)showPhotoBrowser
{
    UIView *sourceView = self.sourceImagesContainerView.subviews[self.currentImageIndex];
    UIView *parentView = [self getParsentView:sourceView];
    CGRect rect = [sourceView.superview convertRect:sourceView.frame toView:parentView];
    
    //如果是tableview，要减去偏移量
    if ([parentView isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)parentView;
        rect.origin.y = rect.origin.y - tableView.contentOffset.y;
    }
    
    UIImageView *tempImageView = [[UIImageView alloc] init];
    tempImageView.frame = rect;
    tempImageView.image = [UIImage imageNamed:@"qqIcon"];
    [self.view addSubview:tempImageView];
    tempImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    CGFloat placeImageSizeW = tempImageView.image.size.width;
    CGFloat placeImageSizeH = tempImageView.image.size.height;
    CGRect targetTemp;
    
    if (!kIsFullWidthForLandScape) {
        if (kDeviceWidth < kDeviceHeight) {
            CGFloat palceHolderH = (placeImageSizeH * kDeviceWidth)/placeImageSizeW;
            if (palceHolderH < kDeviceHeight) {
                targetTemp = CGRectMake(0, (kDeviceHeight - palceHolderH)*0.5, kDeviceWidth, palceHolderH);
            }else
            {
                targetTemp = CGRectMake(0, 0, kDeviceWidth, placeImageSizeH);
            }
        }
        else
        {
            CGFloat placeHolderH = (placeImageSizeH*kDeviceHeight)/placeImageSizeW;
            if (placeHolderH < kDeviceWidth) {
                targetTemp = CGRectMake((kDeviceWidth - placeHolderH)*0.5, 0, placeHolderH, kDeviceHeight);
            }else
            {
                targetTemp = CGRectMake(0, 0, placeHolderH, kDeviceHeight);
            }
        }
    }
    else
    {
        CGFloat placeHolderH = (placeImageSizeH *kDeviceWidth)/placeImageSizeW;
        if (placeHolderH <= kDeviceHeight) {
            targetTemp = CGRectMake(0, (kDeviceWidth - placeHolderH)*0.5, kDeviceWidth, placeHolderH);
        }else
        {
            targetTemp = CGRectMake(0, 0, kDeviceWidth, placeHolderH);
        }
    }
    _scrollview.hidden = YES;
    
    [UIView animateWithDuration:kPhotoBrowserShowDuration animations:^{
        tempImageView.frame = targetTemp;
    }completion:^(BOOL finished) {
        _hasShowPhotoBrowser = YES;
        [tempImageView removeFromSuperview];
        _scrollview.hidden = NO;
    }];
}

#pragma mark - 获取控制器的view
-(UIView *)getParsentView:(UIView *)view
{
    if ([[view nextResponder] isKindOfClass:[UIViewController class]] || view == nil) {
        return view;
    }
    return [self getParsentView:view.superview];
}
@end
