MDTableViewHAFPullRefresh
=========================

### 说明

	这是一个iOS的tableview上下拉功能实现。这是很基本的实现,我同样在网上找个很久,并且一一测试,总感觉用起来不舒服。于是,我根据[EGOTableViewPullRefresh](https://github.com/midoks/MDTableViewHAFPullRefresh)这个开源的下拉的功能的思路,再根据自己的测试,实现了tableview的上下拉功能。

	感谢开源。


### 使用步骤

- 引入
````
	#import "MDTableViewHAFPullRefresh.h"
````
- 申明变量
````
	MDTableViewHAFPullRefresh *_refreshHAFView;
````
- 初始化
````
	if (!_refreshHAFView) {
        MDTableViewHAFPullRefresh *view = [[MDTableViewHAFPullRefresh alloc] initWithFrame:CGRectMake(0.0f, 0.0f-self.tableView.bounds.size.height, self.tableView.bounds.size.width, self.tableView.bounds.size.height)];
        view.delegate = self;
        view.view = self.view;
        _refreshHAFView = view;
        [self.tableView addSubview:view];
    }
````
- 实现代理方法
````
	-(void)scrollViewDidScroll:(UIScrollView *)scrollView
	{
	    [_refreshHAFView mdRefreshScrollViewDidScroll:scrollView];
	}

	-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
	{
	    [_refreshHAFView mdRefreshScrollViewDidEndDragging:scrollView];
	}
````
- 刷新方法Demo
````	
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
````