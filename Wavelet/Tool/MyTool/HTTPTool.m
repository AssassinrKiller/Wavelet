//
//  HTTPTool.m
//  Wavelet
//
//  Created by dlios on 15-6-29.
//  Copyright (c) 2015年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "HTTPTool.h"
#import "AFNetworking.h"
@implementation HTTPTool
+ (void)get:(NSString *)url
       body:(id)body
 httpResult:(HTTPStyle)style
    success:(void(^)(id result))success
    failure:(void(^)(NSError *error))failure
{
    //1.获取AFN网络请求的管理类
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil]];
    
    //2.判断返回的responseObject的数据类型
    switch (style) {
            //NSData类型
        case HTTP:
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
            //XML类型
        case XML:
            manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
            break;
            //JSON类型
        case JSON:
            break;
        default:
            break;
    }
    //3.让管理类调用get请求
    [manager GET:url parameters:body success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //如果成功返回数据
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //如果失败返回error信息
        if (failure) {
            failure(error);
        }
    }];
}


+ (void)post:(NSString *)url
        body:(id)body
  httpResult:(HTTPStyle)style
requestBodyStyle:(RequestBodyStyle)bodyStyle
    httpHead:(NSDictionary *)dic
     success:(void(^)(id result))success
     failure:(void(^)(NSError *error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //判断网络请求头的字典是否为空
    if (dic) {
        //不为空遍历字典
        for (NSString *key in dic.allKeys) {
            //设置为HTTP请求头
            [manager.requestSerializer setValue:dic[key] forHTTPHeaderField:key];
        }
    }
    
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil]];
    
    switch (bodyStyle) {
        case StringBody:
            // 请求参数原样传给服务器
            [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, id parameters, NSError **error) {
                return parameters;
            }];
//            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
            break;
        case JSONBody:
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            break;
        default:
            break;
    }
    
    
    
    
    switch (style) {
        case HTTP:
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        case JSON:
            break;
        case XML:
            manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
            break;
        default:
            break;
    }
    [manager POST:url parameters:body success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
