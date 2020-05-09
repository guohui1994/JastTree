//
//  JTAppDelegate.h
//  ZY_JASTREE
//
//  Created by 郭军 on 2019/7/2.
//  Copyright © 2019 JG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JTAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

/** 标记网络状态  */
@property (nonatomic, assign)BOOL isReachable;

@end

