//
//  ViewController.m
//  TableviewCellCalculateHeightDemo
//
//  Created by 马浩哲 on 16/8/18.
//  Copyright © 2016年 junanxin. All rights reserved.
//

#import "ViewController.h"
#import "common.h"
#import "ListCell.h"
#import "ListCellModel.h"
#import "CommentCellModel.h"
#import "PhotoBrowserVC.h"

#define ListCellIdentifier @"listCell"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,ListCellImgDelegate,PhotoBrowserVCDelegate>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *listDataArr;

@property (nonatomic, strong) NSMutableArray *currentImgsArr;

@property (nonatomic, strong) UIImage *tapImg;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentImgsArr = [[NSMutableArray alloc] init];
    [self loadSubViews];
}

#pragma mark - 获取数据
-(NSMutableArray *)listDataArr
{
    if (_listDataArr == nil) {
        _listDataArr = [[NSMutableArray alloc] init];
        NSArray *dataArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ListDataPlist.plist" ofType:nil]];
        NSMutableArray *mutableArr = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in dataArr) {
            ListCellModel *model = [[ListCellModel alloc] init];
            model = [model makeListCellModelWithDic:dic];
            [mutableArr addObject:model];
        }
        _listDataArr = [NSMutableArray arrayWithArray:mutableArr];
    }
    return _listDataArr;
}

#pragma mark - 加载视图
-(void)loadSubViews
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[ListCell class] forCellReuseIdentifier:ListCellIdentifier];
//    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:_tableView];
}
#pragma mark - UITableView 代理、数据源方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listDataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListCell *cell = [tableView dequeueReusableCellWithIdentifier:ListCellIdentifier];
    cell.imgDelegate = self;
    if (cell == nil) {
        cell = [[ListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ListCellIdentifier];
    }
    [cell setListCellModel:_listDataArr[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListCellModel *cellModel = _listDataArr[indexPath.row];
    return [ListCell cellHeightWithObj:cellModel];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    ListCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    NSLog(@"%zi",indexPath.row);
}

#pragma mark - 点击媒体图片调出图片浏览器
-(void)ClickCollectionViewItemActionWithItemIndex:(NSInteger)index andPictres:(NSMutableArray *)imgsArray andTapImg:(UIImage *)img andSourceSuperView:(UIView *)sourceView
{
    _currentImgsArr = imgsArray;
    _tapImg = img;
    PhotoBrowserVC *browerVC = [[PhotoBrowserVC alloc] init];
    browerVC.imageCount = imgsArray.count;
    browerVC.currentImageIndex = index;
    browerVC.delegate = self;
    browerVC.sourceImagesContainerView = sourceView;
    [browerVC show];
}

#pragma mark - 设置图片浏览器中的图片
-(NSURL *)getImageUrlWithImgIndex:(NSInteger)index
{
    return _currentImgsArr[index];
}
-(UIImage *)getTapImageWithIndex:(NSInteger)index
{
    return _tapImg;
}
@end
