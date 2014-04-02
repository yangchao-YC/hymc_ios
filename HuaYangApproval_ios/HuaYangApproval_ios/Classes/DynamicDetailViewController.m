//
//  DynamicDetailViewController.m
//  HuaYangApproval_ios
//
//  Created by jijeMac2 on 14-4-2.
//  Copyright (c) 2014年 huayang. All rights reserved.
//

#import "DynamicDetailViewController.h"

@interface DynamicDetailViewController ()

@end

@implementation DynamicDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSLog(@"%@",self.dynamicModel);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
