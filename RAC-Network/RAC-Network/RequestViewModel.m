//
//  RequestViewModel.m
//  RAC-Network
//
//  Created by 任子丰 on 15/10/13.
//  Copyright © 2015年 任子丰. All rights reserved.
//

#import "RequestViewModel.h"
#import "Book.h"

@implementation RequestViewModel

- (instancetype)init
{
    if (self = [super init]) {
        
        [self initialBind];
    }
    return self;
}


- (void)initialBind
{
    _reuqesCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *requestSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
            parameters[@"q"] = @"基础";
            [[HttpManager sharedHttpManager] sendRequestWithDic:parameters opt:OPT_GET shortURL:@"v2/book/search" setSuccessBlock:^(NSDictionary *responseDic) {
                // 请求成功调用
                // 把数据用信号传递出去
                [subscriber sendNext:responseDic];
                [subscriber sendCompleted];
                
            } setFailBlock:^(id obj) {
                
            }];
            return nil;
        }];
        
        // 在返回数据信号时，把数据中的字典映射成模型信号，传递出去
        return [requestSignal map:^id(NSDictionary *value) {
            NSMutableArray *dictArr = value[@"books"];
            //字典转模型，遍历字典中的所有元素，全部映射成模型，并且生成数组
            NSMutableArray *modelArr = [Book objectArrayWithKeyValuesArray:dictArr];
            return modelArr;
        }];
        
    }];
    
    // 获取请求的数据
    [_reuqesCommand.executionSignals.switchToLatest subscribeNext:^(NSArray *x) {
        
        // 有了新数据，刷新表格
        _models = x;
        
        // 刷新表格
        [self.tableView reloadData];
        
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    Book *book = self.models[indexPath.row];
    cell.detailTextLabel.text = book.subtitle;
    cell.textLabel.text = book.title;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
