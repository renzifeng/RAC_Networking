//
//  ViewController.m
//  RAC-Network
//
//  Created by 任子丰 on 15/10/10.
//  Copyright © 2015年 任子丰. All rights reserved.
//

#import "ViewController.h"
#import "RequestViewModel.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) RequestViewModel *requesViewModel;
@end

@implementation ViewController


- (RequestViewModel *)requesViewModel
{
    if (_requesViewModel == nil) {
        _requesViewModel = [[RequestViewModel alloc] init];
    }
    return _requesViewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 创建tableView
    _tableView.dataSource = self.requesViewModel;
    _tableView.delegate = self.requesViewModel;
    self.requesViewModel.tableView = _tableView;
    [self.view addSubview:_tableView];
    
    // 执行请求
    [self.requesViewModel.reuqesCommand execute:nil];
    
}

@end
