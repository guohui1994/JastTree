//
//  ZYHttpApiConst.h
//  FD_Rider
//
//  Created by 郭军 on 2019/3/19.
//  Copyright © 2019年 zhiyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

//  注册登录 
UIKIT_EXTERN NSString * const JTUserLogin;
//  获取手机验证码
UIKIT_EXTERN NSString * const JTUserGetCode;
//  忘记密码
UIKIT_EXTERN NSString * const JTUserForgetPassword;
//  修改密码
UIKIT_EXTERN NSString * const JTUserChangePassword;
//  QQ微信第一次登录绑定手机号
UIKIT_EXTERN NSString * const JTUserFirstLogin;
//  修改手机号
UIKIT_EXTERN NSString * const JTUserChangeIphone;
//订单列表
UIKIT_EXTERN NSString * const JTOrderSelectUserOrderList;

//撤单
UIKIT_EXTERN NSString * const JTOrderRevokeOrder;
//删除订单
UIKIT_EXTERN NSString * const JTOrderDeleteUserOrder ;
//获取阿里云OSS上传凭证
UIKIT_EXTERN NSString * const JTSTSOSS;
//订单相亲
UIKIT_EXTERN NSString * const JTOrderDetails ;
//查询展览列表
UIKIT_EXTERN NSString * const JTExhibitionSelectList;
//返回省的json
UIKIT_EXTERN NSString * const JTProvinceData;
//上传物料图
UIKIT_EXTERN NSString * const JTOrderUploadMateriel;
//上传搭建图
UIKIT_EXTERN NSString * const JTOrderConstructUploadDrawing ;
//删除物料图
UIKIT_EXTERN NSString * const JTOrederDeleteMateriel ;
//删除搭建图
UIKIT_EXTERN NSString * const JTOrderConstructDeleteDrawing ;
//申请施工图
UIKIT_EXTERN NSString * const JTOrderDrawingApply;
//提交评价
UIKIT_EXTERN NSString * const JTOrderSubEvaluate;
//首页详情
UIKIT_EXTERN NSString * const JTExhibitionSelectExhibitionDetails ;
//提交报价
UIKIT_EXTERN NSString * const JTOrderQuotedPrice ;
//查询消息列表
UIKIT_EXTERN NSString * const JTMessageSelectList;
//查询消息未读数
UIKIT_EXTERN NSString * const JTMessageSelectUnread;
//消息已读
UIKIT_EXTERN NSString * const JTMessageRead;
//系统设置通过名称查询值
/*
 about_us   关于我们
 user_registration_service_agreement 用户注册服务协议
 
 start_figure 启动图
 start_figure_time  启动图持续时间（秒）
 */
UIKIT_EXTERN NSString * const JTSystemSelectValue;

//首页新加轮播图
UIKIT_EXTERN NSString * const JTHomeSlidehowSelectBanner;
//首页公告
UIKIT_EXTERN NSString * const JTHomeSystemSelectNotice;
//退出登录
UIKIT_EXTERN NSString * const OutLogin ;
