//
//  XBDebugInfoListTableViewCell.h
//  XBExceptionHandler
//
//  Created by XBingo on 2017/12/18.
//  Copyright © 2017年 XBingo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XBDebugInfoListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLab;

@property (nonatomic ,strong) id data;

@end
