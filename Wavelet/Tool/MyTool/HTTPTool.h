//
//  HTTPTool.h
//  Wavelet
//
//  Created by dlios on 15-6-29.
//  Copyright (c) 2015年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, HTTPStyle) {
    HTTP,
    JSON,
    XML
};
typedef NS_ENUM(NSInteger, RequestBodyStyle) {
    StringBody,
    JSONBody
};
@interface HTTPTool : NSObject

/**
 *  网络请求get
 *
 *  @param url     请求url
 *  @param body    网络请求携带的body
 *  @param style   请求返回的数据的格式
 *  @param success 成功调用的Block
 *  @param failure 失败调用的Block
 */

+ (void)get:(NSString *)url
       body:(id)body
 httpResult:(HTTPStyle)style
    success:(void(^)(id result))success
    failure:(void(^)(NSError *error))failure;

/**
 *  网络请求post
 *
 *  @param url       请求的url
 *  @param body      请求需携带的body内容
 *  @param style     网络请求返回的数据类型
 *  @param bodyStyle 网络请求body的类型
 *  @param success   成功调用的Block
 *  @param failure   失败调用的Block
 */

+ (void)post:(NSString *)url
        body:(id)body
  httpResult:(HTTPStyle)style
requestBodyStyle:(RequestBodyStyle)bodyStyle
    httpHead:(NSDictionary *)dic
     success:(void(^)(id result))success
     failure:(void(^)(NSError *error))failure;
@end
