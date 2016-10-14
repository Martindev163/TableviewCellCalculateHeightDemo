//
//  ListCell.m
//  TableviewCellCalculateHeightDemo
//
//  Created by 马浩哲 on 16/8/18.
//  Copyright © 2016年 junanxin. All rights reserved.
//

#define headIconSize 60
#define ContentFont 16
#define LikeBtnWidth 35
#define LikeBtnHeight LikeBtnWidth
#define CommentBtnWidth 50
#define CommentBtnHeight 27
#define ContentWidth (kDeviceWidth - ListCellLeftMargin*2)
#define ListCell_PadingTop (60 + 15)
#define ContentLabelMaxHeight 200
#define ListMediaItemWidth ((kDeviceWidth-36.0)/3)
#define mediaCount 5

#import "ListCell.h"
#import "common.h"
#import "UITTTAttributedLabel.h"
#import "UICustomCollectionView.h"
#import "NSString+Common.h"
#import "UILabel+Common.h"
#import "ListMediaItemCell.h"
#import "CommentCell.h"
#import "CommentCellModel.h"
#import "LikeUsersCollectionCell.h"
#import "UserModel.h"

@interface ListCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,TTTAttributedLabelDelegate,UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic)UILabel *nameLab,*likeLab,*commentLab,*timeLab;//昵称、喜欢、评论、时间
@property (strong, nonatomic)UIImageView *likeAndCommentSeparateLine;//点赞评论分割线
@property (strong, nonatomic)UITTTAttributedLabel *contentLab;//内容
@property (strong, nonatomic)UIButton *headBtn,*likeBtn,*commentBtn;//头像、喜欢、评论
@property (strong, nonatomic)UITableView *commentTabV;//评论tabl
@property (strong, nonatomic)UICustomCollectionView *mediaView;//发布的图片collectionView

@property (strong, nonatomic)ListCellModel *listCellModel;//model
@property (strong, nonatomic)UITableView *commentTableView;//评论列表
@property (strong, nonatomic)UICollectionView *likeUsersView;//点赞人

@end

