//
//  LSYDataBase.m
//  LSYModelDB
//
//  Created by Labanotation on 15/9/6.
//  Copyright (c) 2015年 okwei. All rights reserved.
//

#import "LSYDatabase.h"
#import "LSYAnalysisModel.h"
#import "FMDB.h"
#import <objc/runtime.h>
@interface LSYDatabase ()
@property (nonatomic,retain) LSYAnalysisModel *analysisModel;
@end
@implementation LSYDatabase
{
    FMDatabase *database;
}
+(instancetype)sharedInstance
{
    static LSYDatabase *database = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        database = [[self alloc] init];
        database.analysisModel = [[LSYAnalysisModel alloc] init];
    });
    return database;
}
-(BOOL)openDatabase
{
    return [database open];
}
-(BOOL)closeDatabase
{
    return [database close];
}
-(void)creatDatabaseWithPath:(NSString *)path tableName:(NSString *)tableName model:(id)model
{
    database = [FMDatabase databaseWithPath:path];
    if (![database open]) {
        return;
    }
    NSString *creatTale =[NSString stringWithFormat:@"create table if not exists %@ (%@_ID) integer primary key autoincrement,%@",tableName,tableName,[_analysisModel propertyListOfDatabase:model]];
    [database executeUpdate:creatTale];
}
//-(BOOL)insertModelToDatabase:(id)model
//{
//    
//}

@end
