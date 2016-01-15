//
//  QCRound.h
//  Hyatt
//
//  Created by QC.L on 15/5/25.
//  Copyright (c) 2015年 QC.L. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCRoundCell.h"

// 此处设置轮播图时间
#define kImageScrollTimer 4.0f

@protocol QCRoundDelegate <NSObject>

@optional
- (void)clickedIndexPath:(NSIndexPath *)indexPath;

@end

@interface QCRound : UIView

@property (nonatomic, strong) NSTimer *timer;
/**
 *  轮播图数组
 */
@property (nonatomic, strong) NSMutableArray *imageArr;

// 轮播图代理方法
@property (nonatomic, assign) id <QCRoundDelegate> delegate;


- (void)addTimer;

- (void)removeTimer;
/**
 *  定制轮播图的cell 
 *  model为数组中所存元素, 例:数组中存的是字符串, 即model为NSString *
 *  cell为QCRoundCell类型, 直接给cell的Url赋值
 *
 *  @param configureCell
 */
- (void)configureCellBlock:(void (^)(QCRoundCell *cell, id model))configureCell;

- (void)changeFrame:(CGRect)frame;

@end
