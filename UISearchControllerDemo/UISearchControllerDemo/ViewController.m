//
//  ViewController.m
//  UISearchControllerDemo
//
//  Created by JOE on 2017/6/15.
//  Copyright © 2017年 ZZJ. All rights reserved.
//

#import "ViewController.h"
#import "ZZJSearchViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake((self.view.bounds.size.width-200)/2, 100, 200, 50);
    [button setTitle:@"ZZJSearchViewController" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)clickButton {
    ZZJSearchViewController *vc = [[ZZJSearchViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
