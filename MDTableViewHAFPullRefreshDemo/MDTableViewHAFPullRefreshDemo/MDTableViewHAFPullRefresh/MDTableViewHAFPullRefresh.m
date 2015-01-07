//
//  MDTableViewHAFPullRefresh.m
//  MDTableViewHAFPullRefreshDemo
//
//  Created by midoks on 14/12/29.
//  Copyright (c) 2014年 midoks. All rights reserved.
//

#import "MDTableViewHAFPullRefresh.h"

@interface MDTableViewHAFPullRefresh(Private)
@end

@implementation MDTableViewHAFPullRefresh;
//@synthesize delegate = _delegate;

-(id) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.backgroundColor = [UIColor colorWithRed:226.0/255.0 green:231.0/255.0 blue:237.0/255.0 alpha:1.0];
        
        UILabel *labeltop = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, frame.size.height - 30.0f, frame.size.width, 20.0f)];
        labeltop.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        labeltop.font = [UIFont systemFontOfSize:12.0f];
        labeltop.textColor = [UIColor colorWithRed:87.0/255.0 green:108.0/255.0 blue:137.0/255.0 alpha:1.0];
        labeltop.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
        labeltop.shadowOffset = CGSizeMake(0.0f, 1.0f);
        labeltop.backgroundColor = [UIColor clearColor];
        labeltop.textAlignment = NSTextAlignmentCenter;
        [self addSubview:labeltop];
        _lastUpdateLabel = labeltop;
        
        labeltop = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, frame.size.height - 48.0f, self.frame.size.width, 20.0f)];
        labeltop.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        labeltop.font = [UIFont boldSystemFontOfSize:13.0f];
        labeltop.textColor = [UIColor colorWithRed:87.0/255.0 green:108.0/255.0 blue:137.0/255.0 alpha:1.0];
        labeltop.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
        labeltop.shadowOffset = CGSizeMake(0.0f, 1.0f);
        labeltop.backgroundColor = [UIColor clearColor];
        labeltop.textAlignment = NSTextAlignmentCenter;
        [self addSubview:labeltop];
        _statusLabel = labeltop;
        
        
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(25.0f, frame.size.height - 65.0f, 30.0f, 55.0f);
        layer.contentsGravity = kCAGravityResizeAspect;
        layer.contents = (id)[UIImage imageNamed:@"blueArrow.png"].CGImage;
        [[self layer] addSublayer:layer];
        _arrowImage = layer;
        
        UIActivityIndicatorView *view = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        view.frame = CGRectMake(30.0f, frame.size.height - 38.0f, 20.0f, 20.0f);
        [self addSubview:view];
        _activityView = view;
        
        [self setState:MDHAFRefreshHNormal];
    }
    return self;
}


-(void)setView:(UIView *)view
{
    _view = view;
    //上拉
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.frame.size.width, 60.0f)];
    //bottomView.backgroundColor = [UIColor colorWithRed:226.0/255.0 green:231.0/255.0 blue:237.0/255.0 alpha:1.0];
    //bottomView.hidden = YES;
    _bView = bottomView;
    
    UILabel *bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 20.0f, bottomView.frame.size.width, 20.0f)];
    bottomLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    bottomLabel.font = [UIFont systemFontOfSize:12.0f];
    bottomLabel.textColor = [UIColor colorWithRed:87.0/255.0 green:108.0/255.0 blue:137.0/255.0 alpha:1.0];
    bottomLabel.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
    bottomLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
    bottomLabel.backgroundColor = [UIColor clearColor];
    bottomLabel.textAlignment = NSTextAlignmentCenter;
    //bottomLabel.text = @"更新时间";
    [bottomView addSubview:bottomLabel];
    _bLastUpdateLabel = bottomLabel;
    
    bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, bottomView.frame.size.width, 20.0f)];
    bottomLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    bottomLabel.font = [UIFont boldSystemFontOfSize:13.0f];
    bottomLabel.textColor = [UIColor colorWithRed:87.0/255.0 green:108.0/255.0 blue:137.0/255.0 alpha:1.0];
    bottomLabel.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
    bottomLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
    bottomLabel.backgroundColor = [UIColor clearColor];
    bottomLabel.textAlignment = NSTextAlignmentCenter;
    //bottomLabel.text = @"123";
    [bottomView addSubview:bottomLabel];
    _bStatusLabel = bottomLabel;
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(25.0f, 0.0f, 30.0f, 55.0f);
    layer.contentsGravity = kCAGravityResizeAspect;
    layer.contents = (id)[UIImage imageNamed:@"blueArrow.png"].CGImage;
    [[bottomView layer] addSublayer:layer];
    _bArrowImage = layer;
    
    UIActivityIndicatorView *bview = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    bview.frame = CGRectMake(30.0f, 20.0f, 20.0f, 20.0f);
    [bottomView addSubview:bview];
    _bActivityView = bview;
    
    [self.view addSubview:bottomView];
    [self setState:MDHAFRefreshFNormal];
}

