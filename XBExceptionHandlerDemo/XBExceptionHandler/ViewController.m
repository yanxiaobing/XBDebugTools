//
//  ViewController.m
//  XBExceptionHandler
//
//  Created by XBingo on 2017/12/13.
//  Copyright © 2017年 XBingo. All rights reserved.
//

#import "ViewController.h"
#import "XBExceptionHandler.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnClick:(id)sender {
    
    [[XBExceptionHandler sharedInstance] showExceptionTool];
    
//    NSArray *arr = @[@"1"];
//
//    NSLog(@"%@",arr[3]);
//    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    window.windowLevel =  UIWindowLevelStatusBar + 1;
//    window.hidden = NO;
//    XBViewController * rvc = [[XBViewController alloc] init];
//    window.rootViewController = rvc;
}

@end
