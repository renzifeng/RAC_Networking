//
//  HttpManager.h
//  RAC-Network
//
//  Created by 任子丰 on 15/10/13.
//  Copyright © 2015年 任子丰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

@interface HttpManager : NSObject

SingletonH(HttpManager)

/**
 *  普通网络请求 传入info字典  URL短码 实现成功回调  失败回调
 *
 *  @param infoDic       info字典
 *  @param url           短码
 *  @param opt          post/get
 *  @param success_block 成功回调
 *  @param fail_block    失败回调
 */
-(AFHTTPRequestOperation *)sendRequestWithDic:(NSDictionary *)infoDic opt:(NSString *)opt shortURL:(NSString *)url setSuccessBlock:(void(^)(NSDictionary * responseDic))success_block setFailBlock:(void (^)(id obj))fail_block;
@end
