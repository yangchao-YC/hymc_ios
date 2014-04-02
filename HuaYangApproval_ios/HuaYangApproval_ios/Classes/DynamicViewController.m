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
#import "MJRefresh.h"
#import "TSPopoverController.h"

@interface DynamicViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
@property(strong,nonatomic)NSMutableArray *dynamicDataArray;
@end

@implementation DynamicViewController
{
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
}

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
    
    NSArray *weiboTypes = @[@"所有动态",@"我发布的",@"我关注的"];
    
    NSString *columnTag = [[NSUserDefaults standardUserDefaults] objectForKey:@"DYNAMIC_TAG"];
    if (!columnTag || !columnTag.length) {
        columnTag = @"所有动态";
        [[NSUserDefaults standardUserDefaults] setObject:@"所有动态" forKey:@"DYNAMIC_TAG"];
    }
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 100, 20);
    [btn setTitle:columnTag forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(showPop:forEvent:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = btn;
    
    [self addRefreshHeader];
    [_header beginRefreshing];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark PopView
- (void)showPop:(id)sender forEvent:(UIEvent *)event
{
    UITableViewController *tableViewController = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
    tableViewController.view.frame = CGRectMake(0,0, 200, 300);
    tableViewController.view.backgroundColor = [UIColor clearColor];
    TSPopoverController *popoverController = [[TSPopoverController alloc] initWithContentViewController:tableViewController];
    
    popoverController.cornerRadius = 1;
    popoverController.popoverBaseColor = [UIColor orangeColor];
    popoverController.popoverGradient= NO;
    [popoverController showPopoverWithTouch:event];
}

#pragma mark MJRefresh
- (void)addRefreshHeader
{
    //__unsafe_unretained DynamicViewController *safe_self = self;
    
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = self.dynamicTableView;
    header.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        // 进入刷新状态就会回调这个Block
        
        //加载缓存数据
        self.dynamicDataArray = [DatabaseManager getDynamicListByWeiboType:@"allmsg"];
        
        
        //开始网络请求
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
        [_header endRefreshing];

    };
    header.endStateChangeBlock = ^(MJRefreshBaseView *refreshView) {
        // 刷新完毕就会回调这个Block
    };
    header.refreshStateChangeBlock = ^(MJRefreshBaseView *refreshView, MJRefreshState state) {
        // 控件的刷新状态切换了就会调用这个block
        switch (state) {
            case MJRefreshStateNormal:
                break;
            case MJRefreshStatePulling:
                break;
            case MJRefreshStateRefreshing:
                break;
            default:
                break;
        }
    };
    _header = header;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DynamicModel *dynamicModel = [self.dynamicDataArray objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"DynamicDetailPush" sender:dynamicModel];
}

#pragma mark 页面传值方法
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *desViewController = segue.destinationViewController;
    if ([desViewController respondsToSelector:@selector(setDynamicModel:)]) {
        [desViewController setValue:sender forKey:@"dynamicModel"];
    }
}

@end
