//
//  SaveDataBase.m
//  Wavelet
//
//  Created by dllo on 15/7/11.
//  Copyright (c) 2015年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "SaveDataBase.h"


@implementation SaveDataBase

+(SaveDataBase*)shareSaveDataBase{
    static SaveDataBase *dataBase = nil;
    if (dataBase ==nil) {
        dataBase = [[SaveDataBase alloc] init];
    }
    return dataBase;
}

-(BOOL)openDB{
    NSArray *sandBox= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, 1, YES);
    NSString *sanBoxPath = sandBox[0];
    NSString *document = [sanBoxPath stringByAppendingPathComponent:@"specialList.sqlite"];
    NSLog(@"%@",document);
    int result = sqlite3_open([document UTF8String], &dbPoint);
    if (result ==SQLITE_OK) {
        NSLog(@"数据库成功开启");
        return YES;
    }else{
        NSLog(@"数据库打开失败");
        return NO;
        
    }
    
    
}
-(BOOL)createTable{
    NSString *sqlStr = @"create table if not exists specialList (bId text primary key)";
    int result = sqlite3_exec(dbPoint, [sqlStr UTF8String], nil, nil, nil);
    if (result == SQLITE_OK) {
        NSLog(@"创建表格成功");
        return YES;
    }else{
        NSLog(@"创建表格失败");
        return NO;
    }
}

-(BOOL)insertSpecialListModel:(NSString *)specialList{
    NSString *sqlStr = [NSString stringWithFormat:@"insert into specialList (bId) values ('%@')",specialList];
    NSLog(@"%@", sqlStr);
    int result =sqlite3_exec(dbPoint, [sqlStr UTF8String], nil, nil, nil);
    if (result == SQLITE_OK) {
        NSLog(@"添加成功");
        return YES;
        
    }else{
//        NSLog(@"添加失败");
        return NO;
    }
}





- (NSMutableArray *)selectspecialList{
    NSString *sqlStr = @"select * from specialList";
    sqlite3_stmt *stmt = nil;
    int result = sqlite3_prepare_v2(dbPoint, [sqlStr UTF8String], -1, &stmt, nil);
    if (result ==SQLITE_OK) {
        NSMutableArray *specialArr = [NSMutableArray array];
        while (sqlite3_step(stmt)==SQLITE_ROW) {
//            int number = sqlite3_column_bytes(stmt, 0);
            const unsigned char *bId = sqlite3_column_text(stmt, 0);
            NSString *spebId =[NSString stringWithUTF8String:(const char *)bId];
            SpecialListModel *specialList = [[SpecialListModel alloc] init];
            specialList.bId = spebId;
            [specialArr addObject:specialList.bId];
        }
        return specialArr;
    }else{
        NSLog(@"查询失败");
    }
    return nil;
}

-(BOOL)selectspecialbId:(NSString *)specialList{
    NSString *sqlStr = [NSString stringWithFormat:@"select * from specialList where bId = '%@'",specialList];
    sqlite3_stmt *stmt = nil;
    int result = sqlite3_prepare_v2(dbPoint, [sqlStr UTF8String], -1, &stmt, nil);
    if (result == SQLITE_OK) {
        if (sqlite3_step(stmt) == SQLITE_ROW) {
            
            return  YES;
        }else{
            return NO;
        }

    }else{
        return NO;
    }
}

-(void)deleteSpecialList:(NSString *)specialList{
    NSString *sqlStr =[NSString stringWithFormat:@"delete from specialList where bId ='%@'",specialList];
    int result = sqlite3_exec(dbPoint, [sqlStr UTF8String], nil, nil, nil);
    if (result == SQLITE_OK) {
        NSLog(@"删除成功");
    }else{
        NSLog(@"删除失败");
    }
}




@end
