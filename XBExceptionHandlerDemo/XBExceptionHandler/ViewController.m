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
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    NSLog(@"%@",app_Name);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)crashClick:(id)sender {
    
    NSArray *arr = @[@(1)];
    NSLog(@"%@",arr[3]);
}

- (IBAction)btnClick:(id)sender {
    [[XBExceptionHandler sharedInstance] showExceptionTools];
}

@end
