//
//  DynamicViewController.m
//  HuaYangApproval_ios
//
//  Created by jijeMac2 on 14-3-27.
//  Copyright (c) 2014年 huayang. All rights reserved.
//

#import "DynamicViewController.h"
#import "DynamicModel.h"
#import "DynamicCell.h"
#import "DatabaseManager.h"

@interface DynamicViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
@property(strong,nonatomic)NSMutableArray *dynamicDataArray;
@end

@implementation DynamicViewController

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
    self.title = @"动态";
    
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"test" ofType:@"txt"]];
    id a = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    self.dynamicDataArray = [NSMutableArray array];
    
    NSArray *weiboList = [a objectForKey:@"weiboList"];
    
    for (int i=0; i<weiboList.count; i++) {
        DynamicModel *dynamicModel = [[DynamicModel alloc] initWithDictionary:[weiboList objectAtIndex:i] weiboType:@"allmsg"];
        [self.dynamicDataArray addObject:dynamicModel];
    }
    
    //网络请求成功后，缓存数据
    [DatabaseManager saveDynamicList:self.dynamicDataArray];
    
    [self.dynamicTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark serchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    [searchBar resignFirstResponder];
}


#pragma mark tableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dynamicDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *dynamicCellId = @"DynamicCell";
    DynamicCell *cell = [tableView dequeueReusableCellWithIdentifier:dynamicCellId];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:dynamicCellId owner:self options:nil] lastObject];
    }
    
    DynamicModel *dynamicModel = [self.dynamicDataArray objectAtIndex:indexPath.row];
    [cell setDynamicData:dynamicModel];
    
    return cell;
}

#pragma mark tableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DynamicCell *cell = (DynamicCell *)[self tableView:self.dynamicTableView cellForRowAtIndexPath:indexPath];
    return [cell height];
}


@end
