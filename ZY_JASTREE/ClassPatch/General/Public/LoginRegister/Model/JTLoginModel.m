//
//  JTLoginModel.m
//  ZY_JASTREE
//
//  Created by 郭军 on 2019/7/8.
//  Copyright © 2019 JG. All rights reserved.
//

#import "JTLoginModel.h"

@implementation JTLoginModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"user_id" : @"id"};
}



- (void)saveUserInfo {
    
    [JGCommonTools saveToUserDefaults:self.user_id key:@"user_id"];
    [JGCommonTools saveToUserDefaults:self.token key:@"token"];
    [JGCommonTools saveToUserDefaults:self.nickName key:@"nickName"];
    [JGCommonTools saveToUserDefaults:self.head key:@"head"];
    [JGCommonTools saveToUserDefaults:self.phone key:@"phone"];
}



@end
