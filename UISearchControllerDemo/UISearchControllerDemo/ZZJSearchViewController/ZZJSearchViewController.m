//
//  ZZJSearchViewController.m
//  UISearchControllerDemo
//
//  Created by JOE on 2017/6/15.
//  Copyright © 2017年 ZZJ. All rights reserved.
//

#import "ZZJSearchViewController.h"
#import "ZZJSearchTableViewCell.h"
#import "ZZJTempViewController.h"

@interface ZZJSearchViewController ()<UISearchResultsUpdating,UISearchBarDelegate,UISearchControllerDelegate,UITableViewDelegate,UITableViewDataSource>

@end

@implementation ZZJSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initSearchController];
    [self configHistoryArray];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.searchController.active = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    //在viewWillDisappear中要将UISearchController移除, 否则切换到下一个View中, 搜索框仍然会有短暂的存在
    
    if (self.searchController.active) {
        self.searchController.active = NO;
        [self.searchController.searchBar removeFromSuperview];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initSearchController {
    //初始化UISearchController
    
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchController.searchResultsUpdater = self;
    _searchController.searchBar.delegate = self;
    _searchController.delegate = self;
    _searchController.searchBar.placeholder = @"请输入要查找的内容";
    _searchController.dimsBackgroundDuringPresentation = NO;
    [_searchController.searchBar sizeToFit];
    _searchController.searchBar.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = _searchController.searchBar;
}

- (void)configHistoryArray {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.historyArray = [NSArray arrayWithArray:[userDefaults objectForKey:@"myHistoryArray"]];
    
    NSLog(@"historyArray=%@",self.historyArray);
}

- (void)configDataArray {
    //NSArray *array = @[@"A",@"B",@"C",@"D"];
    self.dataArray = [NSMutableArray array];
    [self.tableView reloadData];
}

#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSLog(@"搜索内容：%@",searchController.searchBar.text);
    [self configDataArray];//向服务器请求数据
}

#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"点击search按钮");
    [self saveSearchTextWith:searchBar.text];
    //[self configDataArray];//向服务器请求数据
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"点击cancel按钮");
    [self configHistoryArray];
    //[self configDataArray];
}

#pragma mark - UISearchControllerDelegate
- (void)didPresentSearchController:(UISearchController *)searchController {
    [self.searchController.searchBar becomeFirstResponder];
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
//通过UISearchController的active属性来判断, 即判断输入框是否处于active状态

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (!self.searchController.active) {
        return SW(200);
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, SW(200))];
    header.backgroundColor = [UIColor whiteColor];
    
    UILabel *title = [[UILabel alloc] initWithFrame:header.frame];
    title.text = @"历史搜索";
    title.textColor = [UIColor blackColor];
    title.font = [UIFont boldSystemFontOfSize:SW(80)];
    title.textAlignment = NSTextAlignmentLeft;
    [header addSubview:title];
    
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (!self.searchController.active) {
        return SW(300);
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, SW(300))];
    
    UIButton *clearHisroty = [[UIButton alloc] initWithFrame:footer.frame];
    [clearHisroty setTitle:@"清除历史记录" forState:UIControlStateNormal];
    [clearHisroty setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [clearHisroty addTarget:self action:@selector(clearHistory:) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:clearHisroty];
    
    return footer;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (!self.searchController.active) {
        return self.historyArray.count;
    }else{
        if (self.dataArray.count <= 0) {
            return 0;
        }else{
            return self.dataArray.count;
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZZJSearchTableViewCell *cell = [[ZZJSearchTableViewCell alloc] init];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    // 根据UISearchController的active属性来判断cell中的内容
    if (!self.searchController.active) {
        [cell configCellWith:[self.historyArray objectAtIndex:indexPath.row]];
    }else{
        if (self.dataArray.count <= 0) {
            //[cell configCellWith:@"没有查找的内容"];
        }else{
            [cell configCellWith:[self.dataArray objectAtIndex:indexPath.row]];
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ZZJSearchTableViewCell heightForCell];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了第 %lu 行。",indexPath.row);
    
    ZZJTempViewController *vc = [[ZZJTempViewController alloc] init];
    if (!self.searchController.active) {
        vc.title = self.historyArray[indexPath.row];
    }else{
        vc.title = self.dataArray[indexPath.row];
    }
    
    int r = (arc4random()%256);
    int g = (arc4random()%256);
    int b = (arc4random()%256);
    vc.view.backgroundColor = RGB(r, g, b);
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 搜索历史
- (void)saveSearchTextWith:(NSString *)searchText {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    NSArray *myHistoryArray = [[NSArray alloc] initWithArray:[userDefaults objectForKey:@"myHistoryArray"]];
    
    // NSArray --> NSMutableArray
    NSMutableArray *searchTextArray = [NSMutableArray array];
    searchTextArray = [myHistoryArray mutableCopy];
    
    BOOL isEqualTo1 = NO;
    BOOL isEqualTo2 = NO;
    
    if (searchTextArray.count > 0) {
        isEqualTo2 = YES;
        //判断搜索内容是否存在，存在的话放到数组最后一位，不存在的话添加
        for (NSString *str in myHistoryArray) {
            if ([searchText isEqualToString:str]) {
                //获取指定对象的索引
                NSUInteger index = [myHistoryArray indexOfObject:searchText];
                [searchTextArray removeObjectAtIndex:index];
                [searchTextArray addObject:searchText];
                isEqualTo1 = YES;
                break;
            }
        }
    }
    
    if (!isEqualTo1 || !isEqualTo2) {
        [searchTextArray addObject:searchText];
    }
    
    if (searchTextArray.count > 5) {
        [searchTextArray removeObjectAtIndex:0];
    }
    
    //将上述数据全部存储到NSUserDefaults中
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:searchTextArray forKey:@"myHistoryArray"];
}

#pragma mark - 清空搜索历史
- (void)clearHistory:(UIButton *)button {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *myHistoryArray = [userDefaults arrayForKey:@"myHistoryArray"];
    NSMutableArray *searchTextArray = [myHistoryArray mutableCopy];
    [searchTextArray removeAllObjects];
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:searchTextArray forKey:@"myHistoryArray"];
    
    [self configHistoryArray];
    [self.tableView reloadData];
    
    NSLog(@"清除历史记录");
}

#pragma mark - lazy
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (NSArray *)historyArray {
    if (!_historyArray) {
        _historyArray = [[NSArray alloc] init];
    }
    return _historyArray;
}

@end
