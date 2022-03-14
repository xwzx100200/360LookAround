//
//  InSideController.m
//  Test360LookCar
//
//  Created by chenbc on 2022/3/1.
//

#import "InSideController.h"
#import <SceneKit/SCNAction.h>
@import SceneKit;
#import <SDWebImage/SDWebImage.h>
#import <Masonry/Masonry.h>
#import "UIImage+YYAdd.h"
#import "UIGestureRecognizer+YYAdd.h"

@interface InSideController ()
@property (nonatomic,strong)UIButton *backBtn;
@property (nonatomic, strong) SCNView *sceneView;
@property (nonatomic, strong) UIPanGestureRecognizer *panGesRec;
@end

@implementation InSideController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.redColor;
    [self.view addSubview:self.sceneView];
    [self.view addSubview:self.backBtn];
    [self setupData];
}

- (void)setupData {
    
    [_sceneView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset = 0;
    }];
    
    [SDWebImageManager.sharedManager loadImageWithURL:[NSURL URLWithString:self.imageUrl]
                                              options:0
                                             progress:nil
                                            completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
        [self setupSceneWithImage:image];
    }];
}

#pragma mark - private
- (void)setupSceneWithImage:(UIImage*)image {
    SCNScene *scene = [SCNScene new];
    self.sceneView.scene = scene;
    // 球体节点
    SCNSphere *sphere = [SCNSphere sphereWithRadius:25];
    sphere.segmentCount = 96;// 球面经纬分区数量
    sphere.firstMaterial.doubleSided = YES;
    UIImage *content = [image imageByFlipHorizontal];
    sphere.firstMaterial.diffuse.contents = content; // 显示内容
    SCNNode *sphereNode = [SCNNode nodeWithGeometry:sphere];
    sphereNode.position = SCNVector3Make(0, 0, 0);
    [scene.rootNode addChildNode:sphereNode];
    
    // 摄像机节点
    SCNNode *cameraNode = [SCNNode new];
    cameraNode.camera = [SCNCamera new];
    cameraNode.position = SCNVector3Make(0, 0, 0);
    [scene.rootNode addChildNode:cameraNode];
    
    cameraNode.eulerAngles = SCNVector3Make(0, M_PI, 0);
    __weak typeof(self)weakSelf = self;
    UIPanGestureRecognizer *pan =
    [[UIPanGestureRecognizer alloc] initWithActionBlock:^(UIPanGestureRecognizer* _Nonnull pan) {
        __strong typeof(self)strongSelf = weakSelf;
        static CGPoint lastPt;
        static SCNVector3 lastV3;
        CGPoint pt = [pan locationInView:strongSelf.sceneView];
        if (pan.state == UIGestureRecognizerStateBegan) {
            lastPt = pt; // 锚定手势开始点
            lastV3 = cameraNode.eulerAngles;
        } else if (pan.state == UIGestureRecognizerStateChanged) {
            // 手势划动距离
            CGFloat deltaX = pt.x - lastPt.x;
            CGFloat deltaY = pt.y - lastPt.y;
            //设定宽高相当于180°
            CGFloat width = CGRectGetWidth(strongSelf.sceneView.bounds)/M_PI;
            CGFloat height = CGRectGetHeight(strongSelf.sceneView.bounds)/M_PI;
            // 计算偏移弧度
            CGFloat moveRadX = deltaX / width;
            CGFloat moveRadY = deltaY / height;
            
            cameraNode.eulerAngles = SCNVector3Make(lastV3.x+moveRadY,
                                                    lastV3.y+moveRadX,
                                                    lastV3.z);
        }
    }];
    pan.maximumNumberOfTouches = 1;
    
    [self.sceneView removeGestureRecognizer:self.panGesRec];
    [self.sceneView addGestureRecognizer:pan];
    self.panGesRec = pan;
    
    self.sceneView.hidden = NO;
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
        [_backBtn setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(clickBackBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

- (SCNView *)sceneView {
    if (!_sceneView) {
        _sceneView = [[SCNView alloc] initWithFrame:CGRectZero
                                            options:@{
            SCNViewOptionPreferredRenderingAPI: @(SCNRenderingAPIMetal),// 首选metal api
            SCNViewOptionPreferLowPowerDevice: @(YES)// 首选低功耗设备
        }];
        
        //_sceneView.showsStatistics = YES; // 显示状态
        
        _sceneView.hidden = YES;
        _sceneView.contentMode = UIViewContentModeCenter;
    }
    return _sceneView;
}

@end


/**
 数据源：
 "vrUrl":"https://xp-static-public-uat-frankfort.s3.eu-central-1.amazonaws.com/xp-ams/2022-03-02/xp/2/017f4875461a7f01695a2c9e02b9036f.jpg",
 */
