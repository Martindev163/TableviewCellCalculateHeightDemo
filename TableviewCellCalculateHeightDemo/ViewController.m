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

#define ListCellIdentifier @"listCell"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *listDataArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
@end
