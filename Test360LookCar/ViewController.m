//
//  ViewController.m
//  Test360LookCar
//
//  Created by chenbc on 2022/3/1.
//

#import "ViewController.h"
#import "InSideController.h"
#import "OutSideController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *outSideBtn = [[UIButton alloc]initWithFrame:CGRectMake(100,100, 100, 100)];
    outSideBtn.backgroundColor = [UIColor redColor];
    [outSideBtn setTitle:@"外饰" forState:UIControlStateNormal];
    [outSideBtn addTarget:self action:@selector(clickOutSide) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:outSideBtn];
    
    UIButton *inSideBtn = [[UIButton alloc]initWithFrame:CGRectMake(100,250, 100, 100)];
    inSideBtn.backgroundColor = [UIColor redColor];
    [inSideBtn setTitle:@"内饰" forState:UIControlStateNormal];
    [inSideBtn addTarget:self action:@selector(clickInSideBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:inSideBtn];
}

- (void)clickOutSide {
    OutSideController *vc = [[OutSideController alloc]init];
    vc.imageUrls = [self getOutSideUrlArr];
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)clickInSideBtn {
    InSideController *vc = [[InSideController alloc]init];
    vc.imageUrl = @"https://xp-static-public-uat-frankfort.s3.eu-central-1.amazonaws.com/xp-ams/2022-03-02/xp/2/017f4875461a7f01695a2c9e02b9036f.jpg";
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:vc animated:YES completion:nil];
}

