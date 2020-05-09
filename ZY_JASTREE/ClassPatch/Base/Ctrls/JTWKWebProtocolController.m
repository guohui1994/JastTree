//
//  JTWKWebProtocolController.m
//  ZY_JASTREE
//
//  Created by 郭军 on 2019/7/12.
//  Copyright © 2019 JG. All rights reserved.
//

#import "JTWKWebProtocolController.h"

@interface JTWKWebProtocolController ()

@end

@implementation JTWKWebProtocolController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma  mark - updata nav items
- (void)updataNavigationitems {
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigator_btn_back" highIcon:nil target:self action:@selector(leftBarButtonItemClick)];
}


- (void)leftBarButtonItemClick {
    
    [self.navigationController popViewControllerAnimated:YES];
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
