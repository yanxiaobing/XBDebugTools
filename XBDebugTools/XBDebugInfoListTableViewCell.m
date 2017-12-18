//
//  XBDebugInfoListTableViewCell.m
//  XBExceptionHandler
//
//  Created by XBingo on 2017/12/18.
//  Copyright © 2017年 XBingo. All rights reserved.
//

#import "XBDebugInfoListTableViewCell.h"
#import "XBExceptionInfo.h"
#import "XBApiDebugInfo.h"

@implementation XBDebugInfoListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setData:(id)data{
    _data = data;
    
    self.backgroundColor = [UIColor whiteColor];
    
    if ([data isKindOfClass:XBExceptionInfo.class]) {
        XBExceptionInfo *info = data;
        _titleLab.text = info.name;
        _subTitleLab.text = info.date;
    }else if ([data isKindOfClass:XBApiDebugInfo.class]){
        XBApiDebugInfo *info = data;
        _titleLab.text = info.url;
        _subTitleLab.text = info.date;
        if (!info.succeed) {
            self.backgroundColor = [UIColor redColor];
        }
    }
    
}

@end
