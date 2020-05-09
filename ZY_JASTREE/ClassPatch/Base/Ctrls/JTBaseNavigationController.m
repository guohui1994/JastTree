//
//  JTBaseNavigationController.m
//  ZY_JASTREE
//
//  Created by 郭军 on 2019/7/1.
//  Copyright © 2019 JG. All rights reserved.
//

#import "JTBaseNavigationController.h"

@interface JTBaseNavigationController ()

@end

@implementation JTBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.viewControllers.count>0) {
        viewController.hidesBottomBarWhenPushed = YES;//处理隐藏tabbar
        
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigator_btn_back" highIcon:@"no" target:self action:@selector(back:)];
        
    } else{
        
    }
    
    
    [super pushViewController:viewController animated:animated];
    
}


-(void)back:(UIBarButtonItem *)sender{
    [self.view endEditing:YES];
    
    UIViewController * currentVC = self.topViewController;
    if (currentVC.popBlock) {
        currentVC.popBlock(sender);
    }else{
        [self popViewControllerAnimated:YES];
    }
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
