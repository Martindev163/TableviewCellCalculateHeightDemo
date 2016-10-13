//
//  PhotoBrowserView.m
//  TableviewCellCalculateHeightDemo
//
//  Created by 马浩哲 on 16/9/18.
//  Copyright © 2016年 junanxin. All rights reserved.
//

#import "PhotoBrowserView.h"
#import "PhotoBrowserConfig.h"

@interface PhotoBrowserView()<UIScrollViewDelegate>

@property (nonatomic, strong) NSURL *imgUrl;
@property (nonatomic, strong) UIImage *placeHolderImage;

@end

@implementation PhotoBrowserView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.scrollView];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _scrollView.frame = self.bounds;
    [self adjustFrames];
}

#pragma mark - 适配控件Frame
-(void)adjustFrames
{
    CGRect frame = self.scrollView.frame;
    if (self.imageView.image) {
        CGSize imageSize = self.imageView.image.size;
        CGRect imageFrame = CGRectMake(0, 0, imageSize.width, imageSize.height);
        if (kIsFullWidthForLandScaoe) {
            CGFloat ratio = frame.size.width/imageFrame.size.width;
            imageFrame.size.height = imageFrame.size.height*ratio;
            imageFrame.size.width = frame.size.width;
        }
        else
        {
            if (frame.size.width <= frame.size.height) {
                CGFloat ratio = frame.size.width/imageFrame.size.width;
                imageFrame.size.height = imageFrame.size.height*ratio;
                imageFrame.size.width = frame.size.width;
            }else
            {
                CGFloat ratio = frame.size.height/imageFrame.size.height;
                imageFrame.size.width = imageFrame.size.width*ratio;
                imageFrame.size.height = frame.size.height;
            }
        }
    
        self.imageView.frame = imageFrame;
        self.scrollView.contentSize = self.imageView.frame.size;
        self.imageView.center = [self centerOfScrollViewContent:self.scrollView];
    }
    else
    {
        frame.origin = CGPointZero;
        self.imageView.frame = frame;
        self.scrollView.contentSize = self.imageView.frame.size;
    }
    self.scrollView.contentOffset = CGPointZero;
}


#pragma mark - 计算图片的中心点
-(CGPoint)centerOfScrollViewContent:(UIScrollView *)scrollView
{
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?(scrollView.bounds.size.width - scrollView.contentSize.width)*0.5:0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?(scrollView.bounds.size.height - scrollView.contentSize.height)*0.5:0.0;
    CGPoint actualCenter = CGPointMake(scrollView.contentSize.width*0.5+offsetX, scrollView.contentSize.height*0.5+offsetY);
    return actualCenter;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.frame = CGRectMake(0, 0, kDeviceWidth, kDeviceHeight);
        [_scrollView addSubview:self.imageView];
        _scrollView.delegate = self;
        _scrollView.clipsToBounds = YES;
    }
    return _scrollView;
}

-(UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.frame = CGRectMake(0, 0, kDeviceWidth, kDeviceHeight);
        _imageView.userInteractionEnabled = YES;
    }
    return _imageView;
}

-(void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder
{
    _imgUrl = url;
    _placeHolderImage = placeholder;
    [_imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@""] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [self setNeedsLayout];//加在图片后重新设置图片的宽高
        //处理图片加载失败的情况
        if (error) {
            NSLog(@"失败");
        }
    }];
}
@end
