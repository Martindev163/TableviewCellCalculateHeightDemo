//
//  CommentCell.m
//  TableviewCellCalculateHeightDemo
//
//  Created by 马浩哲 on 16/8/18.
//  Copyright © 2016年 junanxin. All rights reserved.
//

#define kCommentFont [UIFont systemFontOfSize:14]

#define kCommentCell_leftOrRightPading 10.0
#define kCommentCell_topPading 5.0
#define kCommentCell_ContentWidth (kDeviceWidth - ListCellLeftMargin*2 - kCommentCell_leftOrRightPading*2)
#define kCommentCell_ContentMaxHeight 105.0

#import "CommentCell.h"
#import "common.h"
#import "UITTTAttributedLabel.h"
#import "CommentCellModel.h"

@interface CommentCell ()

@property (strong, nonatomic)UILabel *userNameLab,*commentTimeLab;
@property (strong, nonatomic)UIImageView *timeIcon;
@property (strong, nonatomic)CommentCellModel *commentModel;

@end


@implementation CommentCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.backgroundView = nil;
        if (!_commentLabel) {
            _commentLabel = [[UITTTAttributedLabel alloc] initWithFrame:CGRectMake(kCommentCell_leftOrRightPading, kCommentCell_topPading, kCommentCell_ContentWidth, 20)];
            _commentLabel.numberOfLines = 0;
            _commentLabel.font = kCommentFont;
            [self.contentView addSubview:_commentLabel];
        }
        
    }
    return self;
}

-(void)configWithComment:(CommentCellModel *)CommentModel
{
    _commentModel = CommentModel;
    
    [_commentLabel setLongString:CommentModel.commentStr withFitWidth:kCommentCell_ContentWidth maxHeight:kCommentCell_ContentMaxHeight];
}

//-(void)configWithComment:(NSString *)string
//{
//    [_commentLabel setLongString:string withFitWidth:kCommentCell_ContentWidth maxHeight:kCommentCell_ContentMaxHeight];
//}

+(CGFloat)cellHeightWithObj:(id)obj
{
    CGFloat cellHeight = 0;
    if ([obj isKindOfClass:[CommentCellModel class]]) {
        CommentCellModel *curCommnet = (CommentCellModel *)obj;
        cellHeight = MIN(kCommentCell_ContentMaxHeight, [curCommnet.commentStr getHeightWithFont:kCommentFont constrainedToSize:CGSizeMake(kCommentCell_ContentWidth, CGFLOAT_MAX)]) + 15 + kCommentCell_topPading;
    }
    
//    cellHeight = MIN(kCommentCell_ContentMaxHeight, [(NSString *)obj getHeightWithFont:kCommentFont constrainedToSize:CGSizeMake(kCommentCell_ContentWidth, CGFLOAT_MAX)]) + 15 + kCommentCell_topPading;
    return ceil(cellHeight);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
