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

@interface XBDebugInfoListTableViewCell()

@property (strong, nonatomic)  UILabel *titleLab;
@property (strong, nonatomic)  UILabel *subTitleLab;
@property (nonatomic ,strong)  UIView  *lineView;

@end

@implementation XBDebugInfoListTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpSubviews];
    }
    return self;
}

-(void)setUpSubviews{
    _titleLab = [[UILabel alloc]init];
    _titleLab.font = [UIFont systemFontOfSize:16];
    _titleLab.numberOfLines = 2;
    [self.contentView addSubview:_titleLab];
    
    _subTitleLab = [[UILabel alloc]init];
    _subTitleLab.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_subTitleLab];
    
    _titleLab.textColor = [UIColor blackColor];
    _subTitleLab.textColor = [UIColor grayColor];
    
    _lineView = [[UIView alloc]init];
    _lineView.backgroundColor = [UIColor cyanColor];
    [self.contentView addSubview:_lineView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)setData:(id)data{
    _data = data;
    
    [self setNeedsLayout];
    
}

-(void)layoutSubviews{
    _titleLab.frame = CGRectMake(15, 0, self.bounds.size.width-30, self.bounds.size.height/3.0*2);
    
    _subTitleLab.frame = CGRectMake(15, self.bounds.size.height/3.0*2.0, self.bounds.size.width - 30, self.bounds.size.height/3.0-1);
    
    _lineView.frame = CGRectMake(15, self.bounds.size.height - 0.5, self.bounds.size.width, 0.5);
    
    self.backgroundColor = [UIColor whiteColor];
    
    if ([_data isKindOfClass:XBExceptionInfo.class]) {
        XBExceptionInfo *info = _data;
        _titleLab.text = info.name;
        _subTitleLab.text = info.date;
        
    }else if ([_data isKindOfClass:XBApiDebugInfo.class]){
        XBApiDebugInfo *info = _data;
        _titleLab.text = [NSString stringWithFormat:@"%@%@",info.domain,info.url];
        _subTitleLab.text = info.date;
        if (!info.succeed) {
            self.backgroundColor = [UIColor redColor];
        }
    }
}

@end
