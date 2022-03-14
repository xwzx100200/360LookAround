//
//  AppDelegate.m
//  Test360LookCar
//
//  Created by chenbc on 2022/3/1.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    ViewController * vc = [[ViewController alloc]init];
    self.window = [[UIWindow alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
    return YES;
}


- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(nullable UIWindow *)window {
    return UIInterfaceOrientationMaskAllButUpsideDown;
}


@end
