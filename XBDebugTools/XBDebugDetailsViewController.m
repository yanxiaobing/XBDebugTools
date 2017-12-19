//
//  XBApiDebugDetailsViewController.m
//  XBExceptionHandler
//
//  Created by XBingo on 2017/12/18.
//  Copyright © 2017年 XBingo. All rights reserved.
//

#import "XBDebugDetailsViewController.h"
#import "XBExceptionInfo.h"
#import "XBApiDebugInfo.h"

@interface XBDebugDetailsViewController ()

@property (nonatomic ,strong) NSString *objDes;

@end

@implementation XBDebugDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(share)];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64)];
    [self.view addSubview:textView];
    textView.editable = NO;
    
    if ([_data isKindOfClass:XBExceptionInfo.class]) {
        self.title = @"Crash 详情";
        XBExceptionInfo *info = _data;
        textView.text = info.description;
        _objDes = info.description;
    }else if ([_data isKindOfClass:XBApiDebugInfo.class]){
        self.title = @"Api 详情";
        
        XBApiDebugInfo *info = _data;
        textView.text = info.description;
        _objDes = info.description;
    }
}

-(void)share{
    [[UIPasteboard generalPasteboard] setString:_objDes];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
