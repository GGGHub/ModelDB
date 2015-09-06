//
//  ViewController.m
//  LSYModelDB
//
//  Created by Labanotation on 15/9/1.
//  Copyright (c) 2015年 okwei. All rights reserved.
//

#import "ViewController.h"
#import "LSYModel.h"
#import "LSYAnalysisModel.h"
#import <objc/runtime.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    LSYModel *model = [[LSYModel alloc] init];
    LSYAnalysisModel *analysisModel = [[LSYAnalysisModel alloc] init];
    NSLog(@"%@",[analysisModel propertyListOfDatabase:model]);
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
