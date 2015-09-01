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
//        const char *propertyName = property_getAttributes(property[i]);
       const char *propertyName =  property_copyAttributeValue(property[i], "T");
        NSLog(@"%@",[NSString stringWithUTF8String:propertyName]);
    }
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
