//
//  LSYAnalysisModel.h
//  LSYModelDB
//
//  Created by Labanotation on 15/9/6.
//  Copyright (c) 2015年 okwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSYAnalysisModel : NSObject
-(NSArray *)propertyTypeListOfModel:(id) model;
-(NSArray *)propertyNameListOfModel:(id) model;
-(NSString *)propertyListOfDatabase:(id) model;
@end
