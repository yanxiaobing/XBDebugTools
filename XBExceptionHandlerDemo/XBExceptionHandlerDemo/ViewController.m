//
//  ViewController.m
//  XBExceptionHandlerDemo
//
//  Created by XBingo on 2018/1/6.
//  Copyright © 2018年 XBingo. All rights reserved.
//

#import "ViewController.h"
#import "XBDebugTools.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)crash:(UIButton *)sender {
    NSArray *arr = @[@(1)];
    NSLog(@"%@",arr[3]);
}


- (IBAction)showDebugInfo:(UIButton *)sender {
    
    [[XBDebugTools sharedInstance] showExceptionTools];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
