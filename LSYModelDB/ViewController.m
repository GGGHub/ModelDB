//
//  ViewController.m
//  LSYModelDB
//
//  Created by Labanotation on 15/9/1.
//  Copyright (c) 2015年 okwei. All rights reserved.
//

#import "ViewController.h"
#import "LSYModel.h"
#import <objc/runtime.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    LSYModel *model = [[LSYModel alloc] init];
    
    unsigned int count;
    objc_property_t * property = class_copyPropertyList([model class], &count);
    for ( unsigned int i = 0;i<count;i++) {
       const char *propertyName =  property_copyAttributeValue(property[i], "T");
        switch (propertyName[0])
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
                NSLog(@"NSNumber");
            }
                break;
            case '@': // Object
            {
                
                break;
                
            }
            case '{': // Struct
            { 
                
                NSLog(@"结构体");
                break; 
                
            }
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
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
