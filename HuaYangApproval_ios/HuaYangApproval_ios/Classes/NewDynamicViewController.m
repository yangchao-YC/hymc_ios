//
//  NewDynamicViewController.m
//  HuaYangApproval_ios
//
//  Created by jijeMac2 on 14-3-27.
//  Copyright (c) 2014年 huayang. All rights reserved.
//

#import "NewDynamicViewController.h"

@interface NewDynamicViewController ()

@end

@implementation NewDynamicViewController

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
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelNewDynamic:)];
    self.navigationItem.leftBarButtonItem = backItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)cancelNewDynamic:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