- (NSArray *)getOutSideUrlArr {
    return @[
        @"https://xp-static-public-uat-frankfort.s3.eu-central-1.amazonaws.com/xp-ams/2022-02-25/xp/2/017f2ebe4dfe7f0165492c9e01f60271.png",
        @"https://xp-static-public-uat-frankfort.s3.eu-central-1.amazonaws.com/xp-ams/2022-02-25/xp/2/017f2ebe1b917f01654a2c9e07630291.png",
        @"https://xp-static-public-uat-frankfort.s3.eu-central-1.amazonaws.com/xp-ams/2022-02-25/xp/2/017f2ebde84e7f01695a2c9e02b9029f.png",
        @"https://xp-static-public-uat-frankfort.s3.eu-central-1.amazonaws.com/xp-ams/2022-02-25/xp/2/017f2ebdbef57f0165492c9e01f6026f.png",
        @"https://xp-static-public-uat-frankfort.s3.eu-central-1.amazonaws.com/xp-ams/2022-02-25/xp/2/017f2ebd6d687f01654a2c9e0763028f.png",
        @"https://xp-static-public-uat-frankfort.s3.eu-central-1.amazonaws.com/xp-ams/2022-02-25/xp/2/017f2ebd3c0c7f01695a2c9e02b9029d.png",
        @"https://xp-static-public-uat-frankfort.s3.eu-central-1.amazonaws.com/xp-ams/2022-02-25/xp/2/017f2ebd0aa37f0165492c9e01f6026d.png",
        @"https://xp-static-public-uat-frankfort.s3.eu-central-1.amazonaws.com/xp-ams/2022-02-25/xp/2/017f2ebccfe37f01654a2c9e0763028d.png",
        @"https://xp-static-public-uat-frankfort.s3.eu-central-1.amazonaws.com/xp-ams/2022-02-25/xp/2/017f2ebca7a27f01695a2c9e02b9029b.png",
        @"https://xp-static-public-uat-frankfort.s3.eu-central-1.amazonaws.com/xp-ams/2022-02-25/xp/2/017f2ebc7cc07f0165492c9e01f6026b.png",
        @"https://xp-static-public-uat-frankfort.s3.eu-central-1.amazonaws.com/xp-ams/2022-02-25/xp/2/017f2ebc54247f01654a2c9e0763028b.png",
        @"https://xp-static-public-uat-frankfort.s3.eu-central-1.amazonaws.com/xp-ams/2022-02-25/xp/2/017f2ebc22ab7f01695a2c9e02b90299.png",
        @"https://xp-static-public-uat-frankfort.s3.eu-central-1.amazonaws.com/xp-ams/2022-02-25/xp/2/017f2ebbdcd67f0165492c9e01f60269.png",
        @"https://xp-static-public-uat-frankfort.s3.eu-central-1.amazonaws.com/xp-ams/2022-02-25/xp/2/017f2ebba4817f01654a2c9e07630289.png",
        @"https://xp-static-public-uat-frankfort.s3.eu-central-1.amazonaws.com/xp-ams/2022-02-25/xp/2/017f2ebb78537f01695a2c9e02b90297.png",
        @"https://xp-static-public-uat-frankfort.s3.eu-central-1.amazonaws.com/xp-ams/2022-02-25/xp/2/017f2ebb52977f0165492c9e01f60267.png",
        @"https://xp-static-public-uat-frankfort.s3.eu-central-1.amazonaws.com/xp-ams/2022-02-25/xp/2/017f2ebb24837f01654a2c9e07630287.png",
        @"https://xp-static-public-uat-frankfort.s3.eu-central-1.amazonaws.com/xp-ams/2022-02-25/xp/2/017f2ebaca607f01695a2c9e02b90295.png",
        @"https://xp-static-public-uat-frankfort.s3.eu-central-1.amazonaws.com/xp-ams/2022-02-25/xp/2/017f2eba9ff27f0165492c9e01f60265.png",
        @"https://xp-static-public-uat-frankfort.s3.eu-central-1.amazonaws.com/xp-ams/2022-02-25/xp/2/017f2eba1edb7f01654a2c9e07630285.png",
        @"https://xp-static-public-uat-frankfort.s3.eu-central-1.amazonaws.com/xp-ams/2022-02-25/xp/2/017f2eb9d64a7f01695a2c9e02b90293.png",
        @"https://xp-static-public-uat-frankfort.s3.eu-central-1.amazonaws.com/xp-ams/2022-02-25/xp/2/017f2eb9a0c87f0165492c9e01f60263.png",
        @"https://xp-static-public-uat-frankfort.s3.eu-central-1.amazonaws.com/xp-ams/2022-02-25/xp/2/017f2eb96c897f01654a2c9e07630283.png",
        @"https://xp-static-public-uat-frankfort.s3.eu-central-1.amazonaws.com/xp-ams/2022-02-25/xp/2/017f2eb923bc7f01695a2c9e02b90291.png",
        @"https://xp-static-public-uat-frankfort.s3.eu-central-1.amazonaws.com/xp-ams/2022-02-25/xp/2/017f2eb8eab17f0165492c9e01f60261.png",
        @"https://xp-static-public-uat-frankfort.s3.eu-central-1.amazonaws.com/xp-ams/2022-02-25/xp/2/017f2eb8c6f07f01654a2c9e07630281.png",
        @"https://xp-static-public-uat-frankfort.s3.eu-central-1.amazonaws.com/xp-ams/2022-02-25/xp/2/017f2eb891347f01695a2c9e02b9028f.png",
        @"https://xp-static-public-uat-frankfort.s3.eu-central-1.amazonaws.com/xp-ams/2022-02-25/xp/2/017f2eb85e857f0165492c9e01f6025f.png",
        @"https://xp-static-public-uat-frankfort.s3.eu-central-1.amazonaws.com/xp-ams/2022-02-25/xp/2/017f2eb825e77f01654a2c9e0763027f.png",
        @"https://xp-static-public-uat-frankfort.s3.eu-central-1.amazonaws.com/xp-ams/2022-02-25/xp/2/017f2eb7ece67f01695a2c9e02b9028d.png",
        @"https://xp-static-public-uat-frankfort.s3.eu-central-1.amazonaws.com/xp-ams/2022-02-25/xp/2/017f2eb6e99d7f0165492c9e01f6025d.png",
        @"https://xp-static-public-uat-frankfort.s3.eu-central-1.amazonaws.com/xp-ams/2022-02-25/xp/2/017f2eb6a8577f01654a2c9e0763027d.png",
        @"https://xp-static-public-uat-frankfort.s3.eu-central-1.amazonaws.com/xp-ams/2022-02-25/xp/2/017f2eb66ff67f01695a2c9e02b9028b.png",
        @"https://xp-static-public-uat-frankfort.s3.eu-central-1.amazonaws.com/xp-ams/2022-02-25/xp/2/017f2eb6444e7f0165492c9e01f6025b.png",
        @"https://xp-static-public-uat-frankfort.s3.eu-central-1.amazonaws.com/xp-ams/2022-02-25/xp/2/017f2eb61eed7f01654a2c9e0763027b.png",
        @"https://xp-static-public-uat-frankfort.s3.eu-central-1.amazonaws.com/xp-ams/2022-02-25/xp/2/017f2eb5e1c07f01695a2c9e02b90289.png"];
}


@end