-(void)refreshLastUpdatedDate
{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setAMSymbol:@"AM"];
    [formatter setPMSymbol:@"PM"];
    [formatter setDateFormat:@"MM/dd/yyyy hh:mm:a"];
    _lastUpdateLabel.text = [NSString stringWithFormat:@"上次更新: %@", [formatter stringFromDate:date]];
    //_bLastUpdateLabel.text = _lastUpdateLabel.text;
}

-(void)refreshBLastUpdateDate
{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setAMSymbol:@"AM"];
    [formatter setPMSymbol:@"PM"];
    [formatter setDateFormat:@"MM/dd/yyyy hh:mm:a"];
    _bLastUpdateLabel.text =[NSString stringWithFormat:@"上次更新: %@", [formatter stringFromDate:date]];
}

- (void)setState:(MDHAFRefreshState)mstate
{
    switch (mstate) {
            //下拉
        case MDHAFRefreshHNormal:
            
            if (_bRunning) {
                _statusLabel.text = @"底部更新中...";
            }else{
                _statusLabel.text = @"下拉刷新";
                [CATransaction begin];
                _arrowImage.transform = CATransform3DIdentity;
                [CATransaction commit];
                
                [_activityView stopAnimating];
                _arrowImage.hidden = NO;
                
                [self refreshLastUpdatedDate];
                _state = mstate;
            }
            break;
        case MDHAFRefreshHPull:
            if (_bRunning) {
                _statusLabel.text = @"底部更新中...";
            }else{
                _statusLabel.text = @"释放刷新";
                [CATransaction begin];
                [CATransaction setAnimationDuration:0.18f];
                _arrowImage.transform = CATransform3DMakeRotation((M_PI / 180.0) * 180.0f, 0.0f, 0.0f, 1.0f);
                [CATransaction commit];
                _state = mstate;
            }
            break;
        case MDHAFRefreshHLoading:
            
            _statusLabel.text = @"更新中...";
            if (_bRunning) {
                _statusLabel.text = @"底部更新中...";
            }else{
                
                [_activityView startAnimating];
                [CATransaction begin];
                [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
                _arrowImage.hidden = YES;
                [CATransaction commit];
                
                if (_state == MDHAFRefreshHLoading) {
                    _statusLabel.text = @"正在更新中...,不要着急!!!";
                }else
                {
                    if ([_delegate respondsToSelector:@selector(mdRefreshTableHeadTriggerRefresh:)]) {
                        [_delegate mdRefreshTableHeadTriggerRefresh:self];
                    }
                }
                _state = mstate;
                
            }
            break;
            
            //上拉
        case MDHAFRefreshFNormal:
            
            if (!_bRunning) {
                _bStatusLabel.text = @"上拉刷新";
                
                [_bActivityView stopAnimating];
                _bArrowImage.hidden = NO;
                
                [CATransaction begin];
                [CATransaction setAnimationDuration:0.18f];
                _bArrowImage.transform = CATransform3DMakeRotation((M_PI / 180.0) * 180.0f, 0.0f, 0.0f, 1.0f);
                [CATransaction commit];
                
                [self refreshBLastUpdateDate];
                _state = mstate;
            }
            break;
        case MDHAFRefreshFUp:
            
            if (!_bRunning) {
                _bStatusLabel.text = @"释放刷新";
                [CATransaction begin];
                _bArrowImage.transform = CATransform3DIdentity;
                [CATransaction commit];
                
                _state = mstate;
            }
            break;
        case MDHAFRefreshFLoading:
            
            _bStatusLabel.text = @"更新中...";
            
            if (_state == MDHAFRefreshHLoading) {
                _bStatusLabel.text = @"头部更新中...";
            }else
            {
                [_bActivityView startAnimating];
                [CATransaction begin];
                [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
                _bArrowImage.hidden = YES;
                [CATransaction commit];
                
                if (_bRunning) {
                    _bStatusLabel.text = @"正在更新中...,不要着急!!!";
                }else{
                    if ([_delegate respondsToSelector:@selector(mdRefreshTableFootTriggerRefresh:)])
                    {
                        [_delegate mdRefreshTableFootTriggerRefresh:self];
                    }
                }
                _bRunning = YES;
                _state = mstate;
            }
            break;
        default:
            break;
    }
    
}

-(void)mdRefreshScrollViewDidScroll:(UIScrollView *)scrollView
{
    [self bottomFollow:scrollView];
    
    if (_state == MDHAFRefreshHLoading)
    {
        CGFloat offset = MAX(scrollView.contentOffset.y * -1, 0);
        offset = MIN(offset, 60);
        scrollView.contentInset = UIEdgeInsetsMake(offset, 0.0f, 0.0f, 0.0f);
    }
    //    else if (_state == MDHAFRefreshHLoading)
    //    {
    //        scrollView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, 60.0f, 0.0f);
    //    }
    else if(scrollView.dragging)
    {
        double bottomLimitStart = scrollView.contentSize.height + self.frame.origin.y;
        double bottomLimitEnd = bottomLimitStart + 65.0f;
        //NSLog(@"start: %f, end: %f", bottomLimitStart, bottomLimitEnd);
        
        //下拉部分
        if (scrollView.contentOffset.y > -65.0f && scrollView.contentOffset.y < 0.0f)
        {
            [self setState:MDHAFRefreshHNormal];
        }
        else if (scrollView.contentOffset.y < -65.0f)
        {
            [self setState:MDHAFRefreshHPull];
        }
        //上拉部分
        else if (scrollView.contentOffset.y >= bottomLimitEnd)
        {
            [self setState:MDHAFRefreshFUp];
        }
        else if(scrollView.contentOffset.y < bottomLimitEnd && scrollView.contentOffset.y >= bottomLimitStart)
        {
            [self setState:MDHAFRefreshFNormal];
        }
    }
    
    //NSLog(@"%d: %d", _state , MDHAFRefreshHLoading);
}

-(void)mdRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView
{
    [self bottomFollow:scrollView];
    
    if (scrollView.contentOffset.y <= -65.0f) {
        [self setState:MDHAFRefreshHLoading];
    }else if (scrollView.contentOffset.y >= (scrollView.contentSize.height + self.frame.origin.y + 65.0f)){
        scrollView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, 61.0f, 0.0f);
        [self setState:MDHAFRefreshFLoading];
    }
}

-(void)bottomFollow:(UIScrollView *)scrollView
{
    _scrollView = scrollView;
    _currentY = scrollView.contentOffset.y - (scrollView.contentSize.height + self.frame.origin.y);
    _bView.frame = CGRectMake(0.0f, self.frame.size.height - _currentY , self.frame.size.width, 60.0f);
}

//头部加载完成
-(void)mdHeadOK
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.3f];
    [_scrollView setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
    [UIView commitAnimations];
    [self setState:MDHAFRefreshHNormal];
}

//底部加载完
-(void)mdFootOK
{
    _bRunning = NO;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.3f];
    [_scrollView setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
    [UIView commitAnimations];
    [self setState:MDHAFRefreshFNormal];
}

@end
