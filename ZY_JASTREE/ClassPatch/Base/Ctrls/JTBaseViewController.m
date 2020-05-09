//
//  JTBaseViewController.m
//  ZY_JASTREE
//
//  Created by 郭军 on 2019/7/1.
//  Copyright © 2019 JG. All rights reserved.
//

#import "JTBaseViewController.h"

@interface JTBaseViewController ()

@end

@implementation JTBaseViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar jg_reset];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:JGFont(18), NSForegroundColorAttributeName:JG333Color}];
    
    if (self.navColor) {
        [self.navigationController.navigationBar jg_setBackgroundColor:self.navColor isHiddenBottomBlackLine:YES];
    }else{
        [self.navigationController.navigationBar jg_setBackgroundColor:[UIColor whiteColor] isHiddenBottomBlackLine:YES];
    }
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    
    self.navColor = [self.navigationController.navigationBar jg_getBackgroundColor];
    [self.navigationController.navigationBar jg_reset];
}





- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:JGFont(18), NSForegroundColorAttributeName:JG333Color}];
    
    
    [self configUI];
    
}

- (void)configUI {}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
