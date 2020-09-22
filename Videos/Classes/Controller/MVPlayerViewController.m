//
//  MVPlayerViewController.m
//  Videos
//
//  Created by 胡学礼 on 2020/9/22.
//

#import "MVVideoView.h"
#import "MVVideoModel.h"
#import "MVCommentView.h"
#import "MVSlidePopupView.h"
#import "MVPlayerViewController.h"

#define kTitleViewY         (SAFEAREA_TOP + 20.0f)
// 过渡中心点
#define kTransitionCenter   20.0f
@interface MVPlayerViewController () <MVVideoViewDelegate>

@property (nonatomic, strong) UIView                *titleView;

@property (nonatomic, strong) UIView                *refreshView;
@property (nonatomic, strong) UILabel               *refreshLabel;
@property (nonatomic, strong) UIView                *loadingBgView;

@property (nonatomic, strong) MVVideoModel        *model;
@property (nonatomic, strong) NSArray               *videos;
@property (nonatomic, assign) NSInteger             playIndex;

@property (nonatomic, assign) BOOL              isRefreshing;
@end

@implementation MVPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.videoView];
    
    [self.videoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        });
    }];
    
    
    [self.view addSubview:self.titleView];
    
    [self.view addSubview:self.refreshView];
    [self.refreshView addSubview:self.refreshLabel];
    [self.view addSubview:self.loadingBgView];
    
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(SAFEAREA_TOP + 20.0f);
        make.height.mas_equalTo(44.0f);
    }];
    
    [self.refreshView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(SAFEAREA_BTM + 20.0f);
        make.height.mas_equalTo(44.0f);
    }];
    
    [self.refreshLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.refreshView);
    }];
    
    UIActivityIndicatorView* loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [loadingView startAnimating];
    
    @weakify(self);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        @strongify(self);
        
//        [loadingView stopLoading];
        [loadingView stopAnimating];
        
        [self.videoView.viewModel refreshNewListWithSuccess:^(NSArray * _Nonnull list) {
            [self.videoView setModels:list index:0];
        } failure:^(NSError * _Nonnull error) {
            
        }];
    });
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.videoView resume];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // 停止播放
    [self.videoView pause];
}

- (void)dealloc {
    [self.videoView destoryPlayer];
    
    NSLog(@"playerVC dealloc");
}


#pragma mark - GKDYVideoViewDelegate
- (void)videoView:(MVVideoView *)videoView didClickIcon:(MVVideoModel *)videoModel {
    
}

- (void)videoView:(MVVideoView *)videoView didClickPraise:(MVVideoModel *)videoModel {
    
    MVVideoModel *model = videoModel;
    
    model.isAgree = !model.isAgree;
    
    int agreeNum = model.agree_num.intValue;
    
    if (model.isAgree) {
        model.agree_num = [NSString stringWithFormat:@"%d", agreeNum + 1];
    }else {
        model.agree_num = [NSString stringWithFormat:@"%d", agreeNum - 1];
    }
    
    videoView.currentPlayView.model = videoModel;
}

- (void)videoView:(MVVideoView *)videoView didClickComment:(MVVideoModel *)videoModel {
    MVCommentView *commentView = [[MVCommentView alloc] initWithViewModel:nil];
    commentView.frame = CGRectMake(0, 0, SCREEN_WIDTH, ADAPTATIONRATIO * 980.0f);
    
    MVSlidePopupView *popupView = [MVSlidePopupView popupViewWithFrame:[UIScreen mainScreen].bounds contentView:commentView];
    commentView.delegate = popupView;
    [popupView showFrom:[UIApplication sharedApplication].keyWindow completion:^{
        [commentView requestData];
    }];
}

- (void)videoView:(MVVideoView *)videoView didClickShare:(MVVideoModel *)videoModel {
    
}

- (void)videoView:(MVVideoView *)videoView didScrollIsCritical:(BOOL)isCritical {
    
}

- (void)videoView:(MVVideoView *)videoView didPanWithDistance:(CGFloat)distance isEnd:(BOOL)isEnd {
    if (self.isRefreshing) return;
    
    if (isEnd) {
        [UIView animateWithDuration:0.25 animations:^{
            CGRect frame = self.titleView.frame;
            frame.origin.y = kTitleViewY;
            self.titleView.frame = frame;
            self.refreshView.frame = frame;
            
            CGRect loadingFrame = self.loadingBgView.frame;
            loadingFrame.origin.y = kTitleViewY;
            self.loadingBgView.frame = loadingFrame;
            
            self.refreshView.alpha      = 0;
            self.titleView.alpha        = 1;
            self.loadingBgView.alpha    = 1;
        }];
        
        if (distance >= 2 * kTransitionCenter) { // 刷新
            self.isRefreshing = YES;
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.loadingBgView.alpha = 0;
                self.isRefreshing = NO;
            });
        }else {
            self.loadingBgView.alpha = 0;
        }
    }else {
        if (distance < 0) {
            self.refreshView.alpha = 0;
            self.titleView.alpha = 1;
        }else if (distance > 0 && distance < kTransitionCenter) {
            CGFloat alpha = distance / kTransitionCenter;
            
            self.refreshView.alpha      = 0;
            self.titleView.alpha        = 1 - alpha;
            self.loadingBgView.alpha    = 0;
            
            // 位置改变
            CGRect frame = self.titleView.frame;
            frame.origin.y = kTitleViewY + distance;
            self.titleView.frame = frame;
            self.refreshView.frame = frame;
            
            CGRect loadingFrame = self.loadingBgView.frame;
            loadingFrame.origin.y = frame.origin.y;
            self.loadingBgView.frame = loadingFrame;
        }else if (distance >= kTransitionCenter && distance <= 2 * kTransitionCenter) {
            CGFloat alpha = (2 * kTransitionCenter - distance) / kTransitionCenter;
            
            self.refreshView.alpha      = 1 - alpha;
            self.titleView.alpha        = 0;
            self.loadingBgView.alpha    = 1 - alpha;
            
            // 位置改变
            CGRect frame = self.titleView.frame;
            frame.origin.y = kTitleViewY + distance;
            self.titleView.frame    = frame;
            self.refreshView.frame  = frame;
            
            CGRect loadingFrame = self.loadingBgView.frame;
            loadingFrame.origin.y = frame.origin.y;
            self.loadingBgView.frame = loadingFrame;
        }else {
            self.titleView.alpha    = 0;
            self.refreshView.alpha  = 1;
            self.loadingBgView.alpha = 1;
        }
    }
}

#pragma mark - 懒加载
- (MVVideoView *)videoView {
    if (!_videoView) {
        _videoView = [[MVVideoView alloc] initWithVC:self];
        _videoView.delegate = self;
    }
    return _videoView;
}

- (UIView *)titleView {
    if (!_titleView) {
        _titleView = [UIView new];
    }
    return _titleView;
}

- (UIView *)refreshView {
    if (!_refreshView) {
        _refreshView = [UIView new];
        _refreshView.backgroundColor = [UIColor clearColor];
        _refreshView.alpha = 0.0f;
    }
    return _refreshView;
}

- (UILabel *)refreshLabel {
    if (!_refreshLabel) {
        _refreshLabel = [UILabel new];
        _refreshLabel.font = [UIFont systemFontOfSize:16.0f];
        _refreshLabel.text = @"下拉刷新内容";
        _refreshLabel.textColor = [UIColor whiteColor];
    }
    return _refreshLabel;
}

@end
