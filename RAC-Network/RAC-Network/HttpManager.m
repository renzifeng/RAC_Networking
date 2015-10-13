//
//  HttpManager.m
//  RAC-Network
//
//  Created by 任子丰 on 15/10/13.
//  Copyright © 2015年 任子丰. All rights reserved.
//

#import "HttpManager.h"

@implementation HttpManager

SingletonM(HttpManager)

-(AFHTTPRequestOperation *)sendRequestWithDic:(NSDictionary *)infoDic opt:(NSString *)opt shortURL:(NSString *)url setSuccessBlock:(void(^)(NSDictionary * responseDic))success_block setFailBlock:(void (^)(id obj))fail_block
{

    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",BASE_URL,url];
    
    AFHTTPRequestOperation * operation = nil;
    
    if ([opt isEqualToString:OPT_POST]) {
        operation =  [[AFHTTPRequestOperationManager manager]
                      POST:urlStr parameters:infoDic
                      success:^(AFHTTPRequestOperation *operation, id responseObject) {
                          [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                          NSDictionary * getDic;
                          if ([responseObject isKindOfClass:[NSDictionary class]]) {
                              getDic = (NSDictionary *)responseObject;
                          }else {
                              return ;
                          }
                          
                          NSLog(@"__HTTPClient__Success__:%@",getDic);
                          
                          if (success_block) {
                              success_block(getDic);
                          }
        
                      }
                      failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                          [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                          if (fail_block) {
                              fail_block(error);
                              NSLog(@"__HTTPClient__Failure__:%@",error.localizedDescription);
                          }
        }];
    }
    else if ([opt isEqualToString:OPT_GET])
    {
        operation = [[AFHTTPRequestOperationManager manager]
                     GET:urlStr parameters:infoDic
                     success:^(AFHTTPRequestOperation *operation, id responseObject) {
                         [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                         NSDictionary * getDic;
                         if ([responseObject isKindOfClass:[NSDictionary class]]) {
                             getDic = (NSDictionary *)responseObject;
                         }else {
                             return ;
                         }
                         NSLog(@"__HTTPClient__Success__:%@",getDic);
                         
                         if (success_block) {
                             success_block(getDic);
                         }
            
                     }
                     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                         if (fail_block) {
                             fail_block(error);
                             NSLog(@"__HTTPClient__Failure__:%@",error);
                         }
                         [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        }];
    }
    return operation;
}

@end
