//
//  ListCell.h
//  TableviewCellCalculateHeightDemo
//
//  Created by 马浩哲 on 16/8/18.
//  Copyright © 2016年 junanxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListCellModel.h"

@protocol ListCellImgDelegate <NSObject>

-(void)ClickCollectionViewItemActionWithItemIndex:(NSInteger)index andPictres:(NSMutableArray *)imgsArray andTapImg:(UIImage *)img andSourceSuperView:(UIView *)sourceView;

@end

@interface ListCell : UITableViewCell

-(void)setListCellModel:(ListCellModel *)listCellModel;
+(CGFloat)cellHeightWithObj:(id)obj;
@property (nonatomic, weak) id<ListCellImgDelegate> imgDelegate;

@end
