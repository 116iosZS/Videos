//
//  MVCommentView.m
//  Videos
//
//  Created by 胡学礼 on 2020/9/22.
//

#import "MVCommentView.h"

@interface MVCommentView ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UIVisualEffectView    *effectView;
@property (nonatomic, strong) UIView                *topView;
@property (nonatomic, strong) UILabel               *countLabel;
@property (nonatomic, strong) UIButton              *closeBtn;

@property (nonatomic, strong) UITableView           *tableView;

@property (nonatomic, assign) NSInteger             count;

@property (nonatomic, strong) MVCommentViewModel* viewModel;

@property (nonatomic, strong) UIView               *bottomView;
@property (nonatomic, strong) UITextField          *inputTextView;
@property (nonatomic, strong) UIButton             *bottomSendBtn;
@end

@implementation MVCommentView
- (instancetype)initWithViewModel:(MVCommentViewModel *)viewmodel{
    if (self = [super init]) {
        _viewModel = viewmodel;
        
        [self commInit];
    }
    return self;
}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
- (void)commInit{
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
    
    [self addSubview:self.topView];
    [self addSubview:self.effectView];
    [self addSubview:self.countLabel];
    [self addSubview:self.closeBtn];
    [self addSubview:self.tableView];
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.mas_equalTo(ADAPTATIONRATIO * 100.0f);
    }];
    
    [self.effectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.topView);
    }];
    
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.topView);
        make.right.equalTo(self).offset(-ADAPTATIONRATIO * 16.0f);
        make.width.height.mas_equalTo(ADAPTATIONRATIO * 36.0f);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self).offset(-SAFEAREA_BTM);
        make.height.mas_equalTo(50);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self.bottomView.mas_top);
        make.top.equalTo(self.topView.mas_bottom);
    }];
    
    self.countLabel.text = [NSString stringWithFormat:@"%zd comments", self.count];
}

- (void)requestData {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        self.count = arc4random_uniform(30);
        self.countLabel.text = [NSString stringWithFormat:@"%zd comments", self.count];
        [self.tableView reloadData];
    });
}

#pragma mark - <UITableViewDataSource, UITableViewDelegate>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [NSString stringWithFormat:@"comment : %ld", indexPath.row+1];
    cell.textLabel.textColor = [UIColor whiteColor];
    return cell;
}

#pragma mark - 懒加载
- (UIVisualEffectView *)effectView {
    if (!_effectView) {
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        _effectView = [[UIVisualEffectView alloc] initWithEffect:blur];
    }
    return _effectView;
}

- (UIView *)topView {
    if (!_topView) {
        _topView = [UIView new];
        _topView.backgroundColor = GKColorGray(50);
        
        CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, ADAPTATIONRATIO * 100.0f);
        
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:frame byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
        
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        //设置大小
        maskLayer.frame = frame;
        
        //设置图形样子
        maskLayer.path = maskPath.CGPath;
        
        _topView.layer.mask = maskLayer;
    }
    return _topView;
}

- (UILabel *)countLabel {
    if (!_countLabel) {
        _countLabel = [UILabel new];
        _countLabel.font = [UIFont systemFontOfSize:17.0f];
        _countLabel.textColor = [UIColor whiteColor];
    }
    return _countLabel;
}

- (UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [UIButton new];
        [_closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(onClickClosed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        _tableView.rowHeight = ADAPTATIONRATIO * 120.0f;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedRowHeight = 0;
        _tableView.backgroundColor = GKColorGray(70);
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
    }
    return _tableView;
}

- (UITextField*)inputTextView{
    if (!_inputTextView) {
        _inputTextView = [UITextField new];
        _inputTextView.delegate = self;
        _inputTextView.textColor = GKColorGray(200);
        _inputTextView.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"say something~" attributes:@{
            NSFontAttributeName:[UIFont systemFontOfSize:14],
            NSForegroundColorAttributeName:UIColor.lightGrayColor
        }];
    }
    return _inputTextView;
}

- (UIButton*)bottomSendBtn{
    if (!_bottomSendBtn) {
        _bottomSendBtn = [UIButton new];
        [_bottomSendBtn setTitle:@"Send" forState:UIControlStateNormal];
        [_bottomSendBtn addTarget:self action:@selector(onClickSend:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomSendBtn;
}

- (UIView*)bottomView{
    if (!_bottomView) {
        _bottomView = [UIView new];
        _bottomView.backgroundColor = GKColorGray(50);
        [self addSubview:_bottomView];
        [_bottomView addSubview:self.bottomSendBtn];
        [self.bottomSendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.inset(4);
            make.right.inset(16);
            make.width.equalTo(@(50));
        }];
        
        [_bottomView addSubview:self.inputTextView];
        [self.inputTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(_bottomView).offset(4);
            make.left.inset(16);
            make.right.equalTo(self.bottomSendBtn.mas_left).offset(-16);
        }];
        
    }
    return _bottomView;
}

#pragma mark - UITextView Delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{

    return YES;
}

#pragma mark - Events
- (void)onClickClosed:(id)sender{
    if(self.delegate && [self.delegate respondsToSelector:@selector(contentViewDismiss:)]){
        [self.delegate contentViewDismiss:self];
    }
}

- (void)onClickSend:(id)sender{
    [self.inputTextView resignFirstResponder];
}

@end
