//
//  RequestViewModel.h
//  RAC-Network
//
//  Created by 任子丰 on 15/10/13.
//  Copyright © 2015年 任子丰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestViewModel : NSObject<UITableViewDataSource,UITableViewDelegate>

// 请求命令
@property (nonatomic, strong, readonly) RACCommand *reuqesCommand;

//模型数组
@property (nonatomic, strong, readonly) NSArray *models;

// 控制器中的view
@property (nonatomic, weak) UITableView *tableView;

@end
