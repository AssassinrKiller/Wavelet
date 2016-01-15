//
//  BaseModel.h
//  Wavelet
//
//  Created by dlios on 15-6-29.
//  Copyright (c) 2015年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

@property(nonatomic, copy)NSString *bId;
/**
 *  KVC的初始化方法
 *
 *  @param dic Model的字典
 *
 *  @return
 */
- (instancetype)initWithDic:(NSDictionary *)dic;

@end
