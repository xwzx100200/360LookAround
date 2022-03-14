//
//  OutSideController.m
//  Test360LookCar
//
//  Created by chenbc on 2022/3/1.
//

#import "OutSideController.h"
#import <SDWebImage/SDWebImage.h>
#import <Masonry/Masonry.h>

@interface OutSideController ()
@property (nonatomic, assign) NSUInteger currentIndex;
@property (nonatomic, strong) NSArray<UIImageView*> *imageViews;
@property (nonatomic,strong)UIButton *backBtn;

@end

@implementation OutSideController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)initUI {
    UIPanGestureRecognizer *pan =
    [[UIPanGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(actionForPanGes:)];
    [self.view addGestureRecognizer:pan];
    [self.view addSubview:self.backBtn];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self load360Images];
}

- (void)actionForPanGes:(UIPanGestureRecognizer*)pan {
    static CGPoint lastPt;
    static NSInteger lastIndex = 0;
    CGPoint pt = [pan locationInView:self.view];
    if (pan.state == UIGestureRecognizerStateBegan) {
        lastPt = pt; // 锚定手势开始点
        lastIndex = _currentIndex;// 锚定手势开始索引
    } else if (pan.state == UIGestureRecognizerStateChanged) {
        CGFloat deltaX = pt.x - lastPt.x;// 手势划动距离
        CGFloat width = CGRectGetWidth(self.view.bounds)/3;// 设定划动1/3屏的距离对应为周长
        CGFloat moveRate = deltaX / width;// 计算划动距离相当于周长的百分比
        // 周长划分36份，把moveRate转化为moveIndex
        NSInteger moveIndex;
        //  取余数时需要纠正正负值
        if (moveRate < 0) {
            moveIndex = -(((NSInteger)fabs(moveRate*self.imageUrls.count)) % self.imageUrls.count);
        } else {
            moveIndex = ((NSInteger)(moveRate * self.imageUrls.count)) % self.imageUrls.count;
        }
        // 没有变动则不用继续处理了
        if (moveIndex != 0) {
            NSInteger targetIndex = 0;
            targetIndex = lastIndex + moveIndex;
            if (targetIndex < 0) {
                targetIndex = targetIndex + self.imageUrls.count; // 低于下限，修正目标索引
            } else if (targetIndex > (self.imageUrls.count - 1)) {
                targetIndex = targetIndex - self.imageUrls.count;// 高于上限，修正目标索引
            }
            
            [self showImageViewAtIndex:targetIndex];
        }
    }
}

/// 显示图像视图，不显示的图片会被释放
/// @param index 图片索引
- (void)showImageViewAtIndex:(NSUInteger)index {
    UIImageView *currentImageView = _imageViews[_currentIndex];
    
    currentImageView.hidden = YES;
    currentImageView.image = nil;
    
    currentImageView = _imageViews[index];
    currentImageView.hidden = NO;
    
    // 使用到的时候才加载
    NSString *urlString = self.imageUrls[index];
    NSURL *url = [NSURL URLWithString:urlString];
    [currentImageView sd_setImageWithURL:url placeholderImage:nil
                                 options:0];
    
    _currentIndex = index;
}

- (void)load360Images {
    // 根据imageUrls数量来创建对应的视图序列
    if (self.imageUrls.count > 0) {
        NSMutableArray<UIImageView*> *ar = [NSMutableArray array];
        for (int i = 0; i < self.imageUrls.count; i++) {
            [self.view addSubview:({
                UIImageView *imageView = [UIImageView new];
                [ar addObject:imageView];
                imageView.contentMode = UIViewContentModeScaleToFill;
                imageView.hidden = YES;
                
                imageView;
            })];
        }
        // 如果有旧的视图，先移除掉
        for (UIImageView* iv in self.imageViews) {
            [iv removeFromSuperview];
        }
        // 保存新的视图序列
        self.imageViews = [ar copy];
        
        // 开始请求数据
        
        dispatch_group_t gImageLoading = dispatch_group_create();
        NSString* itemUrl = nil;
        UIImageView* itemImageView = nil;
        for (int i = 0; i < self.imageUrls.count; i++) {
            itemUrl = self.imageUrls[i];
            itemImageView = self.imageViews[i];
            dispatch_group_enter(gImageLoading);
            [itemImageView sd_setImageWithURL:[NSURL URLWithString:itemUrl]
                                    completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                dispatch_group_leave(gImageLoading);
            }];
        }
        
        // 所有加载任务完成后
        __weak typeof(self)weakSelf = self;
        dispatch_group_notify(gImageLoading, dispatch_get_main_queue(), ^{
            __strong typeof(self)stongSelf = weakSelf;
            // 初始设置显示第一张
            [stongSelf showImageViewAtIndex:0];
            [stongSelf setUpConstraints];
        });
    }
}

#pragma mark - layout
- (void)setUpConstraints {
    
    for (UIImageView *imageView in _imageViews) {
        [imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.offset = 34;
            make.centerX.offset = 0;
            make.width.offset = 485*1.2f;
            make.height.offset = 273*1.2f;
        }];
    }
}


- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationLandscapeRight;
}

- (void)clickBackBtn {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIButton *)backBtn {
    if (!_backBtn) {
        _backBtn = [[UIButton alloc]initWithFrame:CGRectMake(50, 20, 50, 50)];
        [_backBtn setTitle:@"返回" forState:UIControlStateNormal];
        [_backBtn setTitleColor:UIColor.redColor forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(clickBackBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

@end
