//
//  SaveDataBase.h
//  Wavelet
//
//  Created by dllo on 15/7/11.
//  Copyright (c) 2015年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SpecialListModel.h"
#import <sqlite3.h>
@interface SaveDataBase : NSObject
{
    sqlite3 *dbPoint;
    
    
}

+(SaveDataBase*)shareSaveDataBase;


-(BOOL)openDB;
-(BOOL)createTable;
-(BOOL)insertSpecialListModel:(NSString *)specialList;
-(NSMutableArray *)selectspecialList;
-(BOOL)selectspecialbId:(NSString *)specialList;
-(void)deleteSpecialList:(NSString *)specialList;
@end
