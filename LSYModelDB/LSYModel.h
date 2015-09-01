//
//  LSYModel.h
//  LSYModelDB
//
//  Created by Labanotation on 15/9/1.
//  Copyright (c) 2015年 okwei. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, LSYModelGenderType)
{
    LSYModelMale,
    LSYModelFemale
};
@interface LSYModel : NSObject
@property (nonatomic,copy) NSString *name;
@property (nonatomic,assign) NSInteger age;
@property (nonatomic,assign) LSYModelGenderType type;
@property (nonatomic) BOOL type2;
@property (nonatomic,strong) NSMutableArray *array;
@end
