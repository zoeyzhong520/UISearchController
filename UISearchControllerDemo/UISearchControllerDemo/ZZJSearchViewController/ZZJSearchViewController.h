//
//  ZZJSearchViewController.h
//  UISearchControllerDemo
//
//  Created by JOE on 2017/6/15.
//  Copyright © 2017年 ZZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RGB(r, g, b) [UIColor colorWithRed:(r) / 255.0f green:(g) / 255.0f blue:(b) / 255.0f alpha:1]
#define RGBA(r, g, b, a) [UIColor colorWithRed:(r) / 255.0f green:(g) / 255.0f blue:(b) / 255.0f alpha:(a)]

@interface ZZJSearchViewController : UIViewController

@property (nonatomic,strong) UISearchController *searchController;
@property (nonatomic,strong) NSMutableArray *dataArray;//数据源
@property (nonatomic,strong) NSArray *historyArray;//搜索历史

@property (nonatomic,strong) UITableView *tableView;

@end
