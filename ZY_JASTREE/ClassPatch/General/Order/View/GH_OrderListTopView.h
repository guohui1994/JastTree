//
//  GH_OrderListTopView.h
//  ZY_JASTREE
//
//  Created by ZhiYuan on 2019/7/3.
//  Copyright © 2019 JG. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef void(^selectIndex)(int index);

@interface GH_OrderListTopView : UIView

@property (nonatomic, strong)selectIndex block;

- (void)creatUI;

@end