@implementation ListCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        if (!self.headBtn) {
            _headBtn = [[UIButton alloc] initWithFrame:CGRectMake(ListCellLeftMargin, ListCellVerticalMargin, headIconSize, headIconSize)];
            [self.contentView addSubview:_headBtn];
        }
        if (!self.nameLab) {
            _nameLab = [[UILabel alloc] initWithFrame:CGRectMake(_headBtn.right + ListCellMargin, ListCellVerticalMargin, kDeviceWidth - (_headBtn.right + ListCellMargin), 20)];
            _nameLab.font = [UIFont systemFontOfSize:16];
            _nameLab.textColor = [UIColor colorWithHex:@"#3bbd79"];
            [self.contentView addSubview:_nameLab];
        }
        if (!self.timeLab) {
            _timeLab = [[UILabel alloc] initWithFrame:CGRectMake(_nameLab.left, _nameLab.bottom + ListCellMargin, _nameLab.width, 20)];
            _timeLab.textColor = [UIColor darkGrayColor];
            [self.contentView addSubview:_timeLab];
        }
        if (!self.contentLab) {
            _contentLab = [[UITTTAttributedLabel alloc] initWithFrame:CGRectMake(ListCellLeftMargin, _headBtn.bottom + ListCellVerticalMargin, ContentWidth, 20)];
            _contentLab.font = [UIFont systemFontOfSize:ContentFont];
            _contentLab.textColor = [UIColor colorWithHex:@"#222222"];
            [self.contentView addSubview:_contentLab];
        }
        //图片
        if (!self.mediaView) {
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
            self.mediaView = [[UICustomCollectionView alloc] initWithFrame:CGRectMake(ListCellLeftMargin, 0, ContentWidth, 80) collectionViewLayout:layout];
            self.mediaView.scrollEnabled = NO;
            self.mediaView.backgroundView = nil;
            self.mediaView.backgroundColor = [UIColor clearColor];
            self.mediaView.delegate = self;
            self.mediaView.dataSource = self;
            [self.mediaView registerClass:[ListMediaItemCell class] forCellWithReuseIdentifier:ListMediaItemCellIdentifier];
            [self.contentView addSubview:self.mediaView];
        }
        //点赞、评论按钮
        if (!_likeBtn) {
            _likeBtn = [[UIButton alloc] initWithFrame:CGRectMake(ListCellLeftMargin, 0, LikeBtnWidth, LikeBtnHeight)];
            [_likeBtn setImage:[UIImage imageNamed:@"tweet_btn_like"] forState:UIControlStateNormal];
            [_likeBtn setImage:[UIImage imageNamed:@"tweet_btn_liked"] forState:UIControlStateSelected];
            [_likeBtn addTarget:self action:@selector(LikeBtnClikAction) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:_likeBtn];
        }
        if (!_commentBtn) {
            _commentBtn = [[UIButton alloc] initWithFrame:CGRectMake(kDeviceWidth- ListCellLeftMargin - LikeBtnWidth, 0, LikeBtnWidth, LikeBtnHeight)];
            [_commentBtn setImage:[UIImage imageNamed:@"tweet_btn_comment"] forState:UIControlStateNormal];
            [self.contentView addSubview:_commentBtn];
        }
        
        //点赞人collectionView
        if (!self.likeUsersView) {
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
            self.likeUsersView = [[UICollectionView alloc] initWithFrame:CGRectMake(ListCellLeftMargin, 0, ContentWidth, 35) collectionViewLayout:layout];
            self.likeUsersView.scrollEnabled = NO;
            [self.likeUsersView setBackgroundView:nil];
            [self.likeUsersView setBackgroundColor:[UIColor colorWithHex:@"#eeeeee"]];
            [self.likeUsersView registerClass:[LikeUsersCollectionCell class] forCellWithReuseIdentifier:LikeUserCellIdentifier];
            self.likeUsersView.delegate = self;
            self.likeUsersView.dataSource = self;
            [self.contentView addSubview:self.likeUsersView];
        }
        
        //点赞评论分割线
        if (!self.likeAndCommentSeparateLine) {
            self.likeAndCommentSeparateLine = [[UIImageView alloc] initWithFrame:CGRectMake(ListCellLeftMargin, 0, ContentWidth, 1)];
            self.likeAndCommentSeparateLine.backgroundColor = [UIColor colorWithHex:@"#dddddd"];
            [self.contentView addSubview:self.likeAndCommentSeparateLine];
        }
        
        //评论Tableview
        if (!self.commentTableView) {
            _commentTableView = [[UITableView alloc] initWithFrame:CGRectMake(ListCellLeftMargin, 0, kCommentCell_CotentWidth, 20)];
            _commentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            _commentTableView.scrollEnabled = NO;
            [_commentTableView setBackgroundView:nil];
            [_commentTableView setBackgroundColor:[UIColor colorWithHex:@"#eeeeee"]];
            [_commentTableView registerClass:[CommentCell class] forCellReuseIdentifier:CommentCellIdentifier];
            _commentTableView.delegate = self;
            _commentTableView.dataSource = self;
            [self.contentView addSubview:_commentTableView];
        }
    }
    return self;
}

