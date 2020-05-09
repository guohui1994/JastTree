//
//  JTBaseTabBarController.m
//  ZY_JASTREE
//
//  Created by 郭军 on 2019/7/1.
//  Copyright © 2019 JG. All rights reserved.
//

#import "JTBaseTabBarController.h"

#import "JTBaseNavigationController.h"

#import "JTHomeViewController.h"
#import "JTOrderViewController.h"
#import "JTMineViewController.h"
#import "JTMessageViewController.h"
@interface JTBaseTabBarController ()

@end

@implementation JTBaseTabBarController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [UITabBar appearance].translucent = NO;

    //创建子控制器
    [self setUpChildViewControllers];
}


/**
 *  创建子控制器
 */
- (void)setUpChildViewControllers {
    
    [self setupChildVc:[[JTHomeViewController alloc] init] title:@"首页" image:@"tabbar_home_nor"  selectedImage:@"tabbar_home_sel"];
    
    
    [self setupChildVc:[[JTOrderViewController alloc] init] title:@"订单" image:@"tabbar_order_nor"  selectedImage:@"tabbar_order_sel"];
    
    [self setupChildVc:[[JTMessageViewController alloc] init] title:@"消息" image:@"tabbar_Message_nor"  selectedImage:@"tabbar_Message_sel"];
    
    [self setupChildVc:[[JTMineViewController alloc] init] title: @"个人中心" image:@"tabbar_mine_nor" selectedImage:@"tabbar_mine_sel"];
}


/**
 *  初始化控制器
 *
 *  @param vc            控制器
 *  @param title         标题
 *  @param image         图片
 *  @param selectedImage 选中图片
 */
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    
    //    vc.tabBarItem.title = title;
    vc.title = title;
    
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:JGHexColor(@"#e54b4b")} forState:UIControlStateSelected];
    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];
//    [vc.tabBarItem setImageInsets:UIEdgeInsetsMake(6, 0, -6, 0)];
    //包装一个导航控制器
    JTBaseNavigationController *nav = [[JTBaseNavigationController alloc] initWithRootViewController:vc];
    //隐藏tabbar
    [self addChildViewController:nav];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
