//
//  XBApiDebugListViewController.h
//  XBExceptionHandler
//
//  Created by XBingo on 2017/12/18.
//  Copyright © 2017年 XBingo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBDebugTools.h"


@interface XBDebugInfoListViewController : UIViewController

@property (nonatomic ,assign) XBDebugType debugType;

+(void)presentWithType:(XBDebugType)debugType;

@end
