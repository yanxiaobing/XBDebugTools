//
//  XBExceptionViewController.m
//  XBExceptionHandler
//
//  Created by XBingo on 2017/12/13.
//  Copyright © 2017年 XBingo. All rights reserved.
//

#import "XBExceptionViewController.h"
#import "XBExceptionHandler.h"
#import "XBExceptionDetailsViewController.h"

@interface XBExceptionViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) UITableView *tableView;

@property (nonatomic ,strong) NSArray *dataSource;

@end

@implementation XBExceptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Crash 日志";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
    
    _dataSource = [[XBExceptionHandler sharedInstance] crashInfoList];
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];
    [self.view addSubview:_tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class) forIndexPath:indexPath];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    XBExceptionInfo *info = _dataSource[indexPath.row];
    cell.textLabel.text = info.name;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    XBExceptionDetailsViewController *detailsVC = [[XBExceptionDetailsViewController alloc]init];
    detailsVC.info = _dataSource[indexPath.row];
    [self.navigationController pushViewController:detailsVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


+(void)present{
    XBExceptionViewController *exceptionVC = [XBExceptionViewController new];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:exceptionVC];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:nil];
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
