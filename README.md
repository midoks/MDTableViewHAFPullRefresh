MDTableViewHAFPullRefresh
=========================

### 使用步骤

- 引入

	#import "MDTableViewHAFPullRefresh.h"

- 申明变量

	MDTableViewHAFPullRefresh *_refreshHAFView;

- 初始化

	if (!_refreshHAFView) {
        
        //NSLog(@"%@", NSStringFromCGRect(self.tableView.frame));
        MDTableViewHAFPullRefresh *view = [[MDTableViewHAFPullRefresh alloc] initWithFrame:CGRectMake(0.0f, 0.0f-self.tableView.bounds.size.height, self.tableView.bounds.size.width, self.tableView.bounds.size.height)];
        view.delegate = self;
        view.view = self.view;
        _refreshHAFView = view;
        [self.tableView addSubview:view];
    }