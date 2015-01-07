//
//  ViewController.m
//  MDTableViewHAFPullRefreshDemo
//
//  Created by midoks on 14/12/29.
//  Copyright (c) 2014年 midoks. All rights reserved.
//

#import "ViewController.h"
#import "MDTableViewHAFPullRefresh.h"


@interface ViewController () <UITableViewDataSource, UITableViewDelegate, MDTableViewHAFDelegate>{
    
    MDTableViewHAFPullRefresh *_refreshHAFView;
}


@property (nonatomic, strong) UITableView *tableView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    if (!_refreshHAFView) {
        
        //NSLog(@"%@", NSStringFromCGRect(self.tableView.frame));
        MDTableViewHAFPullRefresh *view = [[MDTableViewHAFPullRefresh alloc] initWithFrame:CGRectMake(0.0f, 0.0f-self.tableView.bounds.size.height, self.tableView.bounds.size.width, self.tableView.bounds.size.height)];
        view.delegate = self;
        view.view = self.view;
        _refreshHAFView = view;
        [self.tableView addSubview:view];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource Methods -
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 16;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *signCell = @"cell";
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:signCell];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:signCell];
    }
    cell.textLabel.text = @"hello world";
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


#pragma mark - UIScrollViewDelegate Methods -
#warning UIScrollViewDelegate Methods  这个必须有...
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_refreshHAFView mdRefreshScrollViewDidScroll:scrollView];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_refreshHAFView mdRefreshScrollViewDidEndDragging:scrollView];
}

#pragma mark - Delegate Methods -

#warning 顶部刷新
- (void)mdRefreshTableHeadTriggerRefresh:(MDTableViewHAFPullRefresh *)view
{
    NSLog(@"head");
    [self performSelector:@selector(mdHeadOK) withObject:nil afterDelay:3.0f];
}

-(void)mdHeadOK
{
    [_refreshHAFView mdHeadOK];
}

#warning 底部刷新
-(void)mdRefreshTableFootTriggerRefresh:(MDTableViewHAFPullRefresh *)view
{
    NSLog(@"foot");
    [self performSelector:@selector(mdFootOK) withObject:nil afterDelay:3.0f];
}

-(void)mdFootOK
{
    [_refreshHAFView mdFootOK];
}




@end
