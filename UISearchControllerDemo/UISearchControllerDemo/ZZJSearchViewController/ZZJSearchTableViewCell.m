//
//  ZZJSearchTableViewCell.m
//  UISearchControllerDemo
//
//  Created by JOE on 2017/6/15.
//  Copyright © 2017年 ZZJ. All rights reserved.
//

#import "ZZJSearchTableViewCell.h"

#define CellHeight SW(200)

@implementation ZZJSearchTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)configCellWith:(NSString *)text {
    self.backgroundColor = [UIColor clearColor];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, CellHeight)];
    view.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:view];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:view.frame];
    titleLabel.text = text;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:SW(80)];
    [view addSubview:titleLabel];
}

+ (CGFloat)heightForCell {
    return CellHeight+SW(50);
}

@end
