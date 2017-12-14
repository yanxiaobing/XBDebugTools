//
//  XBExceptionDetailsViewController.m
//  XBExceptionHandler
//
//  Created by XBingo on 2017/12/13.
//  Copyright © 2017年 XBingo. All rights reserved.
//

#import "XBExceptionDetailsViewController.h"

@interface XBExceptionDetailsViewController ()

@end

@implementation XBExceptionDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Crash 详情";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(share)];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:textView];
    textView.text = self.info.log;
}

-(void)share{
    [[UIPasteboard generalPasteboard] setString:self.info.log];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
