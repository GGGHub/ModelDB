//
//  LSYAnalysisModel.m
//  LSYModelDB
//
//  Created by Labanotation on 15/9/6.
//  Copyright (c) 2015年 okwei. All rights reserved.
//

#import "LSYAnalysisModel.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
@implementation LSYAnalysisModel


-(NSArray *)propertyTypeListOfModel:(id)model
{
    unsigned int count;
    objc_property_t * property = class_copyPropertyList([model class], &count);
    NSMutableArray *typeList = [NSMutableArray array];
    for ( unsigned int i = 0;i<count;i++) {
        const char *propertyType =  property_copyAttributeValue(property[i], "T");
        switch (propertyType[0])
        {
                
            case 'c': // Numeric types
            case 'i':
            case 's':
            case 'l':
            case 'q':
            case 'C':
            case 'I':
            case 'S':
            case 'L':
            case 'Q':
            case 'f':
            case 'd':
            case 'B':
            {
                [typeList addObject:@"NSNumber"];
            }
                break;
            case '@': // Object
            {
                [typeList addObject:[self p_CTypeConvertOCType:propertyType]];
                break;
                
            }
            case '{': // Struct
            case '*': // C-String
            case '[': // C-Array
            case '(': // Enum
            case '#': // Class
            case ':': // Selector
            case '^': // Pointer
            case 'b': // Bitfield
            case '?': // Unknown type
            default:
                @throw [NSException exceptionWithName:@"传入类型错误" reason:@"数据模型属性必须基本数据类型或Objective-C对象" userInfo:nil];
                
        }
        
        
    }
    return [typeList copy];
}
-(NSString *)propertyListOfDatabase:(id)model
{
    NSMutableString *listOfDatabase = @"".mutableCopy;
    unsigned int count;
    objc_property_t * property = class_copyPropertyList([model class], &count);
    for ( unsigned int i = 0;i<count;i++) {
        const char *propertyType =  property_copyAttributeValue(property[i], "T");
        const char *propertyName = property_getName(property[i]);
        [listOfDatabase appendString:[NSString stringWithUTF8String:propertyName]];;
        switch (propertyType[0])
        {
                
            case 'c': // Numeric types
            case 'i':
            case 's':
            case 'l':
            case 'q':
            case 'C':
            case 'I':
            case 'S':
            case 'L':
            case 'Q':
            case 'f':
            case 'd':
            case 'B':
            {
                if (i == count-1) {
                    [listOfDatabase appendString:@" integer"];
                }
                else{
                    [listOfDatabase appendString:@" integer,"];
                }
            }
                break;
            case '@': // Object
            {
                if (i == count-1) {
                     [listOfDatabase appendString:[NSString stringWithFormat:@" %@",[self p_OCTypeConvertDataBaseType:[self p_CTypeConvertOCType:propertyType]]]];
                }
                else{
                    [listOfDatabase appendString:[NSString stringWithFormat:@" %@,",[self p_OCTypeConvertDataBaseType:[self p_CTypeConvertOCType:propertyType]]]];
                }
                break;
                
            }
            case '{': // Struct
            case '*': // C-String
            case '[': // C-Array
            case '(': // Enum
            case '#': // Class
            case ':': // Selector
            case '^': // Pointer
            case 'b': // Bitfield
            case '?': // Unknown type
            default:
                @throw [NSException exceptionWithName:@"传入类型错误" reason:@"数据模型属性必须基本数据类型或Objective-C对象" userInfo:nil];
                
        }
    }
    return [listOfDatabase copy];
}
-(NSArray *)propertyNameListOfModel:(id)model
{
    unsigned int count;
    NSMutableArray *nameList = @[].mutableCopy;
    objc_property_t * property = class_copyPropertyList([model class], &count);
    for ( unsigned int i = 0;i<count;i++){
         const char *propertyName = property_getName(property[i]);
        [nameList addObject:[NSString stringWithUTF8String:propertyName]];
    }
    return [nameList copy];
}

-(NSString *)p_CTypeConvertOCType:(const char *)string
{
    NSString *objectString = [NSString stringWithUTF8String:string];
    NSArray *array;
    if ([objectString hasPrefix:@"@\""] && [objectString hasSuffix:@"\""]) {
        NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"@\""];
        array = [objectString componentsSeparatedByCharactersInSet:characterSet];
    }
    for (NSString *obj in array) {
        if (obj.length>0) {
            
            if ([obj hasSuffix:@"Array"] ||[obj hasSuffix:@"Dictional"]||[obj hasSuffix:@"Set"]) {
                @throw [NSException exceptionWithName:@"传入类型错误" reason:@"成员属性不能为一个集合，可以归档成二进制数据进行存储" userInfo:nil];
            }
            return obj;
        }
    }
    return @"";
}
-(NSString *)p_OCTypeConvertDataBaseType:(NSString *)string
{
    if ([string hasSuffix:@"Number"]) {
        return @"integer";
    }
    else if ([string hasSuffix:@"String"]){
        return @"text";
    }
    else if ([string hasSuffix:@"Data"]){
        return @"blob";
    }
    else
    {
        return @"";
    }
}
@end
