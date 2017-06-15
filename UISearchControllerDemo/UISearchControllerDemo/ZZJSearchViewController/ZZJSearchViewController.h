//
//  ZZJSearchViewController.h
//  UISearchControllerDemo
//
//  Created by JOE on 2017/6/15.
//  Copyright © 2017年 ZZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZJSearchViewController : UIViewController

@property (nonatomic,strong) UISearchController *searchController;
@property (nonatomic,strong) NSMutableArray *dataArray;//数据源
@property (nonatomic,strong) NSArray *historyArray;//搜索历史

@property (nonatomic,strong) UITableView *tableView;

@end
