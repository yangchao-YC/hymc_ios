//
//  LoginViewController.m
//  HuaYangApproval_ios
//
//  Created by jijeMac2 on 14-4-1.
//  Copyright (c) 2014年 huayang. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login:(id)sender
{
    UIStoryboard *s = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *c = [s instantiateViewControllerWithIdentifier:@"HomeViewController"];
    
    [[[UIApplication sharedApplication] delegate] window].rootViewController = c;
}
@end