#pragma mark - 设置属性值
-(void)setListCellModel:(ListCellModel *)listCellModel
{
    _listCellModel = listCellModel;
    if (!_listCellModel) {
        return;
    }
    [self.headBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",_listCellModel.headIconStr]] forState:UIControlStateNormal];
    self.nameLab.text = _listCellModel.userNameStr;
    self.timeLab.text = _listCellModel.publishTimeStr;
    
    //上边三个的y值都确定了，剩下文字、图片、评论、点赞等内容进行设置
    [self.contentLab setLongString:_listCellModel.contentStr withFitWidth:ContentWidth maxHeight:ContentLabelMaxHeight];
    
    CGFloat curBottomY = self.contentLab.bottom +15;
    
    //设置媒体图片
    //(如果有图片的话设置，否则隐藏该控件，此处假设有数据)
    if (listCellModel.pictures.count >0) {
        CGFloat mediaHeight = [ListCell contentMediaHeightWithListCellModel:listCellModel];
        CGFloat mediaWidth = ContentWidth;
        [self.mediaView setFrame:CGRectMake(ListCellLeftMargin, curBottomY, mediaWidth, mediaHeight)];
        curBottomY = self.mediaView.bottom;
        [_mediaView reloadData];
        self.mediaView.hidden = NO;
    }else
    {
        if (self.mediaView) {
            self.mediaView.hidden = YES;
        }
    }
    
    
    //设置点赞和评论按钮
    _likeBtn.top = curBottomY;
    _commentBtn.top = curBottomY;
    
    curBottomY += LikeBtnHeight+15;
    
    //设置点赞
    if (listCellModel.like_users.count > 0)
    {
        _likeUsersView.frame = CGRectMake(ListCellLeftMargin, curBottomY, ContentWidth, 35);
    }
    else
    {
        _likeUsersView.frame = CGRectMake(ListCellLeftMargin, curBottomY, ContentWidth, 0);
    }
    [_likeUsersView reloadData];
    curBottomY = self.likeUsersView.bottom ;
    //点赞评论分割线
    if (listCellModel.like_users.count > 0)
    {
        _likeAndCommentSeparateLine.frame = CGRectMake(ListCellLeftMargin, curBottomY, ContentWidth, 1);
    }
    else
    {
        _likeAndCommentSeparateLine.frame = CGRectMake(ListCellLeftMargin, curBottomY, ContentWidth, 0);
    }
    curBottomY = _likeAndCommentSeparateLine.bottom;
    
    [self.commentTableView setFrame:CGRectMake(ListCellLeftMargin, curBottomY, kCommentCell_CotentWidth, [ListCell contentCommentListHeightWihtListCellModel:listCellModel]-15)];
    [_commentTableView reloadData];
//    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, curBottomY-16, kDeviceWidth, 1)];
//    lineView.backgroundColor = [UIColor colorWithHex:@"#eeeeee"];
//    [self.contentView addSubview:lineView];
    
//    [self.likeBtn setTitle:_listCellModel.likeNumStr forState:UIControlStateNormal];
//    [self.commentBtn setTitle:_listCellModel.commentNumStr forState:UIControlStateNormal];
    
}

#pragma mark - 计算cell的高度
+(CGFloat)cellHeightWithObj:(id)obj
{
    ListCellModel *listModel = (ListCellModel *)obj;
    CGFloat cellHeight = 0;
    cellHeight += 0;
    cellHeight += ListCell_PadingTop;
    cellHeight += [self contentLabelHeightWithListCellModel:listModel];
    cellHeight += [self contentMediaHeightWithListCellModel:listModel];
    cellHeight += [self contentCommentListHeightWihtListCellModel:listModel];
    cellHeight += [self contentLikeUserCellHeightwithListCellModel:listModel];
    cellHeight += [self contentLikeAndCommnentBtnHeight];
    cellHeight += 15;
    return cellHeight;
}
//文本
+(CGFloat)contentLabelHeightWithListCellModel:(ListCellModel *)listCellModel
{
    CGFloat height = 0;
    if (listCellModel.contentStr.length > 0) {
       height += [listCellModel.contentStr getHeightWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(kDeviceWidth-30, CGFLOAT_MAX)];
        height += 15;
    }
    return height;
}
//媒体图片
+(CGFloat)contentMediaHeightWithListCellModel:(ListCellModel *)listCellModel
{
    CGFloat contentMediaHeigth = 0;
//    if (mediaCount>0) {
//        contentMediaHeigth =  (mediaCount==0)?0:ceilf(((float)mediaCount-1)/3*ListMediaItemWidth + 3.0)-3.0;
//        contentMediaHeigth += 15;
//    }
    contentMediaHeigth = ((listCellModel.pictures.count-1)/3+1)*(ListMediaItemWidth+3.0)-3.0;
    contentMediaHeigth += 15;
    return contentMediaHeigth;
}
//点赞列表高度
+(CGFloat)contentLikeUserCellHeightwithListCellModel:(ListCellModel *)listCellModel
{
    CGFloat contentLikeHeight = 0;
    if (listCellModel.like_users.count > 0) {
        contentLikeHeight = 35;
    }else
    {
        contentLikeHeight = 0;
    }
    return contentLikeHeight;
}
//评论列表的高度
+(CGFloat)contentCommentListHeightWihtListCellModel:(ListCellModel *)listCellModel
{
    CGFloat contentCommentHeight = 0;
//    contentCommentHeight =
    NSArray *commentArr = listCellModel.comment_list;
    for (int i=0; i<commentArr.count; i++) {
//        CommentCellModel *model = (CommentCellModel *)commentArr[i];
//        contentCommentHeight += [CommentCell cellHeightWithObj:model];
        
        contentCommentHeight += [CommentCell cellHeightWithObj:listCellModel.comment_list[i]];
    }
    contentCommentHeight += 15;
    return contentCommentHeight;
}
//点赞、评论高度
+(CGFloat)contentLikeAndCommnentBtnHeight
{
    return LikeBtnHeight + 15;
}
#pragma mark - UICollectionView 代理、数据源方法
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == _mediaView) {
        return self.listCellModel.pictures.count;
    }
    else
    {
        return self.listCellModel.like_users.count;
    }
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == _mediaView) {
        ListMediaItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ListMediaItemCellIdentifier forIndexPath:indexPath];
        cell.mediaImgStr = self.listCellModel.pictures[indexPath.item];
        return cell;
    }
    else
    {
        LikeUsersCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:LikeUserCellIdentifier forIndexPath:indexPath];
        UserModel *usermodel = self.listCellModel.like_users[indexPath.item];
        [cell configWithUserModel:usermodel];
        return cell;
    }
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == _mediaView) {
        return CGSizeMake(ListMediaItemWidth, ListMediaItemWidth);
    }
    else
    {
        return CGSizeMake(35, 35);
    }
    
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 3.0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 2.0;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == _mediaView) {
        NSLog(@" mediaView  %zi",indexPath.item);
        ListMediaItemCell *cell = (ListMediaItemCell *)[collectionView cellForItemAtIndexPath:indexPath];
        //点击某一个图片
        if ([self.imgDelegate respondsToSelector:@selector(ClickCollectionViewItemActionWithItemIndex:andPictres:andTapImg:andSourceSuperView:)]) {
            [self.imgDelegate ClickCollectionViewItemActionWithItemIndex:indexPath.item andPictres:self.listCellModel.pictures andTapImg:cell.mediaImg.image andSourceSuperView:collectionView];
        }
    }
    else
    {
        NSLog(@" likeView %zi",indexPath.item);
    }
    
}

#define mark - UITableView(CommentCell) 代理、数据源方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _listCellModel.comment_list.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:CommentCellIdentifier];
    [cell configWithComment:_listCellModel.comment_list[indexPath.row]];
    cell.commentLabel.delegate = self;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellHeight = 0;
    CommentCellModel *curComment = _listCellModel.comment_list[indexPath.row];
    cellHeight = [CommentCell cellHeightWithObj:curComment];
    return cellHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - 点击点赞按钮
-(void)LikeBtnClikAction
{
    if (_likeBtn.selected==NO) {
        _likeBtn.selected = YES;
        NSLog(@"点赞");
    }
    else
    {
        _likeBtn.selected = NO;
        NSLog(@"取消点赞");
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
