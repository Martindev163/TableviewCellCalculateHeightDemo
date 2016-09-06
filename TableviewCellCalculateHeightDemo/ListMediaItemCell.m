//
//  ListMediaItemCell.m
//  TableviewCellCalculateHeightDemo
//
//  Created by 马浩哲 on 16/9/1.
//  Copyright © 2016年 junanxin. All rights reserved.
//

#import "ListMediaItemCell.h"
#import "common.h"


#define ListMediaItemWidth ((kDeviceWidth-36.0)/3)
@implementation ListMediaItemCell

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadSubviews];
    }
    return self;
}

-(void)loadSubviews
{
    if (!_mediaImg) {
        _mediaImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ListMediaItemWidth, ListMediaItemWidth)];
        _mediaImg.contentMode = UIViewContentModeScaleAspectFill;
        _mediaImg.clipsToBounds = YES;
        [self.contentView addSubview:_mediaImg];
        
    }
}

-(void)setMediaImgStr:(NSString *)mediaImgStr
{
    if (mediaImgStr) {
        _mediaImg.image = [UIImage imageNamed:mediaImgStr];
    }
}


+(CGSize)cellSizeWithObje:(id)obj
{
    CGSize itemSize;
    if (obj) {
        
    }
    return itemSize;
}

@end
