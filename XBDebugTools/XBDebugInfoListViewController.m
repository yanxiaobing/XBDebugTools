//
//  XBApiDebugListViewController.m
//  XBExceptionHandler
//
//  Created by XBingo on 2017/12/18.
//  Copyright © 2017年 XBingo. All rights reserved.
//

#import "XBDebugInfoListViewController.h"
#import "XBDebugInfoListTableViewCell.h"
#import "XBDebugDetailsViewController.h"


@interface XBDebugInfoListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) UITableView *tableView;

@property (nonatomic ,strong) UILabel *tipLabel;

@property (nonatomic ,strong) NSArray *dataSource;

@end

@implementation XBDebugInfoListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
//    if (@available(iOS 7.0, *)) {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//        self.edgesForExtendedLayout = UIRectEdgeNone;
//    } else {
//        // Fallback on earlier versions
//    }
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
    
    if (_debugType == XBDebugTypeCrashInfo) {
        self.title = @"Crash 日志列表";
        _dataSource = [[XBDebugTools sharedInstance] crashInfoList];
    }else{
        self.title = @"Api 日志列表";
        _dataSource = [[XBDebugTools sharedInstance] apiDebugInfoList];
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"仅看失败" style:UIBarButtonItemStylePlain target:self action:@selector(changeApiDataSource:)];
    }
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:XBDebugInfoListTableViewCell.class forCellReuseIdentifier:NSStringFromClass(XBDebugInfoListTableViewCell.class)];
    [self.view addSubview:_tableView];
    
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
    }
    
    _tipLabel = [[UILabel alloc]initWithFrame:self.view.bounds];
    _tipLabel.font = [UIFont systemFontOfSize:17];
    _tipLabel.textAlignment = NSTextAlignmentCenter;
    _tipLabel.text = @"暂无相关数据";
    [self.view addSubview:_tipLabel];
    
    [self showTipLabel];
}

-(void)showTipLabel{
    if (_dataSource.count <= 0) {
        _tipLabel.hidden = NO;
    }else{
        _tipLabel.hidden = YES;
    }
}

-(void)changeApiDataSource:(UIBarButtonItem *)sender{
    if ([sender.title isEqualToString:@"仅看失败"]) {
        sender.title = @"返回所有";
        NSMutableArray *list = [NSMutableArray new];
        [_dataSource enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            XBApiDebugInfo *info = obj;
            if (!info.succeed) {
                [list addObject:info];
            }
        }];
        _dataSource = list;
    }else{
        sender.title = @"仅看失败";
        _dataSource = [[XBDebugTools sharedInstance] apiDebugInfoList];
    }
    [self showTipLabel];
    [_tableView reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70.0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XBDebugInfoListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(XBDebugInfoListTableViewCell.class) forIndexPath:indexPath];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.data = _dataSource[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XBDebugDetailsViewController *debugDetailsVC = [XBDebugDetailsViewController new];
    debugDetailsVC.data = _dataSource[indexPath.row];
    [self.navigationController pushViewController:debugDetailsVC animated:YES];
    
}

+(void)presentWithType:(XBDebugType)debugType{
    XBDebugInfoListViewController *debugListVC = [XBDebugInfoListViewController new];
    debugListVC.debugType = debugType;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:debugListVC];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:nil];
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
