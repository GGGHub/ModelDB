//
//  LSYDataBase.h
//  LSYModelDB
//
//  Created by Labanotation on 15/9/6.
//  Copyright (c) 2015年 okwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSYDatabase : NSObject
+(instancetype)sharedInstance;
-(void)creatDatabaseWithPath:(NSString *)path tableName:(NSString *)tableName model:(id)model;
-(BOOL)openDatabase;
-(BOOL)closeDatabase;
-(BOOL)insertModelToDatabase:(id)model;
// 数据库操作，线程不安全


// 数据库操作，线程安全
@end
