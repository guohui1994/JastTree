//
//  JGModelFileTool.h
//  FD_Rider
//
//  Created by 郭军 on 2019/3/29.
//  Copyright © 2019 zhiyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JGModelFileTool : NSObject


/**
 生成 Model 文件
 
 @param fileName 主 Model 文件名
 @param data 数据源 (字典/数组/json数据/json字符串/json文件名)
 */
+ (void)BeginCreateModelFileWithFileName:(NSString *)fileName andData:(id)data;



@end

NS_ASSUME_NONNULL_END
