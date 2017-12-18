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

@property (nonatomic ,strong) NSArray *dataSource;

@end

@implementation XBDebugInfoListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
    
    if (_debugType == XBDebugTypeCrashInfo) {
        self.title = @"Crash 日志列表";
        _dataSource = [[XBDebugTools sharedInstance] crashInfoList];
    }else{
        self.title = @"Api 日志列表";
        _dataSource = [[XBDebugTools sharedInstance] apiDebugInfoList];
    }
    
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:XBDebugInfoListTableViewCell.class forCellReuseIdentifier:NSStringFromClass(XBDebugInfoListTableViewCell.class)];
    [self.view addSubview:_tableView];
    
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
